// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'signup_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$SignupEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() passwordVisible,
    required TResult Function(bool loading) isloading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? passwordVisible,
    TResult? Function(bool loading)? isloading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? passwordVisible,
    TResult Function(bool loading)? isloading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PasswordVisible value) passwordVisible,
    required TResult Function(Isloading value) isloading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PasswordVisible value)? passwordVisible,
    TResult? Function(Isloading value)? isloading,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PasswordVisible value)? passwordVisible,
    TResult Function(Isloading value)? isloading,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupEventCopyWith<$Res> {
  factory $SignupEventCopyWith(
          SignupEvent value, $Res Function(SignupEvent) then) =
      _$SignupEventCopyWithImpl<$Res, SignupEvent>;
}

/// @nodoc
class _$SignupEventCopyWithImpl<$Res, $Val extends SignupEvent>
    implements $SignupEventCopyWith<$Res> {
  _$SignupEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$PasswordVisibleCopyWith<$Res> {
  factory _$$PasswordVisibleCopyWith(
          _$PasswordVisible value, $Res Function(_$PasswordVisible) then) =
      __$$PasswordVisibleCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PasswordVisibleCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$PasswordVisible>
    implements _$$PasswordVisibleCopyWith<$Res> {
  __$$PasswordVisibleCopyWithImpl(
      _$PasswordVisible _value, $Res Function(_$PasswordVisible) _then)
      : super(_value, _then);
}

/// @nodoc

class _$PasswordVisible
    with DiagnosticableTreeMixin
    implements PasswordVisible {
  const _$PasswordVisible();

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SignupEvent.passwordVisible()';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('type', 'SignupEvent.passwordVisible'));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$PasswordVisible);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() passwordVisible,
    required TResult Function(bool loading) isloading,
  }) {
    return passwordVisible();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? passwordVisible,
    TResult? Function(bool loading)? isloading,
  }) {
    return passwordVisible?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? passwordVisible,
    TResult Function(bool loading)? isloading,
    required TResult orElse(),
  }) {
    if (passwordVisible != null) {
      return passwordVisible();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PasswordVisible value) passwordVisible,
    required TResult Function(Isloading value) isloading,
  }) {
    return passwordVisible(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PasswordVisible value)? passwordVisible,
    TResult? Function(Isloading value)? isloading,
  }) {
    return passwordVisible?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PasswordVisible value)? passwordVisible,
    TResult Function(Isloading value)? isloading,
    required TResult orElse(),
  }) {
    if (passwordVisible != null) {
      return passwordVisible(this);
    }
    return orElse();
  }
}

abstract class PasswordVisible implements SignupEvent {
  const factory PasswordVisible() = _$PasswordVisible;
}

/// @nodoc
abstract class _$$IsloadingCopyWith<$Res> {
  factory _$$IsloadingCopyWith(
          _$Isloading value, $Res Function(_$Isloading) then) =
      __$$IsloadingCopyWithImpl<$Res>;
  @useResult
  $Res call({bool loading});
}

/// @nodoc
class __$$IsloadingCopyWithImpl<$Res>
    extends _$SignupEventCopyWithImpl<$Res, _$Isloading>
    implements _$$IsloadingCopyWith<$Res> {
  __$$IsloadingCopyWithImpl(
      _$Isloading _value, $Res Function(_$Isloading) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? loading = null,
  }) {
    return _then(_$Isloading(
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$Isloading with DiagnosticableTreeMixin implements Isloading {
  const _$Isloading({required this.loading});

  @override
  final bool loading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SignupEvent.isloading(loading: $loading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SignupEvent.isloading'))
      ..add(DiagnosticsProperty('loading', loading));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Isloading &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, loading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$IsloadingCopyWith<_$Isloading> get copyWith =>
      __$$IsloadingCopyWithImpl<_$Isloading>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() passwordVisible,
    required TResult Function(bool loading) isloading,
  }) {
    return isloading(loading);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? passwordVisible,
    TResult? Function(bool loading)? isloading,
  }) {
    return isloading?.call(loading);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? passwordVisible,
    TResult Function(bool loading)? isloading,
    required TResult orElse(),
  }) {
    if (isloading != null) {
      return isloading(loading);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(PasswordVisible value) passwordVisible,
    required TResult Function(Isloading value) isloading,
  }) {
    return isloading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(PasswordVisible value)? passwordVisible,
    TResult? Function(Isloading value)? isloading,
  }) {
    return isloading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(PasswordVisible value)? passwordVisible,
    TResult Function(Isloading value)? isloading,
    required TResult orElse(),
  }) {
    if (isloading != null) {
      return isloading(this);
    }
    return orElse();
  }
}

abstract class Isloading implements SignupEvent {
  const factory Isloading({required final bool loading}) = _$Isloading;

  bool get loading;
  @JsonKey(ignore: true)
  _$$IsloadingCopyWith<_$Isloading> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SignupState {
  bool get passwordVisible => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SignupStateCopyWith<SignupState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SignupStateCopyWith<$Res> {
  factory $SignupStateCopyWith(
          SignupState value, $Res Function(SignupState) then) =
      _$SignupStateCopyWithImpl<$Res, SignupState>;
  @useResult
  $Res call({bool passwordVisible, bool loading});
}

/// @nodoc
class _$SignupStateCopyWithImpl<$Res, $Val extends SignupState>
    implements $SignupStateCopyWith<$Res> {
  _$SignupStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passwordVisible = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      passwordVisible: null == passwordVisible
          ? _value.passwordVisible
          : passwordVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$InitialCopyWith<$Res> implements $SignupStateCopyWith<$Res> {
  factory _$$InitialCopyWith(_$Initial value, $Res Function(_$Initial) then) =
      __$$InitialCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool passwordVisible, bool loading});
}

/// @nodoc
class __$$InitialCopyWithImpl<$Res>
    extends _$SignupStateCopyWithImpl<$Res, _$Initial>
    implements _$$InitialCopyWith<$Res> {
  __$$InitialCopyWithImpl(_$Initial _value, $Res Function(_$Initial) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? passwordVisible = null,
    Object? loading = null,
  }) {
    return _then(_$Initial(
      passwordVisible: null == passwordVisible
          ? _value.passwordVisible
          : passwordVisible // ignore: cast_nullable_to_non_nullable
              as bool,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$Initial with DiagnosticableTreeMixin implements Initial {
  const _$Initial({required this.passwordVisible, required this.loading});

  @override
  final bool passwordVisible;
  @override
  final bool loading;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'SignupState(passwordVisible: $passwordVisible, loading: $loading)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'SignupState'))
      ..add(DiagnosticsProperty('passwordVisible', passwordVisible))
      ..add(DiagnosticsProperty('loading', loading));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$Initial &&
            (identical(other.passwordVisible, passwordVisible) ||
                other.passwordVisible == passwordVisible) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(runtimeType, passwordVisible, loading);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InitialCopyWith<_$Initial> get copyWith =>
      __$$InitialCopyWithImpl<_$Initial>(this, _$identity);
}

abstract class Initial implements SignupState {
  const factory Initial(
      {required final bool passwordVisible,
      required final bool loading}) = _$Initial;

  @override
  bool get passwordVisible;
  @override
  bool get loading;
  @override
  @JsonKey(ignore: true)
  _$$InitialCopyWith<_$Initial> get copyWith =>
      throw _privateConstructorUsedError;
}
