// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterEvent()';
}


}

/// @nodoc
class $RegisterEventCopyWith<$Res>  {
$RegisterEventCopyWith(RegisterEvent _, $Res Function(RegisterEvent) __);
}


/// Adds pattern-matching-related methods to [RegisterEvent].
extension RegisterEventPatterns on RegisterEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RegisterNameChanged value)?  nameChanged,TResult Function( RegisterEmailChanged value)?  emailChanged,TResult Function( RegisterPasswordChanged value)?  passwordChanged,TResult Function( RegisterConfirmPasswordChanged value)?  confirmPasswordChanged,TResult Function( RegisterSubmitted value)?  submitted,TResult Function( RegisterReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RegisterNameChanged() when nameChanged != null:
return nameChanged(_that);case RegisterEmailChanged() when emailChanged != null:
return emailChanged(_that);case RegisterPasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case RegisterConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that);case RegisterSubmitted() when submitted != null:
return submitted(_that);case RegisterReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RegisterNameChanged value)  nameChanged,required TResult Function( RegisterEmailChanged value)  emailChanged,required TResult Function( RegisterPasswordChanged value)  passwordChanged,required TResult Function( RegisterConfirmPasswordChanged value)  confirmPasswordChanged,required TResult Function( RegisterSubmitted value)  submitted,required TResult Function( RegisterReset value)  reset,}){
final _that = this;
switch (_that) {
case RegisterNameChanged():
return nameChanged(_that);case RegisterEmailChanged():
return emailChanged(_that);case RegisterPasswordChanged():
return passwordChanged(_that);case RegisterConfirmPasswordChanged():
return confirmPasswordChanged(_that);case RegisterSubmitted():
return submitted(_that);case RegisterReset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RegisterNameChanged value)?  nameChanged,TResult? Function( RegisterEmailChanged value)?  emailChanged,TResult? Function( RegisterPasswordChanged value)?  passwordChanged,TResult? Function( RegisterConfirmPasswordChanged value)?  confirmPasswordChanged,TResult? Function( RegisterSubmitted value)?  submitted,TResult? Function( RegisterReset value)?  reset,}){
final _that = this;
switch (_that) {
case RegisterNameChanged() when nameChanged != null:
return nameChanged(_that);case RegisterEmailChanged() when emailChanged != null:
return emailChanged(_that);case RegisterPasswordChanged() when passwordChanged != null:
return passwordChanged(_that);case RegisterConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that);case RegisterSubmitted() when submitted != null:
return submitted(_that);case RegisterReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String name)?  nameChanged,TResult Function( String email)?  emailChanged,TResult Function( String password)?  passwordChanged,TResult Function( String confirmPassword)?  confirmPasswordChanged,TResult Function( String name,  String email,  String password,  String confirmPassword)?  submitted,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RegisterNameChanged() when nameChanged != null:
return nameChanged(_that.name);case RegisterEmailChanged() when emailChanged != null:
return emailChanged(_that.email);case RegisterPasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case RegisterConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that.confirmPassword);case RegisterSubmitted() when submitted != null:
return submitted(_that.name,_that.email,_that.password,_that.confirmPassword);case RegisterReset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String name)  nameChanged,required TResult Function( String email)  emailChanged,required TResult Function( String password)  passwordChanged,required TResult Function( String confirmPassword)  confirmPasswordChanged,required TResult Function( String name,  String email,  String password,  String confirmPassword)  submitted,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case RegisterNameChanged():
return nameChanged(_that.name);case RegisterEmailChanged():
return emailChanged(_that.email);case RegisterPasswordChanged():
return passwordChanged(_that.password);case RegisterConfirmPasswordChanged():
return confirmPasswordChanged(_that.confirmPassword);case RegisterSubmitted():
return submitted(_that.name,_that.email,_that.password,_that.confirmPassword);case RegisterReset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String name)?  nameChanged,TResult? Function( String email)?  emailChanged,TResult? Function( String password)?  passwordChanged,TResult? Function( String confirmPassword)?  confirmPasswordChanged,TResult? Function( String name,  String email,  String password,  String confirmPassword)?  submitted,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case RegisterNameChanged() when nameChanged != null:
return nameChanged(_that.name);case RegisterEmailChanged() when emailChanged != null:
return emailChanged(_that.email);case RegisterPasswordChanged() when passwordChanged != null:
return passwordChanged(_that.password);case RegisterConfirmPasswordChanged() when confirmPasswordChanged != null:
return confirmPasswordChanged(_that.confirmPassword);case RegisterSubmitted() when submitted != null:
return submitted(_that.name,_that.email,_that.password,_that.confirmPassword);case RegisterReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class RegisterNameChanged implements RegisterEvent {
  const RegisterNameChanged(this.name);
  

 final  String name;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterNameChangedCopyWith<RegisterNameChanged> get copyWith => _$RegisterNameChangedCopyWithImpl<RegisterNameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterNameChanged&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'RegisterEvent.nameChanged(name: $name)';
}


}

