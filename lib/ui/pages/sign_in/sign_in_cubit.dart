import 'package:chat_app/models/enums/load_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(const SignInState());

  void changePhone({
    required String phone,
  }) {
    emit(state.copyWith(phone: phone));
  }

  String? getPhone() {
    return state.phone;
  }
}
