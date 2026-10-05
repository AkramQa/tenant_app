// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_service_request_body_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateServiceRequestBodyModel {

@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson) ServiceType get serviceType; String get description;@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) DateTime get preferredDate; bool get isUrgent; String? get imageFileName;
/// Create a copy of CreateServiceRequestBodyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateServiceRequestBodyModelCopyWith<CreateServiceRequestBodyModel> get copyWith => _$CreateServiceRequestBodyModelCopyWithImpl<CreateServiceRequestBodyModel>(this as CreateServiceRequestBodyModel, _$identity);

  /// Serializes this CreateServiceRequestBodyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateServiceRequestBodyModel&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.description, description) || other.description == description)&&(identical(other.preferredDate, preferredDate) || other.preferredDate == preferredDate)&&(identical(other.isUrgent, isUrgent) || other.isUrgent == isUrgent)&&(identical(other.imageFileName, imageFileName) || other.imageFileName == imageFileName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceType,description,preferredDate,isUrgent,imageFileName);

@override
String toString() {
  return 'CreateServiceRequestBodyModel(serviceType: $serviceType, description: $description, preferredDate: $preferredDate, isUrgent: $isUrgent, imageFileName: $imageFileName)';
}


}

/// @nodoc
abstract mixin class $CreateServiceRequestBodyModelCopyWith<$Res>  {
  factory $CreateServiceRequestBodyModelCopyWith(CreateServiceRequestBodyModel value, $Res Function(CreateServiceRequestBodyModel) _then) = _$CreateServiceRequestBodyModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson) ServiceType serviceType, String description,@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) DateTime preferredDate, bool isUrgent, String? imageFileName
});




}
/// @nodoc
class _$CreateServiceRequestBodyModelCopyWithImpl<$Res>
    implements $CreateServiceRequestBodyModelCopyWith<$Res> {
  _$CreateServiceRequestBodyModelCopyWithImpl(this._self, this._then);

  final CreateServiceRequestBodyModel _self;
  final $Res Function(CreateServiceRequestBodyModel) _then;

/// Create a copy of CreateServiceRequestBodyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceType = null,Object? description = null,Object? preferredDate = null,Object? isUrgent = null,Object? imageFileName = freezed,}) {
  return _then(_self.copyWith(
serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as ServiceType,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,preferredDate: null == preferredDate ? _self.preferredDate : preferredDate // ignore: cast_nullable_to_non_nullable
as DateTime,isUrgent: null == isUrgent ? _self.isUrgent : isUrgent // ignore: cast_nullable_to_non_nullable
as bool,imageFileName: freezed == imageFileName ? _self.imageFileName : imageFileName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateServiceRequestBodyModel].
extension CreateServiceRequestBodyModelPatterns on CreateServiceRequestBodyModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateServiceRequestBodyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateServiceRequestBodyModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateServiceRequestBodyModel value)  $default,){
final _that = this;
switch (_that) {
case _CreateServiceRequestBodyModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateServiceRequestBodyModel value)?  $default,){
final _that = this;
switch (_that) {
case _CreateServiceRequestBodyModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson)  ServiceType serviceType,  String description, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)  DateTime preferredDate,  bool isUrgent,  String? imageFileName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateServiceRequestBodyModel() when $default != null:
return $default(_that.serviceType,_that.description,_that.preferredDate,_that.isUrgent,_that.imageFileName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson)  ServiceType serviceType,  String description, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)  DateTime preferredDate,  bool isUrgent,  String? imageFileName)  $default,) {final _that = this;
switch (_that) {
case _CreateServiceRequestBodyModel():
return $default(_that.serviceType,_that.description,_that.preferredDate,_that.isUrgent,_that.imageFileName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson)  ServiceType serviceType,  String description, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)  DateTime preferredDate,  bool isUrgent,  String? imageFileName)?  $default,) {final _that = this;
switch (_that) {
case _CreateServiceRequestBodyModel() when $default != null:
return $default(_that.serviceType,_that.description,_that.preferredDate,_that.isUrgent,_that.imageFileName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateServiceRequestBodyModel implements CreateServiceRequestBodyModel {
  const _CreateServiceRequestBodyModel({@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson) required this.serviceType, required this.description, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) required this.preferredDate, this.isUrgent = false, this.imageFileName});
  factory _CreateServiceRequestBodyModel.fromJson(Map<String, dynamic> json) => _$CreateServiceRequestBodyModelFromJson(json);

@override@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson) final  ServiceType serviceType;
@override final  String description;
@override@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) final  DateTime preferredDate;
@override@JsonKey() final  bool isUrgent;
@override final  String? imageFileName;

/// Create a copy of CreateServiceRequestBodyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateServiceRequestBodyModelCopyWith<_CreateServiceRequestBodyModel> get copyWith => __$CreateServiceRequestBodyModelCopyWithImpl<_CreateServiceRequestBodyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateServiceRequestBodyModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateServiceRequestBodyModel&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.description, description) || other.description == description)&&(identical(other.preferredDate, preferredDate) || other.preferredDate == preferredDate)&&(identical(other.isUrgent, isUrgent) || other.isUrgent == isUrgent)&&(identical(other.imageFileName, imageFileName) || other.imageFileName == imageFileName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,serviceType,description,preferredDate,isUrgent,imageFileName);

@override
String toString() {
  return 'CreateServiceRequestBodyModel(serviceType: $serviceType, description: $description, preferredDate: $preferredDate, isUrgent: $isUrgent, imageFileName: $imageFileName)';
}


}

/// @nodoc
abstract mixin class _$CreateServiceRequestBodyModelCopyWith<$Res> implements $CreateServiceRequestBodyModelCopyWith<$Res> {
  factory _$CreateServiceRequestBodyModelCopyWith(_CreateServiceRequestBodyModel value, $Res Function(_CreateServiceRequestBodyModel) _then) = __$CreateServiceRequestBodyModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson) ServiceType serviceType, String description,@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) DateTime preferredDate, bool isUrgent, String? imageFileName
});




}
/// @nodoc
class __$CreateServiceRequestBodyModelCopyWithImpl<$Res>
    implements _$CreateServiceRequestBodyModelCopyWith<$Res> {
  __$CreateServiceRequestBodyModelCopyWithImpl(this._self, this._then);

  final _CreateServiceRequestBodyModel _self;
  final $Res Function(_CreateServiceRequestBodyModel) _then;

/// Create a copy of CreateServiceRequestBodyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceType = null,Object? description = null,Object? preferredDate = null,Object? isUrgent = null,Object? imageFileName = freezed,}) {
  return _then(_CreateServiceRequestBodyModel(
serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as ServiceType,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,preferredDate: null == preferredDate ? _self.preferredDate : preferredDate // ignore: cast_nullable_to_non_nullable
as DateTime,isUrgent: null == isUrgent ? _self.isUrgent : isUrgent // ignore: cast_nullable_to_non_nullable
as bool,imageFileName: freezed == imageFileName ? _self.imageFileName : imageFileName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