/// @nodoc
abstract mixin class $RegisterNameChangedCopyWith<$Res> implements $RegisterEventCopyWith<$Res> {
  factory $RegisterNameChangedCopyWith(RegisterNameChanged value, $Res Function(RegisterNameChanged) _then) = _$RegisterNameChangedCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class _$RegisterNameChangedCopyWithImpl<$Res>
    implements $RegisterNameChangedCopyWith<$Res> {
  _$RegisterNameChangedCopyWithImpl(this._self, this._then);

  final RegisterNameChanged _self;
  final $Res Function(RegisterNameChanged) _then;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(RegisterNameChanged(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RegisterEmailChanged implements RegisterEvent {
  const RegisterEmailChanged(this.email);
  

 final  String email;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterEmailChangedCopyWith<RegisterEmailChanged> get copyWith => _$RegisterEmailChangedCopyWithImpl<RegisterEmailChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterEmailChanged&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'RegisterEvent.emailChanged(email: $email)';
}


}

/// @nodoc
abstract mixin class $RegisterEmailChangedCopyWith<$Res> implements $RegisterEventCopyWith<$Res> {
  factory $RegisterEmailChangedCopyWith(RegisterEmailChanged value, $Res Function(RegisterEmailChanged) _then) = _$RegisterEmailChangedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$RegisterEmailChangedCopyWithImpl<$Res>
    implements $RegisterEmailChangedCopyWith<$Res> {
  _$RegisterEmailChangedCopyWithImpl(this._self, this._then);

  final RegisterEmailChanged _self;
  final $Res Function(RegisterEmailChanged) _then;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(RegisterEmailChanged(
null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RegisterPasswordChanged implements RegisterEvent {
  const RegisterPasswordChanged(this.password);
  

 final  String password;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterPasswordChangedCopyWith<RegisterPasswordChanged> get copyWith => _$RegisterPasswordChangedCopyWithImpl<RegisterPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterPasswordChanged&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,password);

@override
String toString() {
  return 'RegisterEvent.passwordChanged(password: $password)';
}


}

/// @nodoc
abstract mixin class $RegisterPasswordChangedCopyWith<$Res> implements $RegisterEventCopyWith<$Res> {
  factory $RegisterPasswordChangedCopyWith(RegisterPasswordChanged value, $Res Function(RegisterPasswordChanged) _then) = _$RegisterPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String password
});




}
/// @nodoc
class _$RegisterPasswordChangedCopyWithImpl<$Res>
    implements $RegisterPasswordChangedCopyWith<$Res> {
  _$RegisterPasswordChangedCopyWithImpl(this._self, this._then);

  final RegisterPasswordChanged _self;
  final $Res Function(RegisterPasswordChanged) _then;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? password = null,}) {
  return _then(RegisterPasswordChanged(
null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RegisterConfirmPasswordChanged implements RegisterEvent {
  const RegisterConfirmPasswordChanged(this.confirmPassword);
  

 final  String confirmPassword;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterConfirmPasswordChangedCopyWith<RegisterConfirmPasswordChanged> get copyWith => _$RegisterConfirmPasswordChangedCopyWithImpl<RegisterConfirmPasswordChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterConfirmPasswordChanged&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}


@override
int get hashCode => Object.hash(runtimeType,confirmPassword);

@override
String toString() {
  return 'RegisterEvent.confirmPasswordChanged(confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class $RegisterConfirmPasswordChangedCopyWith<$Res> implements $RegisterEventCopyWith<$Res> {
  factory $RegisterConfirmPasswordChangedCopyWith(RegisterConfirmPasswordChanged value, $Res Function(RegisterConfirmPasswordChanged) _then) = _$RegisterConfirmPasswordChangedCopyWithImpl;
@useResult
$Res call({
 String confirmPassword
});




}
/// @nodoc
class _$RegisterConfirmPasswordChangedCopyWithImpl<$Res>
    implements $RegisterConfirmPasswordChangedCopyWith<$Res> {
  _$RegisterConfirmPasswordChangedCopyWithImpl(this._self, this._then);

  final RegisterConfirmPasswordChanged _self;
  final $Res Function(RegisterConfirmPasswordChanged) _then;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? confirmPassword = null,}) {
  return _then(RegisterConfirmPasswordChanged(
null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RegisterSubmitted implements RegisterEvent {
  const RegisterSubmitted({required this.name, required this.email, required this.password, required this.confirmPassword});
  

 final  String name;
 final  String email;
 final  String password;
 final  String confirmPassword;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterSubmittedCopyWith<RegisterSubmitted> get copyWith => _$RegisterSubmittedCopyWithImpl<RegisterSubmitted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterSubmitted&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password)&&(identical(other.confirmPassword, confirmPassword) || other.confirmPassword == confirmPassword));
}


@override
int get hashCode => Object.hash(runtimeType,name,email,password,confirmPassword);

@override
String toString() {
  return 'RegisterEvent.submitted(name: $name, email: $email, password: $password, confirmPassword: $confirmPassword)';
}


}

/// @nodoc
abstract mixin class $RegisterSubmittedCopyWith<$Res> implements $RegisterEventCopyWith<$Res> {
  factory $RegisterSubmittedCopyWith(RegisterSubmitted value, $Res Function(RegisterSubmitted) _then) = _$RegisterSubmittedCopyWithImpl;
@useResult
$Res call({
 String name, String email, String password, String confirmPassword
});




}
/// @nodoc
class _$RegisterSubmittedCopyWithImpl<$Res>
    implements $RegisterSubmittedCopyWith<$Res> {
  _$RegisterSubmittedCopyWithImpl(this._self, this._then);

  final RegisterSubmitted _self;
  final $Res Function(RegisterSubmitted) _then;

/// Create a copy of RegisterEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? password = null,Object? confirmPassword = null,}) {
  return _then(RegisterSubmitted(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,confirmPassword: null == confirmPassword ? _self.confirmPassword : confirmPassword // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RegisterReset implements RegisterEvent {
  const RegisterReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterEvent.reset()';
}


}




// dart format on
