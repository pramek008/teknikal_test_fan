import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../services/auth_services.dart';

part 'email_varification_state.dart';

class EmailVarificationCubit extends Cubit<EmailVarificationState> {
  EmailVarificationCubit() : super(EmailVarificationInitial());

  final AuthService _authService = AuthService();

  void sendVerificationEmail() async {
    try {
      User? user = await AuthService().getCurrentUser();
      if (user != null) {
        emit(EmailVerificationLoading());
        // user = (await _authService.sendEmailVerification(user)) as User?;
        await user.sendEmailVerification();
        emit(EmailVerificationSent('Email verification has been sent'));
      } else {
        emit(EmailVerificationFailed('User not found'));
      }
    } catch (e) {
      emit(EmailVerificationFailed(e.toString()));
    }
  }

  void checkEmailVerified() async {
    try {
      User? user = await AuthService().getCurrentUser();
      if (user != null) {
        await user.reload();
        if (user.emailVerified) {
          emit(EmailVerificationSuccess('Email verified'));
        } else {
          emit(EmailVerificationFailed('Email not verified'));
        }
      } else {
        emit(EmailVerificationFailed('User not found'));
      }
    } catch (e) {
      emit(EmailVerificationFailed(e.toString()));
    }
  }
}
