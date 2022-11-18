part of 'contacts_cubit.dart';

class ContactsState extends Equatable {
  final LoadStatus loadUser;
  final List<UserEntity>? allUser;
  final UserEntity? currentUser;

  const ContactsState({
    this.loadUser = LoadStatus.initial,
    this.allUser,
    this.currentUser,
  });

  @override
  List<Object?> get props => [loadUser, allUser, currentUser];

  ContactsState copyWith({
    LoadStatus? loadUser,
    List<UserEntity>? allUser,
    UserEntity? currentUser,
  }) {
    return ContactsState(
      loadUser: loadUser ?? this.loadUser,
      allUser: allUser ?? this.allUser,
      currentUser: currentUser ?? this.currentUser,
    );
  }
}
