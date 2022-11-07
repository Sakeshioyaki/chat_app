part of 'input_code_cubit.dart';

class InputCodeState extends Equatable {
  final LoadStatus loadStatus;
  final String? code;
  final String? phone;
  final String? verificationCode;

  const InputCodeState({
    this.loadStatus = LoadStatus.initial,
    this.code,
    this.phone,
    this.verificationCode,
  });

  @override
  List<Object?> get props => [loadStatus, code, phone, verificationCode];

  InputCodeState copyWith({
    LoadStatus? loadStatus,
    String? code,
    String? phone,
    String? verificationCode,
  }) {
    return InputCodeState(
      loadStatus: loadStatus ?? this.loadStatus,
      code: code ?? this.code,
      phone: phone ?? this.phone,
      verificationCode: verificationCode ?? this.verificationCode,
    );
  }
}
