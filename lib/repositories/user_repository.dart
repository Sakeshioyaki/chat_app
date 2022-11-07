import 'package:chat_app/models/user/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class UserRepository {
  Future<UserEntity> getProfile();
  Future<void> updateProfileUserToFirebase(UserEntity userEntity);
}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Future<UserEntity> getProfile() async {
    await Future.delayed(const Duration(seconds: 2));
    //Mock data
    return UserEntity();
    // return UserEntity.mockData();
  }

  @override
  Future<void> updateProfileUserToFirebase(UserEntity userEntity) async {
    await db.collection("users").doc(userEntity.id).update({
      "first_name": userEntity.firstName,
      "last_name": userEntity.lastName
    }).onError((e, _) => print("Error writing document: $e"));
    return;
    // emit(state.copyWith(user: user));
  }
}
