import 'package:commons_observability/api/i_tracer.dart';
import 'package:commons_observability/extensions/observability_monitor.dart';
import 'package:commons_observability/impl/observability_impl.dart';
import 'package:commons_observability/model/log_event.dart';
import 'package:commons_observability/model/log_level.dart';
import 'package:commons_observability/vendor/i_vendor_provider.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockVendorProvider extends Mock implements IVendorProvider {}

class _FakeSpanHandle extends Fake implements SpanHandle {}

class _FakeLogEvent extends Fake implements LogEvent {}

void main() {
  setUpAll(() {
    registerFallbackValue(_FakeLogEvent());
    registerFallbackValue(_FakeSpanHandle());
  });

  late _MockVendorProvider vendor;
  late ObservabilityImpl sut;

  setUp(() {
    vendor = _MockVendorProvider();
    sut = ObservabilityImpl(vendor: vendor, minLogLevel: LogLevel.debug);

    when(() => vendor.log(any())).thenReturn(null);
    when(() => vendor.recordError(any())).thenReturn(null);
    when(() => vendor.startSpan(any(), any())).thenReturn(_FakeSpanHandle());
    when(() => vendor.finishSpan(any())).thenReturn(null);
    when(() => vendor.markSpanError(any(), any())).thenReturn(null);
    when(() => vendor.setCollectionEnabled(any())).thenReturn(null);
  });

  group('monitor — success path', () {
    test('returns the block result', () {
      final result = sut.monitor('catalog.list', block: () => 42);
      expect(result, 42);
    });

    test('returns null when block returns void', () {
      expect(
        () => sut.monitor('some.op', block: () {}),
        returnsNormally,
      );
    });

    test('logs operation.success at INFO level', () {
      sut.monitor('checkout.process', block: () {});

      final captured = verify(() => vendor.log(captureAny())).captured;
      final successEvent = captured.last as LogEvent;

      expect(successEvent.event, 'checkout.process.success');
      expect(successEvent.level, LogLevel.info);
    });

    test('forwards attributes to success log', () {
      sut.monitor(
        'cart.addProduct',
        attributes: {'productId': 'sku-99', 'price': 49.9},
        block: () {},
      );

      final captured = verify(() => vendor.log(captureAny())).captured;
      final event = captured.last as LogEvent;

      expect(event.attributes['productId'], 'sku-99');
      expect(event.attributes['price'], 49.9);
    });

    test('starts and finishes a span with the operation name', () {
      sut.monitor('catalog.list', block: () {});

      verify(() => vendor.startSpan('catalog.list', any())).called(1);
      verify(() => vendor.finishSpan(any())).called(1);
    });
  });

  group('monitor — failure path', () {
    test('rethrows the exception from block', () {
      expect(
        () => sut.monitor('payment.process', block: () => throw Exception('timeout')),
        throwsA(isA<Exception>()),
      );
    });

    test('logs operation.failed at ERROR level', () {
      expect(
        () => sut.monitor('checkout.process', block: () => throw Exception('gateway error')),
        throwsException,
      );

      final captured = verify(() => vendor.recordError(captureAny())).captured;
      final event = captured.first as LogEvent;

      expect(event.event, 'checkout.process.failed');
      expect(event.level, LogLevel.error);
    });

    test('includes errorMessage in failure log attributes', () {
      expect(
        () => sut.monitor('payment.process', block: () => throw Exception('network timeout')),
        throwsException,
      );

      final captured = verify(() => vendor.recordError(captureAny())).captured;
      final event = captured.first as LogEvent;

      expect(event.attributes['errorMessage'], contains('network timeout'));
    });

    test('includes exceptionType in failure log attributes', () {
      expect(
        () => sut.monitor('payment.process', block: () => throw StateError('bad state')),
        throwsStateError,
      );

      final captured = verify(() => vendor.recordError(captureAny())).captured;
      final event = captured.first as LogEvent;

      expect(event.attributes['exceptionType'], 'StateError');
    });

    test('merges caller attributes into failure log', () {
      expect(
        () => sut.monitor(
          'cart.addProduct',
          attributes: {'productId': 'sku-42'},
          block: () => throw Exception('out of stock'),
        ),
        throwsException,
      );

      final captured = verify(() => vendor.recordError(captureAny())).captured;
      final event = captured.first as LogEvent;

      expect(event.attributes['productId'], 'sku-42');
      expect(event.attributes['errorMessage'], isNotNull);
    });

    test('finishSpan is always called even when block throws', () {
      expect(
        () => sut.monitor('risky.op', block: () => throw Exception('boom')),
        throwsException,
      );

      verify(() => vendor.finishSpan(any())).called(1);
    });

    test('does not call vendor.log on failure (goes to recordError)', () {
      expect(
        () => sut.monitor('op', block: () => throw Exception()),
        throwsException,
      );

      verifyNever(() => vendor.log(any()));
      verify(() => vendor.recordError(any())).called(1);
    });
  });

  group('monitor — span always closes', () {
    test('finishSpan called once on success', () {
      sut.monitor('op', block: () => 'ok');
      verify(() => vendor.finishSpan(any())).called(1);
    });

    test('finishSpan called once on failure', () {
      expect(
        () => sut.monitor('op', block: () => throw Exception()),
        throwsException,
      );
      verify(() => vendor.finishSpan(any())).called(1);
    });

    test('startSpan is called with the operation name', () {
      sut.monitor('user.profile.load', block: () {});
      verify(() => vendor.startSpan('user.profile.load', any())).called(1);
    });
  });
}
