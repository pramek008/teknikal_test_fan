import 'package:firebase_auth/firebase_auth.dart';
import 'package:test_teknikal_fan/models/user.dart';
import 'package:test_teknikal_fan/services/user_services.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> getCurrentUser() async {
    try {
      User? user = _auth.currentUser;
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<void> reloadUser() async {
    try {
      User? user = _auth.currentUser;
      await user!.reload();
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      UserModel user =
          await UserService().getUserById(userCredential.user!.uid);
      return user;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('USER CREDENTIAL => ${userCredential.user!}');

      UserModel user = UserModel(
        id: userCredential.user!.uid,
        email: email,
        name: name,
      );

      await UserService().setUser(user);

      return user;
    } on FirebaseAuthMultiFactorException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw 'The account already exists with a different credential.';
      } else if (e.code == 'invalid-credential') {
        throw 'Error occurred while accessing credentials. Try again.';
      }
      throw e;
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> sendEmailVerification(User user) async {
    try {
      User? user = _auth.currentUser;
      await user!.sendEmailVerification();
      UserModel userModel = UserModel(
        id: user.uid,
        email: user.email!,
        name: user.displayName!,
      );
      return userModel;
    } catch (e) {
      throw e;
    }
  }

  Future<bool> isEmailVerified() async {
    try {
      User? user = _auth.currentUser;
      return user!.emailVerified;
    } catch (e) {
      throw e;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw e;
    }
  }
}
