import 'package:chat_app/database/secure_storage_helper.dart';
import 'package:chat_app/models/user/token_entity.dart';
import 'package:chat_app/models/user/user_entity.dart';
import 'package:chat_app/ui/commons/app_snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class AuthRepository {
  Future<TokenEntity?> getToken();

  Future<void> saveToken(TokenEntity token);

  Future<void> removeToken();

  Future<UserCredential?> signIn(String pin, String verificationId);
  Future<bool> createNewUser(UserEntity user);
}

class AuthRepositoryImpl extends AuthRepository {
  AuthRepositoryImpl();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Future<TokenEntity?> getToken() async {
    return await SecureStorageHelper.instance.getToken();
  }

  @override
  Future<void> removeToken() async {
    return SecureStorageHelper.instance.removeToken();
  }

  @override
  Future<void> saveToken(TokenEntity token) async {
    return SecureStorageHelper.instance.saveToken(token);
  }

  // Future<TokenEntity?> signIn(String username, String password) async {
  //
  //   await Future.delayed(const Duration(seconds: 2));
  //   return TokenEntity(
  //       accessToken: 'app_access_token', refreshToken: 'app_refresh_token');
  // }
  @override
  Future<UserCredential?> signIn(String pin, String verificationId) async {
    print("pin $pin");
    final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: pin);
    try {
      UserCredential firebaseUser =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print("Login Successful");

      return firebaseUser;
    } on FirebaseAuthException catch (e) {
      print('Failed with error code: ${e.code}');
      if (e.code == 'invalid-verification-code') {
        AppSnackbar.showError(message: 'invalid-verification-code');
      }
      print(e.message);
    } catch (e) {
      print("Login not successful");
    }
    return null;
  }

  Future<bool> createNewUser(UserEntity user) async {
    try {
      await _firestore.collection("users").doc(user.id).set({
        "first_name": user.firstName,
        "last_name": user.lastName,
        "phone": user.phone,
      });
      print('dang tao userController - va add user vo database - ${user.id}');
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
