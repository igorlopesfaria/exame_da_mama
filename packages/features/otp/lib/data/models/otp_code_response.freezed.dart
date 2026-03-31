// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'otp_code_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OtpCodeResponse {

@JsonKey(name: 'verification_token') String get verificationToken;
/// Create a copy of OtpCodeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OtpCodeResponseCopyWith<OtpCodeResponse> get copyWith => _$OtpCodeResponseCopyWithImpl<OtpCodeResponse>(this as OtpCodeResponse, _$identity);

  /// Serializes this OtpCodeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OtpCodeResponse&&(identical(other.verificationToken, verificationToken) || other.verificationToken == verificationToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verificationToken);

@override
String toString() {
  return 'OtpCodeResponse(verificationToken: $verificationToken)';
}


}

/// @nodoc
abstract mixin class $OtpCodeResponseCopyWith<$Res>  {
  factory $OtpCodeResponseCopyWith(OtpCodeResponse value, $Res Function(OtpCodeResponse) _then) = _$OtpCodeResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'verification_token') String verificationToken
});




}
/// @nodoc
class _$OtpCodeResponseCopyWithImpl<$Res>
    implements $OtpCodeResponseCopyWith<$Res> {
  _$OtpCodeResponseCopyWithImpl(this._self, this._then);

  final OtpCodeResponse _self;
  final $Res Function(OtpCodeResponse) _then;

/// Create a copy of OtpCodeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? verificationToken = null,}) {
  return _then(_self.copyWith(
verificationToken: null == verificationToken ? _self.verificationToken : verificationToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [OtpCodeResponse].
extension OtpCodeResponsePatterns on OtpCodeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OtpCodeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OtpCodeResponse() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OtpCodeResponse value)  $default,){
final _that = this;
switch (_that) {
case _OtpCodeResponse():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OtpCodeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OtpCodeResponse() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'verification_token')  String verificationToken)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OtpCodeResponse() when $default != null:
return $default(_that.verificationToken);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'verification_token')  String verificationToken)  $default,) {final _that = this;
switch (_that) {
case _OtpCodeResponse():
return $default(_that.verificationToken);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'verification_token')  String verificationToken)?  $default,) {final _that = this;
switch (_that) {
case _OtpCodeResponse() when $default != null:
return $default(_that.verificationToken);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OtpCodeResponse implements OtpCodeResponse {
  const _OtpCodeResponse({@JsonKey(name: 'verification_token') required this.verificationToken});
  factory _OtpCodeResponse.fromJson(Map<String, dynamic> json) => _$OtpCodeResponseFromJson(json);

@override@JsonKey(name: 'verification_token') final  String verificationToken;

/// Create a copy of OtpCodeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OtpCodeResponseCopyWith<_OtpCodeResponse> get copyWith => __$OtpCodeResponseCopyWithImpl<_OtpCodeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OtpCodeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OtpCodeResponse&&(identical(other.verificationToken, verificationToken) || other.verificationToken == verificationToken));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,verificationToken);

@override
String toString() {
  return 'OtpCodeResponse(verificationToken: $verificationToken)';
}


}

/// @nodoc
abstract mixin class _$OtpCodeResponseCopyWith<$Res> implements $OtpCodeResponseCopyWith<$Res> {
  factory _$OtpCodeResponseCopyWith(_OtpCodeResponse value, $Res Function(_OtpCodeResponse) _then) = __$OtpCodeResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'verification_token') String verificationToken
});




}
/// @nodoc
class __$OtpCodeResponseCopyWithImpl<$Res>
    implements _$OtpCodeResponseCopyWith<$Res> {
  __$OtpCodeResponseCopyWithImpl(this._self, this._then);

  final _OtpCodeResponse _self;
  final $Res Function(_OtpCodeResponse) _then;

/// Create a copy of OtpCodeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? verificationToken = null,}) {
  return _then(_OtpCodeResponse(
verificationToken: null == verificationToken ? _self.verificationToken : verificationToken // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
