import 'package:chat_app/models/enums/load_status.dart';
import 'package:chat_app/models/user/user_entity.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/utils/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  UserRepository userRepo;
  AuthRepository authRepo;

  AppCubit({
    required this.userRepo,
    required this.authRepo,
  }) : super(AppState());

  void fetchProfile() {
    userRepo.getProfile();
    emit(state.copyWith(fetchProfileStatus: LoadStatus.loading));
  }

  void updateUser(UserEntity user) {
    emit(state.copyWith(user: user));
  }

  Future<void> updateProfile(
      {String? lastName, required String firstName, String? urlAvatar}) async {
    UserEntity newUser = UserEntity(
      id: state.user?.id,
      phone: state.user?.phone,
      firstName: firstName,
      lastName: lastName,
      avatarUrl: urlAvatar ?? state.user?.avatarUrl,
    );
    emit(state.copyWith(user: newUser));
    await userRepo.updateProfileUserToFirebase(state.user ?? UserEntity());
  }

  ///Sign Out
  void signOut() async {
    emit(state.copyWith(signOutStatus: LoadStatus.loading));
    try {
      await Future.delayed(const Duration(seconds: 2));
      // await authRepo.removeToken();
      emit(state.removeUser().copyWith(
            signOutStatus: LoadStatus.success,
          ));
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(signOutStatus: LoadStatus.failure));
    }
  }
}
