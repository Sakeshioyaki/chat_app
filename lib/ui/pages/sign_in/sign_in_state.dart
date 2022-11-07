part of 'sign_in_cubit.dart';

class SignInState extends Equatable {
  final LoadStatus signInStatus;
  final String? phone;

  const SignInState({
    this.signInStatus = LoadStatus.initial,
    this.phone,
  });

  @override
  List<Object?> get props => [signInStatus, phone];

  SignInState copyWith({
    LoadStatus? signInStatus,
    String? phone,
    String? verificationCode,
  }) {
    return SignInState(
      signInStatus: signInStatus ?? this.signInStatus,
      phone: phone ?? this.phone,
    );
  }
}
