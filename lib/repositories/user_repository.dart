import 'dart:io';

import 'package:chat_app/models/user/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

abstract class UserRepository {
  Future<UserEntity> getProfile(String uid);
  Future<void> updateProfileUserToFirebase(UserEntity userEntity);
  Future<String> uploadImg(String filePath);
}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();

  @override
  Future<UserEntity> getProfile(String uid) async {
    DocumentSnapshot docRef = await db.collection("users").doc(uid).get();
    UserEntity user = UserEntity.fromDocumentSnapshot(documentSnapshot: docRef);
    return user;
  }

  @override
  Future<void> updateProfileUserToFirebase(UserEntity userEntity) async {
    await db.collection("users").doc(userEntity.id).update({
      "first_name": userEntity.firstName,
      "last_name": userEntity.lastName,
      "avatar_url": userEntity.avatarUrl,
    }).onError((e, _) => print("Error writing document: $e"));
    return;
    // emit(state.copyWith(user: user));
  }

  @override
  Future<String> uploadImg(String filePath) async {
    String instanceName = "/images/${basename(filePath)}";
    final imagesRef = storageRef.child(instanceName);
    File file = File(filePath);

    print('dang upload file - $filePath - $instanceName');

    try {
      final uploadTask = await imagesRef.putFile(file);
      var url = await imagesRef.getDownloadURL();
      print('dang upload file - $url');
      print('--- ${uploadTask.state}');
      return url;
    } on FirebaseException catch (e) {
      print(" this is bug ?? ${e.code} - ${e.toString()}");
    } catch (e) {
      print(e);
    }
    return "";
  }
}
