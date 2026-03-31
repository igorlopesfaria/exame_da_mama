import 'package:commons_observability/api/i_tracer.dart';
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
    sut = ObservabilityImpl(vendor: vendor, minLogLevel: LogLevel.info);

    when(() => vendor.log(any())).thenReturn(null);
    when(() => vendor.recordError(any())).thenReturn(null);
    when(() => vendor.startSpan(any(), any())).thenReturn(_FakeSpanHandle());
    when(() => vendor.finishSpan(any())).thenReturn(null);
    when(() => vendor.markSpanError(any(), any())).thenReturn(null);
    when(() => vendor.setUserIdentifier(any())).thenReturn(null);
    when(() => vendor.setCustomKey(any(), any())).thenReturn(null);
    when(() => vendor.setCollectionEnabled(any())).thenReturn(null);
  });

  group('Logger — level filtering', () {
    test('drops VERBOSE log when minLogLevel is INFO', () {
      sut.logger.verbose('should.be.dropped');
      verifyNever(() => vendor.log(any()));
      verifyNever(() => vendor.recordError(any()));
    });

    test('drops DEBUG log when minLogLevel is INFO', () {
      sut.logger.debug('should.be.dropped');
      verifyNever(() => vendor.log(any()));
      verifyNever(() => vendor.recordError(any()));
    });

    test('sends INFO log to vendor.log', () {
      sut.logger.info('user.login.success');
      verify(() => vendor.log(any())).called(1);
    });

    test('sends WARN log to vendor.log', () {
      sut.logger.warn('session.expiring');
      verify(() => vendor.log(any())).called(1);
    });

    test('sends ERROR log to vendor.recordError', () {
      sut.logger.error('payment.failed', throwable: Exception('timeout'));
      verify(() => vendor.recordError(any())).called(1);
      verifyNever(() => vendor.log(any()));
    });

    test('sends FATAL log to vendor.recordError with fatal=true', () {
      sut.logger.fatal('app.crash', throwable: Exception('OOM'));

      final captured = verify(() => vendor.recordError(captureAny())).captured;
      final event = captured.first as LogEvent;
      expect(event.level, LogLevel.fatal);
    });
  });

  group('Logger — PII sanitization', () {
    test('strips attributes whose keys contain PII terms', () {
      sut.logger.info('user.action', attributes: {
        'action': 'checkout',
        'email': 'user@example.com',
        'token': 'abc123',
        'password': 'secret',
        'user_id': '42',
        'cpf': '123.456.789-00',
      });

      final captured = verify(() => vendor.log(captureAny())).captured;
      final event = captured.first as LogEvent;

      expect(event.attributes.containsKey('action'), isTrue);
      expect(event.attributes.containsKey('email'), isFalse);
      expect(event.attributes.containsKey('token'), isFalse);
      expect(event.attributes.containsKey('password'), isFalse);
      expect(event.attributes.containsKey('user_id'), isFalse);
      expect(event.attributes.containsKey('cpf'), isFalse);
    });

    test('strips keys that contain PII terms as substrings', () {
      sut.logger.info('event', attributes: {'userToken': 'xyz', 'orderId': '99'});

      final captured = verify(() => vendor.log(captureAny())).captured;
      final event = captured.first as LogEvent;

      expect(event.attributes.containsKey('userToken'), isFalse);
      expect(event.attributes.containsKey('orderId'), isTrue);
    });

    test('truncates string attribute values longer than 512 chars', () {
      final longValue = 'x' * 600;
      sut.logger.info('event', attributes: {'description': longValue});

      final captured = verify(() => vendor.log(captureAny())).captured;
      final event = captured.first as LogEvent;

      expect((event.attributes['description'] as String).length, 512);
    });
  });

  group('Logger — event content', () {
    test('preserves event name in LogEvent', () {
      sut.logger.info('catalog.list.success', attributes: {'count': 10});

      final captured = verify(() => vendor.log(captureAny())).captured;
      final event = captured.first as LogEvent;

      expect(event.event, 'catalog.list.success');
      expect(event.level, LogLevel.info);
      expect(event.attributes['count'], 10);
    });

    test('forwards throwable and stackTrace on error', () {
      final ex = Exception('network error');
      final st = StackTrace.current;

      sut.logger.error('request.failed', throwable: ex, stackTrace: st);

      final captured = verify(() => vendor.recordError(captureAny())).captured;
      final event = captured.first as LogEvent;

      expect(event.throwable, ex);
      expect(event.stackTrace, st);
    });
  });

  group('IObservability — user context', () {
    test('setUserIdentifier delegates to vendor', () {
      sut.setUserIdentifier('hashed_abc123');
      verify(() => vendor.setUserIdentifier('hashed_abc123')).called(1);
    });

    test('setCustomKey delegates to vendor', () {
      sut.setCustomKey('app_flavor', 'staging');
      verify(() => vendor.setCustomKey('app_flavor', 'staging')).called(1);
    });

    test('setCollectionEnabled delegates to vendor', () {
      sut.setCollectionEnabled(false);
      verify(() => vendor.setCollectionEnabled(false)).called(1);
    });
  });

  group('Tracer — span lifecycle', () {
    test('finishSpan is always called even when block throws', () {
      expect(
        () => sut.tracer.trace('risky.op', block: () => throw Exception('boom')),
        throwsException,
      );
      verify(() => vendor.finishSpan(any())).called(1);
    });

    test('markSpanError is called when block throws', () {
      expect(
        () => sut.tracer.trace('op', block: () => throw Exception('err')),
        throwsException,
      );
      verify(() => vendor.markSpanError(any(), any())).called(1);
    });

    test('returns block result on success', () {
      final result = sut.tracer.trace('op', block: () => 42);
      expect(result, 42);
    });
  });

  group('Metrics — no-op', () {
    test('counter does not throw', () {
      expect(() => sut.metrics.counter('event.success'), returnsNormally);
    });

    test('gauge does not throw', () {
      expect(() => sut.metrics.gauge('queue.size', value: 10.0), returnsNormally);
    });

    test('histogram does not throw', () {
      expect(() => sut.metrics.histogram('request.duration', value: 230.0), returnsNormally);
    });
  });
}
