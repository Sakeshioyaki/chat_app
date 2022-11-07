import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/models/enums/load_status.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/router/route_config.dart';
import 'package:chat_app/ui/commons/app_snackbar.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

part 'input_name_state.dart';

class InputNameCubit extends Cubit<InputNameState> {
  final AppCubit appCubit;
  final UserRepository userRepo;

  InputNameCubit({required this.appCubit, required this.userRepo})
      : super(const InputNameState());

  void changeUsername({required String firstName, required String lastName}) {
    emit(state.copyWith(lastName: lastName, firstName: firstName));
  }

  void enterFirstName(String name) {
    emit(state.copyWith(firstName: name));
  }

  void enterLastName(String name) {
    emit(state.copyWith(lastName: name));
  }

  void updateName() {
    print('come update name - ${state.lastName} - ${state.firstName}');
    if (state.firstName == "") {
      AppSnackbar.showError(message: 'First name is empty');
      return;
    } else {
      emit(state.copyWith(updateProfile: LoadStatus.loading));
      appCubit.updateProfile(
        lastName: state.lastName,
        firstName: state.firstName ?? '',
      );
      Get.offNamed(RouteConfig.home);
    }
  }
}
