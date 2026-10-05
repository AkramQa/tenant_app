// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tenant_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TenantInfoModel {

 String get tenantId; String get fullName; String? get email; String? get phoneNumber; String get propertyName; String get unitNumber;
/// Create a copy of TenantInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TenantInfoModelCopyWith<TenantInfoModel> get copyWith => _$TenantInfoModelCopyWithImpl<TenantInfoModel>(this as TenantInfoModel, _$identity);

  /// Serializes this TenantInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TenantInfoModel&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.propertyName, propertyName) || other.propertyName == propertyName)&&(identical(other.unitNumber, unitNumber) || other.unitNumber == unitNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tenantId,fullName,email,phoneNumber,propertyName,unitNumber);

@override
String toString() {
  return 'TenantInfoModel(tenantId: $tenantId, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, propertyName: $propertyName, unitNumber: $unitNumber)';
}


}

/// @nodoc
abstract mixin class $TenantInfoModelCopyWith<$Res>  {
  factory $TenantInfoModelCopyWith(TenantInfoModel value, $Res Function(TenantInfoModel) _then) = _$TenantInfoModelCopyWithImpl;
@useResult
$Res call({
 String tenantId, String fullName, String? email, String? phoneNumber, String propertyName, String unitNumber
});




}
/// @nodoc
class _$TenantInfoModelCopyWithImpl<$Res>
    implements $TenantInfoModelCopyWith<$Res> {
  _$TenantInfoModelCopyWithImpl(this._self, this._then);

  final TenantInfoModel _self;
  final $Res Function(TenantInfoModel) _then;

/// Create a copy of TenantInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tenantId = null,Object? fullName = null,Object? email = freezed,Object? phoneNumber = freezed,Object? propertyName = null,Object? unitNumber = null,}) {
  return _then(_self.copyWith(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,propertyName: null == propertyName ? _self.propertyName : propertyName // ignore: cast_nullable_to_non_nullable
as String,unitNumber: null == unitNumber ? _self.unitNumber : unitNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [TenantInfoModel].
extension TenantInfoModelPatterns on TenantInfoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TenantInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TenantInfoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TenantInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _TenantInfoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TenantInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _TenantInfoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String tenantId,  String fullName,  String? email,  String? phoneNumber,  String propertyName,  String unitNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TenantInfoModel() when $default != null:
return $default(_that.tenantId,_that.fullName,_that.email,_that.phoneNumber,_that.propertyName,_that.unitNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String tenantId,  String fullName,  String? email,  String? phoneNumber,  String propertyName,  String unitNumber)  $default,) {final _that = this;
switch (_that) {
case _TenantInfoModel():
return $default(_that.tenantId,_that.fullName,_that.email,_that.phoneNumber,_that.propertyName,_that.unitNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String tenantId,  String fullName,  String? email,  String? phoneNumber,  String propertyName,  String unitNumber)?  $default,) {final _that = this;
switch (_that) {
case _TenantInfoModel() when $default != null:
return $default(_that.tenantId,_that.fullName,_that.email,_that.phoneNumber,_that.propertyName,_that.unitNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TenantInfoModel extends TenantInfoModel {
  const _TenantInfoModel({required this.tenantId, required this.fullName, this.email, this.phoneNumber, required this.propertyName, required this.unitNumber}): super._();
  factory _TenantInfoModel.fromJson(Map<String, dynamic> json) => _$TenantInfoModelFromJson(json);

@override final  String tenantId;
@override final  String fullName;
@override final  String? email;
@override final  String? phoneNumber;
@override final  String propertyName;
@override final  String unitNumber;

/// Create a copy of TenantInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TenantInfoModelCopyWith<_TenantInfoModel> get copyWith => __$TenantInfoModelCopyWithImpl<_TenantInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TenantInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TenantInfoModel&&(identical(other.tenantId, tenantId) || other.tenantId == tenantId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.propertyName, propertyName) || other.propertyName == propertyName)&&(identical(other.unitNumber, unitNumber) || other.unitNumber == unitNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tenantId,fullName,email,phoneNumber,propertyName,unitNumber);

@override
String toString() {
  return 'TenantInfoModel(tenantId: $tenantId, fullName: $fullName, email: $email, phoneNumber: $phoneNumber, propertyName: $propertyName, unitNumber: $unitNumber)';
}


}

/// @nodoc
abstract mixin class _$TenantInfoModelCopyWith<$Res> implements $TenantInfoModelCopyWith<$Res> {
  factory _$TenantInfoModelCopyWith(_TenantInfoModel value, $Res Function(_TenantInfoModel) _then) = __$TenantInfoModelCopyWithImpl;
@override @useResult
$Res call({
 String tenantId, String fullName, String? email, String? phoneNumber, String propertyName, String unitNumber
});




}
/// @nodoc
class __$TenantInfoModelCopyWithImpl<$Res>
    implements _$TenantInfoModelCopyWith<$Res> {
  __$TenantInfoModelCopyWithImpl(this._self, this._then);

  final _TenantInfoModel _self;
  final $Res Function(_TenantInfoModel) _then;

/// Create a copy of TenantInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tenantId = null,Object? fullName = null,Object? email = freezed,Object? phoneNumber = freezed,Object? propertyName = null,Object? unitNumber = null,}) {
  return _then(_TenantInfoModel(
tenantId: null == tenantId ? _self.tenantId : tenantId // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,propertyName: null == propertyName ? _self.propertyName : propertyName // ignore: cast_nullable_to_non_nullable
as String,unitNumber: null == unitNumber ? _self.unitNumber : unitNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
