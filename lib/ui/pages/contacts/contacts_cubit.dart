import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/models/enums/load_status.dart';
import 'package:chat_app/models/user/user_entity.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  AppCubit appCubit;
  final UserRepository userRepo;
  ContactsCubit({
    required this.appCubit,
    required this.userRepo,
  }) : super(const ContactsState());

  Future<void> getAllUser() async {
    emit(state.copyWith(loadUser: LoadStatus.loading));
    List<UserEntity> allUser = await userRepo.getAllUser();

    allUser.removeWhere((e) => e.id == state.currentUser?.id);

    UserEntity? user = appCubit.getUser();
    emit(state.copyWith(currentUser: user));

    DatabaseReference statusUser = FirebaseDatabase.instance.ref('status');
    var dataStatus = await statusUser.get();
    for (var e in allUser) {
      e.isOnline =
          dataStatus.child('${e.id}/state').value == 'online' ? true : false;

      e.lastChanged = Timestamp.fromDate(DateTime.parse(
          dataStatus.child('${e.id}/last_changed').value.toString()));

      e.haveStory = dataStatus.child('${e.id}/have_story').value as String?;
    }
    emit(state.copyWith(allUser: allUser, loadUser: LoadStatus.success));
  }

  Stream<DatabaseEvent> listenOnlineStatus() {
    DatabaseReference statusUser = FirebaseDatabase.instance.ref('status');
    return statusUser.onValue;
  }

  void updateStatus(DatabaseEvent event) {
    final data = event.snapshot.value as Map;
    List<UserEntity>? list = state.allUser ?? [];
    for (var e in list) {
      e.isOnline = data[e.id]["state"] == 'online' ? true : false;
      e.lastChanged =
          Timestamp.fromDate(DateTime.parse(data[e.id]["last_changed"]));
      e.haveStory = data[e.id]["have_story"];
    }
    emit(state.copyWith(allUser: list));
  }

  String readTimestamp(int timestamp) {
    var now = DateTime.now();
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 ||
        diff.inSeconds > 0 && diff.inMinutes == 0 ||
        diff.inMinutes > 0 && diff.inHours == 0 ||
        diff.inHours > 0 && diff.inDays == 0) {
      if (diff.inHours > 0) {
        time = '${diff.inHours} hours ago';
      } else {
        if (diff.inMinutes > 0) {
          time = '${diff.inMinutes} minutes ago';
        } else {
          time = '${diff.inSeconds} seconds ago';
        }
      }
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = '${diff.inDays} day ago';
      } else {
        time = '${diff.inDays} days ago';
      }
    } else {
      if (diff.inDays == 7) {
        time = '${(diff.inDays / 7).floor()} week ago';
      } else {
        time = '${(diff.inDays / 7).floor()} weeks ago';
      }
    }

    return time;
  }
}
