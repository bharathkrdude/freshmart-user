import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_event.dart';
part 'signup_state.dart';
part 'signup_bloc.freezed.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupState.initial()) {
    on<PasswordVisible>((event, emit) {
      emit(SignupState(passwordVisible: state.passwordVisible, loading: state.loading));
    });
    on<Isloading>((event, emit) {
      emit(SignupState(passwordVisible: state.passwordVisible, loading: event.loading));
    });
  }
}
