// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_service_request_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateServiceRequestInput {

@FormControlAnnotation(validators: [RequiredValidator()]) ServiceType? get serviceType;@FormControlAnnotation(validators: [RequiredValidator(), NotBlankValidator(), MinLengthValidator(kMinDescriptionLength)]) String get description;@FormControlAnnotation(validators: [RequiredValidator()]) DateTime? get preferredDate;@FormControlAnnotation() bool get isUrgent;@FormControlAnnotation() String? get imagePath;
/// Create a copy of CreateServiceRequestInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateServiceRequestInputCopyWith<CreateServiceRequestInput> get copyWith => _$CreateServiceRequestInputCopyWithImpl<CreateServiceRequestInput>(this as CreateServiceRequestInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateServiceRequestInput&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.description, description) || other.description == description)&&(identical(other.preferredDate, preferredDate) || other.preferredDate == preferredDate)&&(identical(other.isUrgent, isUrgent) || other.isUrgent == isUrgent)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode => Object.hash(runtimeType,serviceType,description,preferredDate,isUrgent,imagePath);

@override
String toString() {
  return 'CreateServiceRequestInput(serviceType: $serviceType, description: $description, preferredDate: $preferredDate, isUrgent: $isUrgent, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class $CreateServiceRequestInputCopyWith<$Res>  {
  factory $CreateServiceRequestInputCopyWith(CreateServiceRequestInput value, $Res Function(CreateServiceRequestInput) _then) = _$CreateServiceRequestInputCopyWithImpl;
@useResult
$Res call({
@FormControlAnnotation(validators: [RequiredValidator()]) ServiceType? serviceType,@FormControlAnnotation(validators: [RequiredValidator(), NotBlankValidator(), MinLengthValidator(kMinDescriptionLength)]) String description,@FormControlAnnotation(validators: [RequiredValidator()]) DateTime? preferredDate,@FormControlAnnotation() bool isUrgent,@FormControlAnnotation() String? imagePath
});




}
/// @nodoc
class _$CreateServiceRequestInputCopyWithImpl<$Res>
    implements $CreateServiceRequestInputCopyWith<$Res> {
  _$CreateServiceRequestInputCopyWithImpl(this._self, this._then);

  final CreateServiceRequestInput _self;
  final $Res Function(CreateServiceRequestInput) _then;

/// Create a copy of CreateServiceRequestInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? serviceType = freezed,Object? description = null,Object? preferredDate = freezed,Object? isUrgent = null,Object? imagePath = freezed,}) {
  return _then(_self.copyWith(
serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as ServiceType?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,preferredDate: freezed == preferredDate ? _self.preferredDate : preferredDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isUrgent: null == isUrgent ? _self.isUrgent : isUrgent // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateServiceRequestInput].
extension CreateServiceRequestInputPatterns on CreateServiceRequestInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateServiceRequestInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateServiceRequestInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateServiceRequestInput value)  $default,){
final _that = this;
switch (_that) {
case _CreateServiceRequestInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateServiceRequestInput value)?  $default,){
final _that = this;
switch (_that) {
case _CreateServiceRequestInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@FormControlAnnotation(validators: [RequiredValidator()])  ServiceType? serviceType, @FormControlAnnotation(validators: [RequiredValidator(), NotBlankValidator(), MinLengthValidator(kMinDescriptionLength)])  String description, @FormControlAnnotation(validators: [RequiredValidator()])  DateTime? preferredDate, @FormControlAnnotation()  bool isUrgent, @FormControlAnnotation()  String? imagePath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateServiceRequestInput() when $default != null:
return $default(_that.serviceType,_that.description,_that.preferredDate,_that.isUrgent,_that.imagePath);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@FormControlAnnotation(validators: [RequiredValidator()])  ServiceType? serviceType, @FormControlAnnotation(validators: [RequiredValidator(), NotBlankValidator(), MinLengthValidator(kMinDescriptionLength)])  String description, @FormControlAnnotation(validators: [RequiredValidator()])  DateTime? preferredDate, @FormControlAnnotation()  bool isUrgent, @FormControlAnnotation()  String? imagePath)  $default,) {final _that = this;
switch (_that) {
case _CreateServiceRequestInput():
return $default(_that.serviceType,_that.description,_that.preferredDate,_that.isUrgent,_that.imagePath);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@FormControlAnnotation(validators: [RequiredValidator()])  ServiceType? serviceType, @FormControlAnnotation(validators: [RequiredValidator(), NotBlankValidator(), MinLengthValidator(kMinDescriptionLength)])  String description, @FormControlAnnotation(validators: [RequiredValidator()])  DateTime? preferredDate, @FormControlAnnotation()  bool isUrgent, @FormControlAnnotation()  String? imagePath)?  $default,) {final _that = this;
switch (_that) {
case _CreateServiceRequestInput() when $default != null:
return $default(_that.serviceType,_that.description,_that.preferredDate,_that.isUrgent,_that.imagePath);case _:
  return null;

}
}

}

