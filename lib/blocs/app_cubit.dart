import 'package:chat_app/models/enums/load_status.dart';
import 'package:chat_app/models/user/user_entity.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/ui/pages/splash/splash_page.dart';
import 'package:chat_app/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  UserRepository userRepo;
  AuthRepository authRepo;

  AppCubit({
    required this.userRepo,
    required this.authRepo,
  }) : super(AppState());

  Future<void> fetchProfile() async {
    UserEntity user = await userRepo.getProfile(state.user?.id ?? '');
    updateUser(user);
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
  }

  void updateUser(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  UserEntity? getUser() {
    return state.user;
  }

  String? getStory() {
    return state.user?.haveStory;
  }

  Future<void> updateProfile(
      {String? lastName, required String firstName, String? urlAvatar}) async {
    UserEntity newUser = UserEntity(
      id: state.user?.id,
      phone: state.user?.phone,
      firstName: firstName,
      lastName: lastName ?? state.user?.lastName,
      avatarUrl: urlAvatar ?? state.user?.avatarUrl,
    );
    emit(state.copyWith(user: newUser));
    await userRepo.updateProfileUserToFirebase(state.user ?? UserEntity());
  }

  ///Sign Out
  void signOut() async {
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    print('come logout ');
    try {
      await Future.delayed(const Duration(seconds: 2));
      DatabaseReference ref =
          FirebaseDatabase.instance.ref("status/${state.user?.id}");
      var isOnlineForFirestore = {
        "state": 'offline',
        "last_changed": Timestamp.now().toDate().toString(),
        "have_story": state.user?.haveStory,
      };
      await ref.update(isOnlineForFirestore);
      emit(state.copyWith(user: UserEntity()));
      await authRepo.removeToken();
      emit(state.removeUser().copyWith(
            signOutStatus: LoadStatus.success,
          ));
      Get.offAll(() => const SplashPage());
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }
}
