import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_teknikal_fan/models/user.dart';

class UserService {
  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  Future<void> setUser(UserModel user) async {
    try {
      _userCollection.doc(user.id).set({
        'email': user.email,
        'name': user.name,
      });
    } catch (e) {
      throw e;
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      DocumentSnapshot userSnapshot = await _userCollection.doc(id).get();
      return UserModel(
        id: id,
        email: userSnapshot['email'],
        name: userSnapshot['name'],
      );
    } catch (e) {
      throw e;
    }
  }
}
