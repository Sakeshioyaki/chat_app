part of 'contacts_cubit.dart';

class ContactsState extends Equatable {
  final List<UserEntity>? allUser;

  const ContactsState({
    this.allUser,
  });

  @override
  List<Object?> get props => [allUser];

  ContactsState copyWith({
    List<UserEntity>? allUser,
  }) {
    return ContactsState(
      allUser: allUser ?? this.allUser,
    );
  }
}
