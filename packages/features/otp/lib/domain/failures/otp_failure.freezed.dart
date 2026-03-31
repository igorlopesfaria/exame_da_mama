// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$OtpFailure {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpFailure);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpFailure()';
}


}

/// @nodoc
class $OtpFailureCopyWith<$Res>  {
$OtpFailureCopyWith(OtpFailure _, $Res Function(OtpFailure) __);
}


/// Adds pattern-matching-related methods to [OtpFailure].
extension OtpFailurePatterns on OtpFailure {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InvalidCode value)?  invalidCode,TResult Function( ExpiredCode value)?  expiredCode,TResult Function( TooManyAttempts value)?  tooManyAttempts,TResult Function( ServerError value)?  serverError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InvalidCode() when invalidCode != null:
return invalidCode(_that);case ExpiredCode() when expiredCode != null:
return expiredCode(_that);case TooManyAttempts() when tooManyAttempts != null:
return tooManyAttempts(_that);case ServerError() when serverError != null:
return serverError(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InvalidCode value)  invalidCode,required TResult Function( ExpiredCode value)  expiredCode,required TResult Function( TooManyAttempts value)  tooManyAttempts,required TResult Function( ServerError value)  serverError,}){
final _that = this;
switch (_that) {
case InvalidCode():
return invalidCode(_that);case ExpiredCode():
return expiredCode(_that);case TooManyAttempts():
return tooManyAttempts(_that);case ServerError():
return serverError(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InvalidCode value)?  invalidCode,TResult? Function( ExpiredCode value)?  expiredCode,TResult? Function( TooManyAttempts value)?  tooManyAttempts,TResult? Function( ServerError value)?  serverError,}){
final _that = this;
switch (_that) {
case InvalidCode() when invalidCode != null:
return invalidCode(_that);case ExpiredCode() when expiredCode != null:
return expiredCode(_that);case TooManyAttempts() when tooManyAttempts != null:
return tooManyAttempts(_that);case ServerError() when serverError != null:
return serverError(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  invalidCode,TResult Function()?  expiredCode,TResult Function()?  tooManyAttempts,TResult Function()?  serverError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InvalidCode() when invalidCode != null:
return invalidCode();case ExpiredCode() when expiredCode != null:
return expiredCode();case TooManyAttempts() when tooManyAttempts != null:
return tooManyAttempts();case ServerError() when serverError != null:
return serverError();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  invalidCode,required TResult Function()  expiredCode,required TResult Function()  tooManyAttempts,required TResult Function()  serverError,}) {final _that = this;
switch (_that) {
case InvalidCode():
return invalidCode();case ExpiredCode():
return expiredCode();case TooManyAttempts():
return tooManyAttempts();case ServerError():
return serverError();}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  invalidCode,TResult? Function()?  expiredCode,TResult? Function()?  tooManyAttempts,TResult? Function()?  serverError,}) {final _that = this;
switch (_that) {
case InvalidCode() when invalidCode != null:
return invalidCode();case ExpiredCode() when expiredCode != null:
return expiredCode();case TooManyAttempts() when tooManyAttempts != null:
return tooManyAttempts();case ServerError() when serverError != null:
return serverError();case _:
  return null;

}
}

}

/// @nodoc


class InvalidCode implements OtpFailure {
  const InvalidCode();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvalidCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpFailure.invalidCode()';
}


}




/// @nodoc


class ExpiredCode implements OtpFailure {
  const ExpiredCode();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExpiredCode);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpFailure.expiredCode()';
}


}




/// @nodoc


class TooManyAttempts implements OtpFailure {
  const TooManyAttempts();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TooManyAttempts);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpFailure.tooManyAttempts()';
}


}




/// @nodoc


class ServerError implements OtpFailure {
  const ServerError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServerError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'OtpFailure.serverError()';
}


}




// dart format on
