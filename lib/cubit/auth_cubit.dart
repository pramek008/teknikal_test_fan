import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:test_teknikal_fan/models/user.dart';
import 'package:test_teknikal_fan/services/auth_services.dart';
import 'package:test_teknikal_fan/services/user_services.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signIn(
        email: email,
        password: password,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signUp(
        email: email,
        password: password,
        name: name,
      );
      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  // void getUser() async {
  //   try {
  //     emit(AuthLoading());
  //     UserModel user = (await AuthService().getCurrentUser()) as UserModel;
  //     if (user.id == '') {
  //       emit(AuthInitial());
  //     } else {
  //       emit(AuthSuccess(user));
  //     }
  //   } catch (e) {
  //     emit(AuthFailed(e.toString()));
  //   }
  // }

  void checkUser(String id) async {
    try {
      emit(AuthLoading());
      UserModel user = await UserService().getUserById(id);
      if (user.id == '') {
        emit(AuthInitial());
      } else {
        emit(AuthSuccess(user));
      }
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
