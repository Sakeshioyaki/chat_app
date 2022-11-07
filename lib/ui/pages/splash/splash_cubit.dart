import 'package:chat_app/database/share_preferences_helper.dart';
import 'package:chat_app/ui/pages/intro/intro_page.dart';
import 'package:chat_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState());

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    // final token = await authRepo.getToken();
    final isSeenIntro = await SharedPreferencesHelper.isSeenIntro();
    if (!isSeenIntro) {
      SharedPreferencesHelper.setSeenIntro(isSeen: true);
      Get.offAll(() => const IntroPage());
    } else {
      Get.offAll(() => const SignInPage());
      // if (token == null) {
      //   Get.offAll(() => const IntroPage());
      // } else {
      //   try {
      //     //Profile
      //     await userRepo.getProfile();
      //     // authService.updateUser(myProfile);
      //   } catch (error, s) {
      //     logger.log(error, stackTrace: s);
      //     //Check 401
      //     if (error is DioError) {
      //       if (error.response?.statusCode == 401) {
      //         // authService.signOut();
      //         checkLogin();
      //         return;
      //       }
      //     }
      //     AppDialog.defaultDialog(
      //       message: "An error happened. Please check your connection!",
      //       textConfirm: "Retry",
      //       onConfirm: () {
      //         checkLogin();
      //       },
      //     );
      //     return;
      //   }
      //   Get.offAll(() => const HomePage());
      // }
    }
  }
}
