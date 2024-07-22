part of 'signup_bloc.dart';

@freezed
class SignupEvent with _$SignupEvent {
  const factory SignupEvent.passwordVisible() = PasswordVisible;
  const factory SignupEvent.isloading({required bool loading})= Isloading;
}