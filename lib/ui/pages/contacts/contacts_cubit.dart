import 'package:bloc/bloc.dart';
import 'package:chat_app/models/user/user_entity.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  final UserRepository userRepo;
  ContactsCubit({
    required this.userRepo,
  }) : super(const ContactsState());

  Future<void> getAllUser() async {
    List<UserEntity> allUser = await userRepo.getAllUser();

    for (var e in allUser) {
      DatabaseReference statusUser =
          FirebaseDatabase.instance.ref('status/${e.id}');
      statusUser.onValue.listen((DatabaseEvent event) {
        final data = event.snapshot.value as Map;
        e.isOnline = data["state"] == 'online' ? true : false;
        e.lastChanged = Timestamp.now();
      });
    }

    emit(state.copyWith(allUser: allUser));
  }
}
