part of 'signup_bloc.dart';

@freezed
class SignupState with _$SignupState {
  const factory SignupState({
    required bool passwordVisible,
    required bool loading
  }) = Initial;
  factory SignupState.initial(){
    return const SignupState(passwordVisible: false, loading: false);
  }
}
