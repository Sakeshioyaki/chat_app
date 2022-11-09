import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/database/share_preferences_helper.dart';
import 'package:chat_app/models/user/user_entity.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/router/route_config.dart';
import 'package:chat_app/ui/pages/intro/intro_page.dart';
import 'package:chat_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final AppCubit appCubit;

  SplashCubit({
    required this.authRepo,
    required this.userRepo,
    required this.appCubit,
  }) : super(const SplashState());

  void checkLogin() async {
    await Future.delayed(const Duration(seconds: 2));
    final token = await authRepo.getToken();
    final isSeenIntro = await SharedPreferencesHelper.isSeenIntro();

    if (!isSeenIntro) {
      SharedPreferencesHelper.setSeenIntro(isSeen: true);
      Get.offAll(() => const IntroPage());
    } else {
      if (token == null) {
        Get.offAll(() => const SignInPage());
      } else {
        UserCredential? userCredential =
            await authRepo.loginWithToken(token.accessToken);
        if (userCredential == null) {
          print('token het han');
          authRepo.removeToken();
          // Get.offAll(() => const SignInPage());
          Get.offNamed(RouteConfig.signIn);
        } else {
          print('da dang nhap bang token ');

          //khong the dang nhap bang token nen de tam thoi
          // authRepo.removeToken();

          UserEntity user =
              await userRepo.getProfile(userCredential.user?.uid ?? '');
          appCubit.updateUser(user);
          Get.offNamed(RouteConfig.home);
        }
        // try {
        //   //Profile
        //   await userRepo.getProfile(userCredential!.user?.uid ?? '');
        //   // authService.updateUser(myProfile);
        // } catch (error, s) {
        //   logger.log(error, stackTrace: s);
        //   //Check 401
        //   if (error is DioError) {
        //     if (error.response?.statusCode == 401) {
        //       // authService.signOut();
        //       checkLogin();
        //       return;
        //     }
        //   }
        //   AppDialog.defaultDialog(
        //     message: "An error happened. Please check your connection!",
        //     textConfirm: "Retry",
        //     onConfirm: () {
        //       checkLogin();
        //     },
        //   );
        //   return;
        // }
      }
    }
  }
}
