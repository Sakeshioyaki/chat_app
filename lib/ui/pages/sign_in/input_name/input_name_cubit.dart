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

  Future<void> updateName() async {
    print('come update name - ${state.lastName} - ${state.firstName}');
    if (state.firstName == "") {
      AppSnackbar.showError(message: 'First name is empty');
      return;
    } else {
      emit(state.copyWith(updateProfile: LoadStatus.loading));
      if (state.pathImg != "") {
        print("this is pathimg - ${state.pathImg}");
        String link = await uploadImage();
        await appCubit.updateProfile(
          lastName: state.lastName,
          firstName: state.firstName ?? '',
          urlAvatar: link,
        );
        print("hoan thanh vs img da upload ${link}");
      } else {
        appCubit.updateProfile(
          lastName: state.lastName,
          firstName: state.firstName ?? '',
        );
      }

      Get.offNamed(RouteConfig.home);
    }
  }

  void setFileUrl(String url) {
    print('upload img -- avatar - $url');
    emit(state.copyWith(pathImg: url));
  }

  Future<String> uploadImage() async {
    try {
      String url = await userRepo.uploadImg(state.pathImg ?? "");
      print("bug ??? $url");
      return url;
    } catch (e) {
      print('bugg khi upload anh');
    }
    return "";
    // update();
  }
}