/// @nodoc


class _CreateServiceRequestInput implements CreateServiceRequestInput {
   _CreateServiceRequestInput({@FormControlAnnotation(validators: [RequiredValidator()]) this.serviceType, @FormControlAnnotation(validators: [RequiredValidator(), NotBlankValidator(), MinLengthValidator(kMinDescriptionLength)]) this.description = '', @FormControlAnnotation(validators: [RequiredValidator()]) this.preferredDate, @FormControlAnnotation() this.isUrgent = false, @FormControlAnnotation() this.imagePath});
  

@override@FormControlAnnotation(validators: [RequiredValidator()]) final  ServiceType? serviceType;
@override@JsonKey()@FormControlAnnotation(validators: [RequiredValidator(), NotBlankValidator(), MinLengthValidator(kMinDescriptionLength)]) final  String description;
@override@FormControlAnnotation(validators: [RequiredValidator()]) final  DateTime? preferredDate;
@override@JsonKey()@FormControlAnnotation() final  bool isUrgent;
@override@FormControlAnnotation() final  String? imagePath;

/// Create a copy of CreateServiceRequestInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateServiceRequestInputCopyWith<_CreateServiceRequestInput> get copyWith => __$CreateServiceRequestInputCopyWithImpl<_CreateServiceRequestInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateServiceRequestInput&&(identical(other.serviceType, serviceType) || other.serviceType == serviceType)&&(identical(other.description, description) || other.description == description)&&(identical(other.preferredDate, preferredDate) || other.preferredDate == preferredDate)&&(identical(other.isUrgent, isUrgent) || other.isUrgent == isUrgent)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath));
}


@override
int get hashCode => Object.hash(runtimeType,serviceType,description,preferredDate,isUrgent,imagePath);

@override
String toString() {
  return 'CreateServiceRequestInput(serviceType: $serviceType, description: $description, preferredDate: $preferredDate, isUrgent: $isUrgent, imagePath: $imagePath)';
}


}

/// @nodoc
abstract mixin class _$CreateServiceRequestInputCopyWith<$Res> implements $CreateServiceRequestInputCopyWith<$Res> {
  factory _$CreateServiceRequestInputCopyWith(_CreateServiceRequestInput value, $Res Function(_CreateServiceRequestInput) _then) = __$CreateServiceRequestInputCopyWithImpl;
@override @useResult
$Res call({
@FormControlAnnotation(validators: [RequiredValidator()]) ServiceType? serviceType,@FormControlAnnotation(validators: [RequiredValidator(), NotBlankValidator(), MinLengthValidator(kMinDescriptionLength)]) String description,@FormControlAnnotation(validators: [RequiredValidator()]) DateTime? preferredDate,@FormControlAnnotation() bool isUrgent,@FormControlAnnotation() String? imagePath
});




}
/// @nodoc
class __$CreateServiceRequestInputCopyWithImpl<$Res>
    implements _$CreateServiceRequestInputCopyWith<$Res> {
  __$CreateServiceRequestInputCopyWithImpl(this._self, this._then);

  final _CreateServiceRequestInput _self;
  final $Res Function(_CreateServiceRequestInput) _then;

/// Create a copy of CreateServiceRequestInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? serviceType = freezed,Object? description = null,Object? preferredDate = freezed,Object? isUrgent = null,Object? imagePath = freezed,}) {
  return _then(_CreateServiceRequestInput(
serviceType: freezed == serviceType ? _self.serviceType : serviceType // ignore: cast_nullable_to_non_nullable
as ServiceType?,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,preferredDate: freezed == preferredDate ? _self.preferredDate : preferredDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isUrgent: null == isUrgent ? _self.isUrgent : isUrgent // ignore: cast_nullable_to_non_nullable
as bool,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
