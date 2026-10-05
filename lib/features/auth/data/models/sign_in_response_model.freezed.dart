// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SignInResponseModel {

 String get accessToken; TenantInfoModel get tenant;@JsonKey(fromJson: SignInTypeConverter.fromJson, toJson: SignInTypeConverter.toJson) SignInType? get signInType;
/// Create a copy of SignInResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInResponseModelCopyWith<SignInResponseModel> get copyWith => _$SignInResponseModelCopyWithImpl<SignInResponseModel>(this as SignInResponseModel, _$identity);

  /// Serializes this SignInResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInResponseModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.tenant, tenant) || other.tenant == tenant)&&(identical(other.signInType, signInType) || other.signInType == signInType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,tenant,signInType);

@override
String toString() {
  return 'SignInResponseModel(accessToken: $accessToken, tenant: $tenant, signInType: $signInType)';
}


}

/// @nodoc
abstract mixin class $SignInResponseModelCopyWith<$Res>  {
  factory $SignInResponseModelCopyWith(SignInResponseModel value, $Res Function(SignInResponseModel) _then) = _$SignInResponseModelCopyWithImpl;
@useResult
$Res call({
 String accessToken, TenantInfoModel tenant,@JsonKey(fromJson: SignInTypeConverter.fromJson, toJson: SignInTypeConverter.toJson) SignInType? signInType
});


$TenantInfoModelCopyWith<$Res> get tenant;

}
/// @nodoc
class _$SignInResponseModelCopyWithImpl<$Res>
    implements $SignInResponseModelCopyWith<$Res> {
  _$SignInResponseModelCopyWithImpl(this._self, this._then);

  final SignInResponseModel _self;
  final $Res Function(SignInResponseModel) _then;

/// Create a copy of SignInResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? accessToken = null,Object? tenant = null,Object? signInType = freezed,}) {
  return _then(_self.copyWith(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,tenant: null == tenant ? _self.tenant : tenant // ignore: cast_nullable_to_non_nullable
as TenantInfoModel,signInType: freezed == signInType ? _self.signInType : signInType // ignore: cast_nullable_to_non_nullable
as SignInType?,
  ));
}
/// Create a copy of SignInResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantInfoModelCopyWith<$Res> get tenant {
  
  return $TenantInfoModelCopyWith<$Res>(_self.tenant, (value) {
    return _then(_self.copyWith(tenant: value));
  });
}
}


/// Adds pattern-matching-related methods to [SignInResponseModel].
extension SignInResponseModelPatterns on SignInResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _SignInResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _SignInResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String accessToken,  TenantInfoModel tenant, @JsonKey(fromJson: SignInTypeConverter.fromJson, toJson: SignInTypeConverter.toJson)  SignInType? signInType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInResponseModel() when $default != null:
return $default(_that.accessToken,_that.tenant,_that.signInType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String accessToken,  TenantInfoModel tenant, @JsonKey(fromJson: SignInTypeConverter.fromJson, toJson: SignInTypeConverter.toJson)  SignInType? signInType)  $default,) {final _that = this;
switch (_that) {
case _SignInResponseModel():
return $default(_that.accessToken,_that.tenant,_that.signInType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String accessToken,  TenantInfoModel tenant, @JsonKey(fromJson: SignInTypeConverter.fromJson, toJson: SignInTypeConverter.toJson)  SignInType? signInType)?  $default,) {final _that = this;
switch (_that) {
case _SignInResponseModel() when $default != null:
return $default(_that.accessToken,_that.tenant,_that.signInType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SignInResponseModel implements SignInResponseModel {
  const _SignInResponseModel({required this.accessToken, required this.tenant, @JsonKey(fromJson: SignInTypeConverter.fromJson, toJson: SignInTypeConverter.toJson) this.signInType});
  factory _SignInResponseModel.fromJson(Map<String, dynamic> json) => _$SignInResponseModelFromJson(json);

@override final  String accessToken;
@override final  TenantInfoModel tenant;
@override@JsonKey(fromJson: SignInTypeConverter.fromJson, toJson: SignInTypeConverter.toJson) final  SignInType? signInType;

/// Create a copy of SignInResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInResponseModelCopyWith<_SignInResponseModel> get copyWith => __$SignInResponseModelCopyWithImpl<_SignInResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SignInResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInResponseModel&&(identical(other.accessToken, accessToken) || other.accessToken == accessToken)&&(identical(other.tenant, tenant) || other.tenant == tenant)&&(identical(other.signInType, signInType) || other.signInType == signInType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,accessToken,tenant,signInType);

@override
String toString() {
  return 'SignInResponseModel(accessToken: $accessToken, tenant: $tenant, signInType: $signInType)';
}


}

/// @nodoc
abstract mixin class _$SignInResponseModelCopyWith<$Res> implements $SignInResponseModelCopyWith<$Res> {
  factory _$SignInResponseModelCopyWith(_SignInResponseModel value, $Res Function(_SignInResponseModel) _then) = __$SignInResponseModelCopyWithImpl;
@override @useResult
$Res call({
 String accessToken, TenantInfoModel tenant,@JsonKey(fromJson: SignInTypeConverter.fromJson, toJson: SignInTypeConverter.toJson) SignInType? signInType
});


@override $TenantInfoModelCopyWith<$Res> get tenant;

}
/// @nodoc
class __$SignInResponseModelCopyWithImpl<$Res>
    implements _$SignInResponseModelCopyWith<$Res> {
  __$SignInResponseModelCopyWithImpl(this._self, this._then);

  final _SignInResponseModel _self;
  final $Res Function(_SignInResponseModel) _then;

/// Create a copy of SignInResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? accessToken = null,Object? tenant = null,Object? signInType = freezed,}) {
  return _then(_SignInResponseModel(
accessToken: null == accessToken ? _self.accessToken : accessToken // ignore: cast_nullable_to_non_nullable
as String,tenant: null == tenant ? _self.tenant : tenant // ignore: cast_nullable_to_non_nullable
as TenantInfoModel,signInType: freezed == signInType ? _self.signInType : signInType // ignore: cast_nullable_to_non_nullable
as SignInType?,
  ));
}

/// Create a copy of SignInResponseModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TenantInfoModelCopyWith<$Res> get tenant {
  
  return $TenantInfoModelCopyWith<$Res>(_self.tenant, (value) {
    return _then(_self.copyWith(tenant: value));
  });
}
}

// dart format on
