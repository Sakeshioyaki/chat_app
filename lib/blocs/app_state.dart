part of 'app_cubit.dart';

class AppState extends Equatable {
  final UserEntity? user;
  bool isNewUser;
  final LoadStatus fetchProfileStatus;
  final LoadStatus signOutStatus;

  AppState({
    this.user,
    this.isNewUser = true,
    this.fetchProfileStatus = LoadStatus.initial,
    this.signOutStatus = LoadStatus.initial,
  });

  AppState copyWith({
    UserEntity? user,
    bool? isNewUser,
    LoadStatus? fetchProfileStatus,
    LoadStatus? signOutStatus,
  }) {
    return AppState(
      user: user ?? this.user,
      isNewUser: this.isNewUser,
      fetchProfileStatus: fetchProfileStatus ?? this.fetchProfileStatus,
      signOutStatus: signOutStatus ?? this.signOutStatus,
    );
  }

  AppState removeUser() {
    return AppState(
      user: user,
      isNewUser: true,
      fetchProfileStatus: fetchProfileStatus,
      signOutStatus: signOutStatus,
    );
  }

  @override
  List<Object?> get props => [
        user,
        fetchProfileStatus,
        signOutStatus,
      ];
}
