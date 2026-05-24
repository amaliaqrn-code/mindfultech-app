// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'register_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RegisterState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState()';
}


}

/// @nodoc
class $RegisterStateCopyWith<$Res>  {
$RegisterStateCopyWith(RegisterState _, $Res Function(RegisterState) __);
}


/// Adds pattern-matching-related methods to [RegisterState].
extension RegisterStatePatterns on RegisterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( RegisterInitial value)?  initial,TResult Function( RegisterLoading value)?  loading,TResult Function( RegisterSuccess value)?  success,TResult Function( RegisterFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case RegisterInitial() when initial != null:
return initial(_that);case RegisterLoading() when loading != null:
return loading(_that);case RegisterSuccess() when success != null:
return success(_that);case RegisterFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( RegisterInitial value)  initial,required TResult Function( RegisterLoading value)  loading,required TResult Function( RegisterSuccess value)  success,required TResult Function( RegisterFailure value)  failure,}){
final _that = this;
switch (_that) {
case RegisterInitial():
return initial(_that);case RegisterLoading():
return loading(_that);case RegisterSuccess():
return success(_that);case RegisterFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( RegisterInitial value)?  initial,TResult? Function( RegisterLoading value)?  loading,TResult? Function( RegisterSuccess value)?  success,TResult? Function( RegisterFailure value)?  failure,}){
final _that = this;
switch (_that) {
case RegisterInitial() when initial != null:
return initial(_that);case RegisterLoading() when loading != null:
return loading(_that);case RegisterSuccess() when success != null:
return success(_that);case RegisterFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( UserModel user)?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case RegisterInitial() when initial != null:
return initial();case RegisterLoading() when loading != null:
return loading();case RegisterSuccess() when success != null:
return success(_that.user);case RegisterFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( UserModel user)  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case RegisterInitial():
return initial();case RegisterLoading():
return loading();case RegisterSuccess():
return success(_that.user);case RegisterFailure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( UserModel user)?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case RegisterInitial() when initial != null:
return initial();case RegisterLoading() when loading != null:
return loading();case RegisterSuccess() when success != null:
return success(_that.user);case RegisterFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class RegisterInitial implements RegisterState {
  const RegisterInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState.initial()';
}


}




/// @nodoc


class RegisterLoading implements RegisterState {
  const RegisterLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'RegisterState.loading()';
}


}




/// @nodoc


class RegisterSuccess implements RegisterState {
  const RegisterSuccess(this.user);
  

 final  UserModel user;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterSuccessCopyWith<RegisterSuccess> get copyWith => _$RegisterSuccessCopyWithImpl<RegisterSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterSuccess&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'RegisterState.success(user: $user)';
}


}

/// @nodoc
abstract mixin class $RegisterSuccessCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory $RegisterSuccessCopyWith(RegisterSuccess value, $Res Function(RegisterSuccess) _then) = _$RegisterSuccessCopyWithImpl;
@useResult
$Res call({
 UserModel user
});




}
/// @nodoc
class _$RegisterSuccessCopyWithImpl<$Res>
    implements $RegisterSuccessCopyWith<$Res> {
  _$RegisterSuccessCopyWithImpl(this._self, this._then);

  final RegisterSuccess _self;
  final $Res Function(RegisterSuccess) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(RegisterSuccess(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserModel,
  ));
}


}

/// @nodoc


class RegisterFailure implements RegisterState {
  const RegisterFailure(this.message);
  

 final  String message;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterFailureCopyWith<RegisterFailure> get copyWith => _$RegisterFailureCopyWithImpl<RegisterFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'RegisterState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $RegisterFailureCopyWith<$Res> implements $RegisterStateCopyWith<$Res> {
  factory $RegisterFailureCopyWith(RegisterFailure value, $Res Function(RegisterFailure) _then) = _$RegisterFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$RegisterFailureCopyWithImpl<$Res>
    implements $RegisterFailureCopyWith<$Res> {
  _$RegisterFailureCopyWithImpl(this._self, this._then);

  final RegisterFailure _self;
  final $Res Function(RegisterFailure) _then;

/// Create a copy of RegisterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(RegisterFailure(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
