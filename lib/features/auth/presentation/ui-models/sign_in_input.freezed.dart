// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sign_in_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SignInInput {

@FormControlAnnotation(validators: [RequiredValidator(), EmailOrPhoneValidator()]) String get identifier;@FormControlAnnotation(validators: [RequiredValidator(), MinLengthValidator(kMinPasswordLength)]) String get password;
/// Create a copy of SignInInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SignInInputCopyWith<SignInInput> get copyWith => _$SignInInputCopyWithImpl<SignInInput>(this as SignInInput, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SignInInput&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,identifier,password);

@override
String toString() {
  return 'SignInInput(identifier: $identifier, password: $password)';
}


}

/// @nodoc
abstract mixin class $SignInInputCopyWith<$Res>  {
  factory $SignInInputCopyWith(SignInInput value, $Res Function(SignInInput) _then) = _$SignInInputCopyWithImpl;
@useResult
$Res call({
@FormControlAnnotation(validators: [RequiredValidator(), EmailOrPhoneValidator()]) String identifier,@FormControlAnnotation(validators: [RequiredValidator(), MinLengthValidator(kMinPasswordLength)]) String password
});




}
/// @nodoc
class _$SignInInputCopyWithImpl<$Res>
    implements $SignInInputCopyWith<$Res> {
  _$SignInInputCopyWithImpl(this._self, this._then);

  final SignInInput _self;
  final $Res Function(SignInInput) _then;

/// Create a copy of SignInInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? identifier = null,Object? password = null,}) {
  return _then(_self.copyWith(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [SignInInput].
extension SignInInputPatterns on SignInInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SignInInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SignInInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SignInInput value)  $default,){
final _that = this;
switch (_that) {
case _SignInInput():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SignInInput value)?  $default,){
final _that = this;
switch (_that) {
case _SignInInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@FormControlAnnotation(validators: [RequiredValidator(), EmailOrPhoneValidator()])  String identifier, @FormControlAnnotation(validators: [RequiredValidator(), MinLengthValidator(kMinPasswordLength)])  String password)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SignInInput() when $default != null:
return $default(_that.identifier,_that.password);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@FormControlAnnotation(validators: [RequiredValidator(), EmailOrPhoneValidator()])  String identifier, @FormControlAnnotation(validators: [RequiredValidator(), MinLengthValidator(kMinPasswordLength)])  String password)  $default,) {final _that = this;
switch (_that) {
case _SignInInput():
return $default(_that.identifier,_that.password);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@FormControlAnnotation(validators: [RequiredValidator(), EmailOrPhoneValidator()])  String identifier, @FormControlAnnotation(validators: [RequiredValidator(), MinLengthValidator(kMinPasswordLength)])  String password)?  $default,) {final _that = this;
switch (_that) {
case _SignInInput() when $default != null:
return $default(_that.identifier,_that.password);case _:
  return null;

}
}

}

/// @nodoc


class _SignInInput implements SignInInput {
   _SignInInput({@FormControlAnnotation(validators: [RequiredValidator(), EmailOrPhoneValidator()]) this.identifier = '', @FormControlAnnotation(validators: [RequiredValidator(), MinLengthValidator(kMinPasswordLength)]) this.password = ''});
  

@override@JsonKey()@FormControlAnnotation(validators: [RequiredValidator(), EmailOrPhoneValidator()]) final  String identifier;
@override@JsonKey()@FormControlAnnotation(validators: [RequiredValidator(), MinLengthValidator(kMinPasswordLength)]) final  String password;

/// Create a copy of SignInInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SignInInputCopyWith<_SignInInput> get copyWith => __$SignInInputCopyWithImpl<_SignInInput>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SignInInput&&(identical(other.identifier, identifier) || other.identifier == identifier)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,identifier,password);

@override
String toString() {
  return 'SignInInput(identifier: $identifier, password: $password)';
}


}

/// @nodoc
abstract mixin class _$SignInInputCopyWith<$Res> implements $SignInInputCopyWith<$Res> {
  factory _$SignInInputCopyWith(_SignInInput value, $Res Function(_SignInInput) _then) = __$SignInInputCopyWithImpl;
@override @useResult
$Res call({
@FormControlAnnotation(validators: [RequiredValidator(), EmailOrPhoneValidator()]) String identifier,@FormControlAnnotation(validators: [RequiredValidator(), MinLengthValidator(kMinPasswordLength)]) String password
});




}
/// @nodoc
class __$SignInInputCopyWithImpl<$Res>
    implements _$SignInInputCopyWith<$Res> {
  __$SignInInputCopyWithImpl(this._self, this._then);

  final _SignInInput _self;
  final $Res Function(_SignInInput) _then;

/// Create a copy of SignInInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? identifier = null,Object? password = null,}) {
  return _then(_SignInInput(
identifier: null == identifier ? _self.identifier : identifier // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
