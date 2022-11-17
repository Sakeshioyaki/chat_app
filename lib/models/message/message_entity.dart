import 'package:cloud_firestore/cloud_firestore.dart';

class MessageEntity {
  String? senderId;
  String? idMessage;
  String? receiveId;
  String? fileUrl;
  Timestamp? timeSend;
  bool? isRead;
  String? content;

  MessageEntity({
    this.senderId,
    this.idMessage,
    this.receiveId,
    this.fileUrl,
    this.timeSend,
    this.isRead,
    this.content,
  });

  MessageEntity.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    senderId = documentSnapshot["senderId"];
    receiveId = documentSnapshot["receiveId"];
    fileUrl = documentSnapshot["file_url"];
    content = documentSnapshot["content"];
    timeSend = documentSnapshot["time_send"];
    isRead = documentSnapshot["is_read"];
  }
}
