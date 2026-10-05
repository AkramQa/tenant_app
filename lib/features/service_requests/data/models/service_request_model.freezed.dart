// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'service_request_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ServiceRequestModel {

 String get id;@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson) ServiceType get serviceType; String get description;@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) DateTime get preferredDate; bool get isUrgent;@JsonKey(fromJson: RequestStatusConverter.fromJson, toJson: RequestStatusConverter.toJson) RequestStatus get status;@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) DateTime get createdAt;/// Attachment name as stored by the backend / on disk.
 String? get imageFileName;/// Absolute on-device path, resolved by the repository at read time (iOS
/// changes the app container path between installs/updates, so an absolute
/// path must never be persisted). Not part of the JSON.
@JsonKey(includeFromJson: false, includeToJson: false) String? get localImagePath;
/// Create a copy of ServiceRequestModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServiceRequestModelCopyWith<ServiceRequestModel> get copyWith => _$ServiceRequestModelCopyWithImpl<ServiceRequestModel>(this as ServiceRequestModel, _$identity);

  /// Serializes this ServiceRequestModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServiceRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.description, description) || other.description == description)&&(identical(other.preferredDate, preferredDate) || other.preferredDate == preferredDate)&&(identical(other.isUrgent, isUrgent) || other.isUrgent == isUrgent)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imageFileName, imageFileName) || other.imageFileName == imageFileName)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serviceType,description,preferredDate,isUrgent,status,createdAt,imageFileName,localImagePath);

@override
String toString() {
  return 'ServiceRequestModel(id: $id, serviceType: $serviceType, description: $description, preferredDate: $preferredDate, isUrgent: $isUrgent, status: $status, createdAt: $createdAt, imageFileName: $imageFileName, localImagePath: $localImagePath)';
}


}

/// @nodoc
abstract mixin class $ServiceRequestModelCopyWith<$Res>  {
  factory $ServiceRequestModelCopyWith(ServiceRequestModel value, $Res Function(ServiceRequestModel) _then) = _$ServiceRequestModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson) ServiceType serviceType, String description,@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) DateTime preferredDate, bool isUrgent,@JsonKey(fromJson: RequestStatusConverter.fromJson, toJson: RequestStatusConverter.toJson) RequestStatus status,@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) DateTime createdAt, String? imageFileName,@JsonKey(includeFromJson: false, includeToJson: false) String? localImagePath
});




}
/// @nodoc
class _$ServiceRequestModelCopyWithImpl<$Res>
    implements $ServiceRequestModelCopyWith<$Res> {
  _$ServiceRequestModelCopyWithImpl(this._self, this._then);

  final ServiceRequestModel _self;
  final $Res Function(ServiceRequestModel) _then;

/// Create a copy of ServiceRequestModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? serviceType = null,Object? description = null,Object? preferredDate = null,Object? isUrgent = null,Object? status = null,Object? createdAt = null,Object? imageFileName = freezed,Object? localImagePath = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as ServiceType,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,preferredDate: null == preferredDate ? _self.preferredDate : preferredDate // ignore: cast_nullable_to_non_nullable
as DateTime,isUrgent: null == isUrgent ? _self.isUrgent : isUrgent // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageFileName: freezed == imageFileName ? _self.imageFileName : imageFileName // ignore: cast_nullable_to_non_nullable
as String?,localImagePath: freezed == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ServiceRequestModel].
extension ServiceRequestModelPatterns on ServiceRequestModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ServiceRequestModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ServiceRequestModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ServiceRequestModel value)  $default,){
final _that = this;
switch (_that) {
case _ServiceRequestModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ServiceRequestModel value)?  $default,){
final _that = this;
switch (_that) {
case _ServiceRequestModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson)  ServiceType serviceType,  String description, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)  DateTime preferredDate,  bool isUrgent, @JsonKey(fromJson: RequestStatusConverter.fromJson, toJson: RequestStatusConverter.toJson)  RequestStatus status, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)  DateTime createdAt,  String? imageFileName, @JsonKey(includeFromJson: false, includeToJson: false)  String? localImagePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ServiceRequestModel() when $default != null:
return $default(_that.id,_that.serviceType,_that.description,_that.preferredDate,_that.isUrgent,_that.status,_that.createdAt,_that.imageFileName,_that.localImagePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson)  ServiceType serviceType,  String description, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)  DateTime preferredDate,  bool isUrgent, @JsonKey(fromJson: RequestStatusConverter.fromJson, toJson: RequestStatusConverter.toJson)  RequestStatus status, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)  DateTime createdAt,  String? imageFileName, @JsonKey(includeFromJson: false, includeToJson: false)  String? localImagePath)  $default,) {final _that = this;
switch (_that) {
case _ServiceRequestModel():
return $default(_that.id,_that.serviceType,_that.description,_that.preferredDate,_that.isUrgent,_that.status,_that.createdAt,_that.imageFileName,_that.localImagePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson)  ServiceType serviceType,  String description, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)  DateTime preferredDate,  bool isUrgent, @JsonKey(fromJson: RequestStatusConverter.fromJson, toJson: RequestStatusConverter.toJson)  RequestStatus status, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString)  DateTime createdAt,  String? imageFileName, @JsonKey(includeFromJson: false, includeToJson: false)  String? localImagePath)?  $default,) {final _that = this;
switch (_that) {
case _ServiceRequestModel() when $default != null:
return $default(_that.id,_that.serviceType,_that.description,_that.preferredDate,_that.isUrgent,_that.status,_that.createdAt,_that.imageFileName,_that.localImagePath);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ServiceRequestModel extends ServiceRequestModel {
  const _ServiceRequestModel({required this.id, @JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson) required this.serviceType, required this.description, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) required this.preferredDate, this.isUrgent = false, @JsonKey(fromJson: RequestStatusConverter.fromJson, toJson: RequestStatusConverter.toJson) required this.status, @JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) required this.createdAt, this.imageFileName, @JsonKey(includeFromJson: false, includeToJson: false) this.localImagePath}): super._();
  factory _ServiceRequestModel.fromJson(Map<String, dynamic> json) => _$ServiceRequestModelFromJson(json);

