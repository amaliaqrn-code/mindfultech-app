// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimerState {

 int get totalTargetMinutes;// Total target dari task (misal: 60)
 int get durationPerSession;// Durasi per sesi belajar (misal: 30)
 int get breakDurationMinutes;// Durasi istirahat (misal: 10)
 int get totalSessions;// Hasil hitung total target / per sesi (misal: 2)
 int get currentSession;// Sesi berjalan sekarang (mulai dari 1)
 int get remainingSeconds;// Hitung mundur detik yang aktif
 bool get isRunning;// Apakah timer berdetak
 bool get isBreakTime;// True jika sedang sesi istirahat, False jika sesi tugas
 bool get isAllCompleted;
/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimerStateCopyWith<TimerState> get copyWith => _$TimerStateCopyWithImpl<TimerState>(this as TimerState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimerState&&(identical(other.totalTargetMinutes, totalTargetMinutes) || other.totalTargetMinutes == totalTargetMinutes)&&(identical(other.durationPerSession, durationPerSession) || other.durationPerSession == durationPerSession)&&(identical(other.breakDurationMinutes, breakDurationMinutes) || other.breakDurationMinutes == breakDurationMinutes)&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.currentSession, currentSession) || other.currentSession == currentSession)&&(identical(other.remainingSeconds, remainingSeconds) || other.remainingSeconds == remainingSeconds)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.isBreakTime, isBreakTime) || other.isBreakTime == isBreakTime)&&(identical(other.isAllCompleted, isAllCompleted) || other.isAllCompleted == isAllCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,totalTargetMinutes,durationPerSession,breakDurationMinutes,totalSessions,currentSession,remainingSeconds,isRunning,isBreakTime,isAllCompleted);

@override
String toString() {
  return 'TimerState(totalTargetMinutes: $totalTargetMinutes, durationPerSession: $durationPerSession, breakDurationMinutes: $breakDurationMinutes, totalSessions: $totalSessions, currentSession: $currentSession, remainingSeconds: $remainingSeconds, isRunning: $isRunning, isBreakTime: $isBreakTime, isAllCompleted: $isAllCompleted)';
}


}

/// @nodoc
abstract mixin class $TimerStateCopyWith<$Res>  {
  factory $TimerStateCopyWith(TimerState value, $Res Function(TimerState) _then) = _$TimerStateCopyWithImpl;
@useResult
$Res call({
 int totalTargetMinutes, int durationPerSession, int breakDurationMinutes, int totalSessions, int currentSession, int remainingSeconds, bool isRunning, bool isBreakTime, bool isAllCompleted
});




}
/// @nodoc
class _$TimerStateCopyWithImpl<$Res>
    implements $TimerStateCopyWith<$Res> {
  _$TimerStateCopyWithImpl(this._self, this._then);

  final TimerState _self;
  final $Res Function(TimerState) _then;

/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalTargetMinutes = null,Object? durationPerSession = null,Object? breakDurationMinutes = null,Object? totalSessions = null,Object? currentSession = null,Object? remainingSeconds = null,Object? isRunning = null,Object? isBreakTime = null,Object? isAllCompleted = null,}) {
  return _then(_self.copyWith(
totalTargetMinutes: null == totalTargetMinutes ? _self.totalTargetMinutes : totalTargetMinutes // ignore: cast_nullable_to_non_nullable
as int,durationPerSession: null == durationPerSession ? _self.durationPerSession : durationPerSession // ignore: cast_nullable_to_non_nullable
as int,breakDurationMinutes: null == breakDurationMinutes ? _self.breakDurationMinutes : breakDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,currentSession: null == currentSession ? _self.currentSession : currentSession // ignore: cast_nullable_to_non_nullable
as int,remainingSeconds: null == remainingSeconds ? _self.remainingSeconds : remainingSeconds // ignore: cast_nullable_to_non_nullable
as int,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,isBreakTime: null == isBreakTime ? _self.isBreakTime : isBreakTime // ignore: cast_nullable_to_non_nullable
as bool,isAllCompleted: null == isAllCompleted ? _self.isAllCompleted : isAllCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [TimerState].
extension TimerStatePatterns on TimerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimerState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimerState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimerState value)  $default,){
final _that = this;
switch (_that) {
case _TimerState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimerState value)?  $default,){
final _that = this;
switch (_that) {
case _TimerState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalTargetMinutes,  int durationPerSession,  int breakDurationMinutes,  int totalSessions,  int currentSession,  int remainingSeconds,  bool isRunning,  bool isBreakTime,  bool isAllCompleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimerState() when $default != null:
return $default(_that.totalTargetMinutes,_that.durationPerSession,_that.breakDurationMinutes,_that.totalSessions,_that.currentSession,_that.remainingSeconds,_that.isRunning,_that.isBreakTime,_that.isAllCompleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalTargetMinutes,  int durationPerSession,  int breakDurationMinutes,  int totalSessions,  int currentSession,  int remainingSeconds,  bool isRunning,  bool isBreakTime,  bool isAllCompleted)  $default,) {final _that = this;
switch (_that) {
case _TimerState():
return $default(_that.totalTargetMinutes,_that.durationPerSession,_that.breakDurationMinutes,_that.totalSessions,_that.currentSession,_that.remainingSeconds,_that.isRunning,_that.isBreakTime,_that.isAllCompleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalTargetMinutes,  int durationPerSession,  int breakDurationMinutes,  int totalSessions,  int currentSession,  int remainingSeconds,  bool isRunning,  bool isBreakTime,  bool isAllCompleted)?  $default,) {final _that = this;
switch (_that) {
case _TimerState() when $default != null:
return $default(_that.totalTargetMinutes,_that.durationPerSession,_that.breakDurationMinutes,_that.totalSessions,_that.currentSession,_that.remainingSeconds,_that.isRunning,_that.isBreakTime,_that.isAllCompleted);case _:
  return null;

}
}

}

/// @nodoc


class _TimerState implements TimerState {
  const _TimerState({required this.totalTargetMinutes, required this.durationPerSession, required this.breakDurationMinutes, required this.totalSessions, required this.currentSession, required this.remainingSeconds, required this.isRunning, required this.isBreakTime, required this.isAllCompleted});
  

@override final  int totalTargetMinutes;
// Total target dari task (misal: 60)
@override final  int durationPerSession;
// Durasi per sesi belajar (misal: 30)
@override final  int breakDurationMinutes;
// Durasi istirahat (misal: 10)
@override final  int totalSessions;
// Hasil hitung total target / per sesi (misal: 2)
@override final  int currentSession;
// Sesi berjalan sekarang (mulai dari 1)
@override final  int remainingSeconds;
// Hitung mundur detik yang aktif
@override final  bool isRunning;
// Apakah timer berdetak
@override final  bool isBreakTime;
// True jika sedang sesi istirahat, False jika sesi tugas
@override final  bool isAllCompleted;

/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimerStateCopyWith<_TimerState> get copyWith => __$TimerStateCopyWithImpl<_TimerState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimerState&&(identical(other.totalTargetMinutes, totalTargetMinutes) || other.totalTargetMinutes == totalTargetMinutes)&&(identical(other.durationPerSession, durationPerSession) || other.durationPerSession == durationPerSession)&&(identical(other.breakDurationMinutes, breakDurationMinutes) || other.breakDurationMinutes == breakDurationMinutes)&&(identical(other.totalSessions, totalSessions) || other.totalSessions == totalSessions)&&(identical(other.currentSession, currentSession) || other.currentSession == currentSession)&&(identical(other.remainingSeconds, remainingSeconds) || other.remainingSeconds == remainingSeconds)&&(identical(other.isRunning, isRunning) || other.isRunning == isRunning)&&(identical(other.isBreakTime, isBreakTime) || other.isBreakTime == isBreakTime)&&(identical(other.isAllCompleted, isAllCompleted) || other.isAllCompleted == isAllCompleted));
}


@override
int get hashCode => Object.hash(runtimeType,totalTargetMinutes,durationPerSession,breakDurationMinutes,totalSessions,currentSession,remainingSeconds,isRunning,isBreakTime,isAllCompleted);

@override
String toString() {
  return 'TimerState(totalTargetMinutes: $totalTargetMinutes, durationPerSession: $durationPerSession, breakDurationMinutes: $breakDurationMinutes, totalSessions: $totalSessions, currentSession: $currentSession, remainingSeconds: $remainingSeconds, isRunning: $isRunning, isBreakTime: $isBreakTime, isAllCompleted: $isAllCompleted)';
}


}

