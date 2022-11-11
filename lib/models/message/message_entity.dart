import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  String? id;
  String? content;
  String? fileUrl;
  Timestamp? timeSend;
  bool? isRead;

  MessageEntity({
    this.id,
    this.content,
    this.fileUrl,
    this.timeSend,
    this.isRead,
  });

  MessageEntity.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    content = documentSnapshot["content"];
    fileUrl = documentSnapshot["file_url"];
    timeSend = documentSnapshot["time_send"];
    isRead = documentSnapshot["is_read"];
  }
}
