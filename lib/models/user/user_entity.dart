import 'package:cloud_firestore/cloud_firestore.dart';

class UserEntity {
  String? id;
  String? firstName;
  String? lastName;
  String? phone;
  String? avatarUrl;
  bool? isOnline;
  Timestamp? lastChanged;
  String? haveStory;

  UserEntity(
      {this.id,
      this.firstName,
      this.lastName,
      this.phone,
      this.avatarUrl,
      this.isOnline,
      this.lastChanged,
      this.haveStory});

  UserEntity.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    firstName = documentSnapshot["first_name"];
    lastName = documentSnapshot["last_name"];
    phone = documentSnapshot["phone"];
    avatarUrl = documentSnapshot["avatar_url"];
    haveStory = documentSnapshot["have_story"];
  }
  UserEntity.fromDocumentSnapshot2(
      {required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    firstName = documentSnapshot["first_name"];
    lastName = documentSnapshot["last_name"];
    phone = documentSnapshot["phone"];
    avatarUrl = documentSnapshot["avatar_url"];
    // haveStory = documentSnapshot["have_story"];
  }
}