@override final  String id;
@override@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson) final  ServiceType serviceType;
@override final  String description;
@override@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) final  DateTime preferredDate;
@override@JsonKey() final  bool isUrgent;
@override@JsonKey(fromJson: RequestStatusConverter.fromJson, toJson: RequestStatusConverter.toJson) final  RequestStatus status;
@override@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) final  DateTime createdAt;
/// Attachment name as stored by the backend / on disk.
@override final  String? imageFileName;
/// Absolute on-device path, resolved by the repository at read time (iOS
/// changes the app container path between installs/updates, so an absolute
/// path must never be persisted). Not part of the JSON.
@override@JsonKey(includeFromJson: false, includeToJson: false) final  String? localImagePath;

/// Create a copy of ServiceRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ServiceRequestModelCopyWith<_ServiceRequestModel> get copyWith => __$ServiceRequestModelCopyWithImpl<_ServiceRequestModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ServiceRequestModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ServiceRequestModel&&(identical(other.id, id) || other.id == id)&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.description, description) || other.description == description)&&(identical(other.preferredDate, preferredDate) || other.preferredDate == preferredDate)&&(identical(other.isUrgent, isUrgent) || other.isUrgent == isUrgent)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.imageFileName, imageFileName) || other.imageFileName == imageFileName)&&(identical(other.localImagePath, localImagePath) || other.localImagePath == localImagePath));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,serviceType,description,preferredDate,isUrgent,status,createdAt,imageFileName,localImagePath);

@override
String toString() {
  return 'ServiceRequestModel(id: $id, serviceType: $serviceType, description: $description, preferredDate: $preferredDate, isUrgent: $isUrgent, status: $status, createdAt: $createdAt, imageFileName: $imageFileName, localImagePath: $localImagePath)';
}


}

/// @nodoc
abstract mixin class _$ServiceRequestModelCopyWith<$Res> implements $ServiceRequestModelCopyWith<$Res> {
  factory _$ServiceRequestModelCopyWith(_ServiceRequestModel value, $Res Function(_ServiceRequestModel) _then) = __$ServiceRequestModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(fromJson: ServiceTypeConverter.fromJson, toJson: ServiceTypeConverter.toJson) ServiceType serviceType, String description,@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) DateTime preferredDate, bool isUrgent,@JsonKey(fromJson: RequestStatusConverter.fromJson, toJson: RequestStatusConverter.toJson) RequestStatus status,@JsonKey(fromJson: convertStringToRequiredDate, toJson: convertRequiredDateToString) DateTime createdAt, String? imageFileName,@JsonKey(includeFromJson: false, includeToJson: false) String? localImagePath
});




}
/// @nodoc
class __$ServiceRequestModelCopyWithImpl<$Res>
    implements _$ServiceRequestModelCopyWith<$Res> {
  __$ServiceRequestModelCopyWithImpl(this._self, this._then);

  final _ServiceRequestModel _self;
  final $Res Function(_ServiceRequestModel) _then;

/// Create a copy of ServiceRequestModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? serviceType = null,Object? description = null,Object? preferredDate = null,Object? isUrgent = null,Object? status = null,Object? createdAt = null,Object? imageFileName = freezed,Object? localImagePath = freezed,}) {
  return _then(_ServiceRequestModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,serviceType: null == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as ServiceType,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,preferredDate: null == preferredDate ? _self.preferredDate : preferredDate // ignore: cast_nullable_to_non_nullable
as DateTime,isUrgent: null == isUrgent ? _self.isUrgent : isUrgent // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RequestStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,imageFileName: freezed == imageFileName ? _self.imageFileName : imageFileName // ignore: cast_nullable_to_non_nullable
as String?,localImagePath: freezed == localImagePath ? _self.localImagePath : localImagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
