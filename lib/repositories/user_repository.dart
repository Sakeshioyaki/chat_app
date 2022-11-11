import 'dart:io';

import 'package:chat_app/models/user/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

abstract class UserRepository {
  Future<UserEntity> getProfile(String uid);
  Future<void> updateProfileUserToFirebase(UserEntity userEntity);
  Future<String> uploadImg(String filePath);
  Future<List<UserEntity>> getAllUser();
}

class UserRepositoryImpl extends UserRepository {
  UserRepositoryImpl();
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final storageRef = FirebaseStorage.instance.ref();
  FirebaseDatabase refRTD = FirebaseDatabase.instance;

  @override
  Future<UserEntity> getProfile(String uid) async {
    DocumentSnapshot docRef = await db.collection("users").doc(uid).get();
    UserEntity user =
        UserEntity.fromDocumentSnapshot2(documentSnapshot: docRef);
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

  @override
  Future<List<UserEntity>> getAllUser() async {
    List<UserEntity> allUser = [];
    try {
      final listUser = await db.collection("users").get();
      for (var e in listUser.docs) {
        allUser.add(UserEntity.fromDocumentSnapshot(documentSnapshot: e));
        print(
            'this is value -- ${UserEntity.fromDocumentSnapshot(documentSnapshot: e).phone}');
      }
      return allUser;
    } catch (e) {
      print("bug when get all user $e");
      return [];
      // rethrow;
    }
  }
}
