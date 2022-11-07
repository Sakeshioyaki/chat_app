part of 'input_name_cubit.dart';

class InputNameState extends Equatable {
  final LoadStatus loadStatus;
  final String? firstName;
  final String? lastName;
  final LoadStatus updateProfile;

  const InputNameState({
    this.loadStatus = LoadStatus.initial,
    this.updateProfile = LoadStatus.initial,
    this.firstName,
    this.lastName,
  });
  @override
  List<Object?> get props => [
        loadStatus,
        firstName,
        lastName,
        updateProfile,
      ];

  InputNameState copyWith({
    LoadStatus? loadStatus,
    LoadStatus? updateProfile,
    String? firstName,
    String? lastName,
  }) {
    return InputNameState(
      loadStatus: loadStatus ?? this.loadStatus,
      updateProfile: updateProfile ?? this.updateProfile,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }
}