/// @nodoc
abstract mixin class _$TimerStateCopyWith<$Res> implements $TimerStateCopyWith<$Res> {
  factory _$TimerStateCopyWith(_TimerState value, $Res Function(_TimerState) _then) = __$TimerStateCopyWithImpl;
@override @useResult
$Res call({
 int totalTargetMinutes, int durationPerSession, int breakDurationMinutes, int totalSessions, int currentSession, int remainingSeconds, bool isRunning, bool isBreakTime, bool isAllCompleted
});




}
/// @nodoc
class __$TimerStateCopyWithImpl<$Res>
    implements _$TimerStateCopyWith<$Res> {
  __$TimerStateCopyWithImpl(this._self, this._then);

  final _TimerState _self;
  final $Res Function(_TimerState) _then;

/// Create a copy of TimerState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalTargetMinutes = null,Object? durationPerSession = null,Object? breakDurationMinutes = null,Object? totalSessions = null,Object? currentSession = null,Object? remainingSeconds = null,Object? isRunning = null,Object? isBreakTime = null,Object? isAllCompleted = null,}) {
  return _then(_TimerState(
totalTargetMinutes: null == totalTargetMinutes ? _self.totalTargetMinutes : totalTargetMinutes // ignore: cast_nullable_to_non_nullable
as int,durationPerSession: null == durationPerSession ? _self.durationPerSession : durationPerSession // ignore: cast_nullable_to_non_nullable
as int,breakDurationMinutes: null == breakDurationMinutes ? _self.breakDurationMinutes : breakDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,totalSessions: null == totalSessions ? _self.totalSessions : totalSessions // ignore: cast_nullable_to_non_nullable
as int,currentSession: null == currentSession ? _self.currentSession : currentSession // ignore: cast_nullable_to_non_nullable
as int,remainingSeconds: null == remainingSeconds ? _self.remainingSeconds : remainingSeconds // ignore: cast_nullable_to_non_nullable
as int,isRunning: null == isRunning ? _self.isRunning : isRunning // ignore: cast_nullable_to_non_nullable
as bool,isBreakTime: null == isBreakTime ? _self.isBreakTime : isBreakTime // ignore: cast_nullable_to_non_nullable
as bool,isAllCompleted: null == isAllCompleted ? _self.isAllCompleted : isAllCompleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
