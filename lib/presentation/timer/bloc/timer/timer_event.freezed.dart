// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimerEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimerEvent()';
}


}

/// @nodoc
class $TimerEventCopyWith<$Res>  {
$TimerEventCopyWith(TimerEvent _, $Res Function(TimerEvent) __);
}


/// Adds pattern-matching-related methods to [TimerEvent].
extension TimerEventPatterns on TimerEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TimerStarted value)?  start,TResult Function( TimerPaused value)?  pause,TResult Function( TimerToggled value)?  toggle,TResult Function( TimerReset value)?  reset,TResult Function( TimerTicked value)?  tick,TResult Function( TimerSetTarget value)?  setTarget,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TimerStarted() when start != null:
return start(_that);case TimerPaused() when pause != null:
return pause(_that);case TimerToggled() when toggle != null:
return toggle(_that);case TimerReset() when reset != null:
return reset(_that);case TimerTicked() when tick != null:
return tick(_that);case TimerSetTarget() when setTarget != null:
return setTarget(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TimerStarted value)  start,required TResult Function( TimerPaused value)  pause,required TResult Function( TimerToggled value)  toggle,required TResult Function( TimerReset value)  reset,required TResult Function( TimerTicked value)  tick,required TResult Function( TimerSetTarget value)  setTarget,}){
final _that = this;
switch (_that) {
case TimerStarted():
return start(_that);case TimerPaused():
return pause(_that);case TimerToggled():
return toggle(_that);case TimerReset():
return reset(_that);case TimerTicked():
return tick(_that);case TimerSetTarget():
return setTarget(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TimerStarted value)?  start,TResult? Function( TimerPaused value)?  pause,TResult? Function( TimerToggled value)?  toggle,TResult? Function( TimerReset value)?  reset,TResult? Function( TimerTicked value)?  tick,TResult? Function( TimerSetTarget value)?  setTarget,}){
final _that = this;
switch (_that) {
case TimerStarted() when start != null:
return start(_that);case TimerPaused() when pause != null:
return pause(_that);case TimerToggled() when toggle != null:
return toggle(_that);case TimerReset() when reset != null:
return reset(_that);case TimerTicked() when tick != null:
return tick(_that);case TimerSetTarget() when setTarget != null:
return setTarget(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  start,TResult Function()?  pause,TResult Function()?  toggle,TResult Function()?  reset,TResult Function( int remainingSeconds)?  tick,TResult Function( int minutes)?  setTarget,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TimerStarted() when start != null:
return start();case TimerPaused() when pause != null:
return pause();case TimerToggled() when toggle != null:
return toggle();case TimerReset() when reset != null:
return reset();case TimerTicked() when tick != null:
return tick(_that.remainingSeconds);case TimerSetTarget() when setTarget != null:
return setTarget(_that.minutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  start,required TResult Function()  pause,required TResult Function()  toggle,required TResult Function()  reset,required TResult Function( int remainingSeconds)  tick,required TResult Function( int minutes)  setTarget,}) {final _that = this;
switch (_that) {
case TimerStarted():
return start();case TimerPaused():
return pause();case TimerToggled():
return toggle();case TimerReset():
return reset();case TimerTicked():
return tick(_that.remainingSeconds);case TimerSetTarget():
return setTarget(_that.minutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  start,TResult? Function()?  pause,TResult? Function()?  toggle,TResult? Function()?  reset,TResult? Function( int remainingSeconds)?  tick,TResult? Function( int minutes)?  setTarget,}) {final _that = this;
switch (_that) {
case TimerStarted() when start != null:
return start();case TimerPaused() when pause != null:
return pause();case TimerToggled() when toggle != null:
return toggle();case TimerReset() when reset != null:
return reset();case TimerTicked() when tick != null:
return tick(_that.remainingSeconds);case TimerSetTarget() when setTarget != null:
return setTarget(_that.minutes);case _:
  return null;

}
}

}

/// @nodoc


class TimerStarted implements TimerEvent {
  const TimerStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimerEvent.start()';
}


}




/// @nodoc


class TimerPaused implements TimerEvent {
  const TimerPaused();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerPaused);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimerEvent.pause()';
}


}




/// @nodoc


class TimerToggled implements TimerEvent {
  const TimerToggled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerToggled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimerEvent.toggle()';
}


}




/// @nodoc


class TimerReset implements TimerEvent {
  const TimerReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TimerEvent.reset()';
}


}




/// @nodoc


class TimerTicked implements TimerEvent {
  const TimerTicked(this.remainingSeconds);
  

 final  int remainingSeconds;

/// Create a copy of TimerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerTickedCopyWith<TimerTicked> get copyWith => _$TimerTickedCopyWithImpl<TimerTicked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerTicked&&(identical(other.remainingSeconds, remainingSeconds) || other.remainingSeconds == remainingSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,remainingSeconds);

@override
String toString() {
  return 'TimerEvent.tick(remainingSeconds: $remainingSeconds)';
}


}

/// @nodoc
abstract mixin class $TimerTickedCopyWith<$Res> implements $TimerEventCopyWith<$Res> {
  factory $TimerTickedCopyWith(TimerTicked value, $Res Function(TimerTicked) _then) = _$TimerTickedCopyWithImpl;
@useResult
$Res call({
 int remainingSeconds
});




}
/// @nodoc
class _$TimerTickedCopyWithImpl<$Res>
    implements $TimerTickedCopyWith<$Res> {
  _$TimerTickedCopyWithImpl(this._self, this._then);

  final TimerTicked _self;
  final $Res Function(TimerTicked) _then;

/// Create a copy of TimerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? remainingSeconds = null,}) {
  return _then(TimerTicked(
null == remainingSeconds ? _self.remainingSeconds : remainingSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class TimerSetTarget implements TimerEvent {
  const TimerSetTarget(this.minutes);
  

 final  int minutes;

/// Create a copy of TimerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerSetTargetCopyWith<TimerSetTarget> get copyWith => _$TimerSetTargetCopyWithImpl<TimerSetTarget>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerSetTarget&&(identical(other.minutes, minutes) || other.minutes == minutes));
}


@override
int get hashCode => Object.hash(runtimeType,minutes);

@override
String toString() {
  return 'TimerEvent.setTarget(minutes: $minutes)';
}


}

/// @nodoc
abstract mixin class $TimerSetTargetCopyWith<$Res> implements $TimerEventCopyWith<$Res> {
  factory $TimerSetTargetCopyWith(TimerSetTarget value, $Res Function(TimerSetTarget) _then) = _$TimerSetTargetCopyWithImpl;
@useResult
$Res call({
 int minutes
});




}
/// @nodoc
class _$TimerSetTargetCopyWithImpl<$Res>
    implements $TimerSetTargetCopyWith<$Res> {
  _$TimerSetTargetCopyWithImpl(this._self, this._then);

  final TimerSetTarget _self;
  final $Res Function(TimerSetTarget) _then;

/// Create a copy of TimerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? minutes = null,}) {
  return _then(TimerSetTarget(
null == minutes ? _self.minutes : minutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
