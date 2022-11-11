import 'dart:async';

import 'package:chat_app/blocs/app_cubit.dart';
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
      "content": state.content ?? '',
      "file_url": state.fileUrl ?? '',
      "time_send": Timestamp.now(),
      "is_read": false,
    };

    await db
        .collection("users")
        .doc(state.myId)
        .collection(state.userId ?? '')
        .add(newMess)
        .then((documentSnapshot) =>
            print("Added Data with ID: ${documentSnapshot.id}"))
        .onError((e, _) => print("Error writing document: $e"));
  }

  Future<void> getMessages() async {
    // statusUser.onValue.listen((DatabaseEvent event) {
    //   final data = event.snapshot.value as Map;
    //   print(data);
    // });
  }

  void setMessage(String? contentMessage) {
    print("this message set  ${contentMessage}");
    emit(state.copyWith(content: contentMessage));
    print("this message set  ${state.content}");
  }

  Stream<QuerySnapshot> listenFriendMessage() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(state.userId)
        .collection(state.myId ?? '')
        .snapshots();
  }

  Stream<QuerySnapshot> listenMyMessage() {
    return FirebaseFirestore.instance
        .collection("users")
        .doc(state.myId)
        .collection(state.userId ?? '')
        .snapshots();
  }

  void updateData() {}
}
