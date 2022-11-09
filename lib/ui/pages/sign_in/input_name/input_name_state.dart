part of 'input_name_cubit.dart';

class InputNameState extends Equatable {
  final LoadStatus loadStatus;
  final String? firstName;
  final String? lastName;
  final String? pathImg;

  final LoadStatus updateProfile;

  const InputNameState({
    this.loadStatus = LoadStatus.initial,
    this.updateProfile = LoadStatus.initial,
    this.firstName = "",
    this.pathImg = "",
    this.lastName = "",
  });
  @override
  List<Object?> get props => [
        loadStatus,
        firstName,
        lastName,
        pathImg,
        updateProfile,
      ];

  InputNameState copyWith({
    LoadStatus? loadStatus,
    LoadStatus? updateProfile,
    String? firstName,
    String? pathImg,
    String? lastName,
  }) {
    return InputNameState(
      loadStatus: loadStatus ?? this.loadStatus,
      updateProfile: updateProfile ?? this.updateProfile,
      firstName: firstName ?? this.firstName,
      pathImg: pathImg ?? this.pathImg,
      lastName: lastName ?? this.lastName,
    );
  }
}
