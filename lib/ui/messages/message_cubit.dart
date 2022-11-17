import 'dart:async';

import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/models/enums/load_status.dart';
import 'package:chat_app/models/message/message_entity.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'message_state.dart';

class MessageCubit extends Cubit<MessageState> {
  final UserRepository userRepo;
  final AppCubit appCubit;
  StreamController listMessController = StreamController<QuerySnapshot>();
  Stream get listMessStream => listMessController.stream;

  MessageCubit({
    required this.userRepo,
    required this.appCubit,
  }) : super(const MessageState());

  void setUserId({required String id, required String name}) {
    String myId = appCubit.getUser()?.id ?? '';

    emit(state.copyWith(userId: id, name: name, myId: myId));
  }

  Future<void> sendMess() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    print("this message send ${state.content}");

    final newMess = <String, dynamic>{
      "senderId": state.myId,
      "receiveId": state.userId,
      "content": state.content ?? '',
      "file_url": state.fileUrl ?? '',
      "time_send": Timestamp.now(),
      "is_read": false,
    };

    await db
        .collection("messages")
        .doc(state.messageGroupId)
        .collection(state.messageGroupId ?? '')
        .add(newMess)
        .then((documentSnapshot) =>
            print("Added Data with ID: ${documentSnapshot.id}"))
        .onError((e, _) => print("Error writing document: $e"));
  }

  void setMessage(String? contentMessage) {
    print("this message set  ${contentMessage}");
    emit(state.copyWith(content: contentMessage));
    print("this message set  ${state.content}");
  }

  Future<void> getMessage() async {
    emit(state.copyWith(loadData: LoadStatus.loading));
    await setUpMessageGroup();

    List<MessageEntity> mess = [];
    final listMessage = await FirebaseFirestore.instance
        .collection("messages")
        .doc(state.messageGroupId)
        .collection(state.messageGroupId ?? '')
        .orderBy('time_send')
        .get();

    for (var e in listMessage.docs) {
      mess.add(MessageEntity.fromDocumentSnapshot(documentSnapshot: e));
    }
    emit(state.copyWith(messageList: mess, loadData: LoadStatus.success));
  }

  Future<void> setUpMessageGroup() async {
    final FirebaseFirestore db = FirebaseFirestore.instance;
    print("the group id is : ${state.messageGroupId}");
    print("${state.messageGroupId == ''}");
    final newInfo = {
      "count_new_mess": 0,
    };
    if (state.messageGroupId == null) {
      print('dang tao message group');
      final re = await db
          .collection("users")
          .doc(state.myId)
          .collection(state.userId ?? '')
          .get();
      if (re.docs.isNotEmpty) {
        emit(state.copyWith(messageGroupId: re.docs[0].id));
        print("da them  - ${re.docs[0].id}");
      } else {
        print('dang tao message group 2');
        late String groupId;
        await db
            .collection("users")
            .doc(state.myId)
            .collection(state.userId ?? '')
            .add(newInfo)
            .then(
          (value) {
            emit(
              state.copyWith(messageGroupId: value.id),
            );
            print("da add - ${value.id}");
            groupId = value.id;
          },
        );

        await db
            .collection("users")
            .doc(state.userId)
            .collection(state.myId ?? '')
            .doc(groupId)
            .set(newInfo)
            .onError((e, _) => print("Error writing document: $e"));
      }
    }
  }

  Stream<QuerySnapshot> listenMessage() {
    return FirebaseFirestore.instance
        .collection("messages")
        .doc(state.messageGroupId)
        .collection(state.messageGroupId ?? '')
        .orderBy('time_send')
        .snapshots();
  }

  void updateMessage(QuerySnapshot listMessage) {
    print('COME THERE');
    print("typeeeeee:  ${listMessage.docs.last['content']}");
    List<MessageEntity>? list = [...state.messageList];
    MessageEntity newMess = MessageEntity.fromDocumentSnapshot(
        documentSnapshot: listMessage.docs.last);
    list.add(newMess);
    emit(state.copyWith(messageList: list));
    // listMessage.docs.last.
  }
}
