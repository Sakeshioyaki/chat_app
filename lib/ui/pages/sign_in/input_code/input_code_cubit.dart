import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/models/enums/load_status.dart';
import 'package:chat_app/models/user/token_entity.dart';
import 'package:chat_app/models/user/user_entity.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/router/route_config.dart';
import 'package:chat_app/ui/commons/app_snackbar.dart';
import 'package:chat_app/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

part 'input_code_state.dart';

class InputCodeCubit extends Cubit<InputCodeState> {
  final AuthRepository authRepo;
  final UserRepository userRepo;
  final AppCubit appCubit;

  InputCodeCubit({
    required this.authRepo,
    required this.userRepo,
    required this.appCubit,
  }) : super(const InputCodeState());

  void enterCode({
    required String code,
  }) {
    emit(state.copyWith(code: code));
  }

  void updatePhone({
    required String phone,
  }) {
    emit(state.copyWith(phone: phone));
  }

  Future<void> signIn(String pin) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    try {
      final UserCredential? result =
          await authRepo.signIn(pin, state.verificationCode ?? '');
      if (result != null) {
        // UserEntity? myProfile = await userRepo.getProfile();
        String? token = await result.user?.getIdToken();
        print('this is token $token');
        TokenEntity tokenCurrent = TokenEntity(
          accessToken: token ?? 'token is null',
          refreshToken: 'app_refresh_token',
          isNewUser: false,
        );
        // appCubit.updateProfile();
        authRepo.saveToken(tokenCurrent);
        emit(state.copyWith(loadStatus: LoadStatus.success));
        UserEntity? myProfile = UserEntity(
          id: result.user?.uid,
          phone: state.phone,
          firstName: '',
          lastName: '',
        );
        //update user
        appCubit.updateUser(myProfile);

        if (result.additionalUserInfo!.isNewUser) {
          authRepo.createNewUser(myProfile);
          DatabaseReference ref =
              FirebaseDatabase.instance.ref("status/${result.user?.uid}");
          print(DateFormat('dd MMM y    h:mm a').format(DateTime.now()));

          var isOnlineForFirestore = {
            "state": 'online',
            "last_changed": Timestamp.fromDate(DateTime.now()).toString(),
            "have_story": ''
          };
          // isOnlineForFirestore['sate'];
          await ref.set(isOnlineForFirestore);

          Get.offNamed(RouteConfig.inputName);
        } else {
          //user da ton tai can phai lay profile
          await appCubit.fetchProfile();
          String? story = appCubit.getStory();
          DatabaseReference ref =
              FirebaseDatabase.instance.ref("status/${result.user?.uid}");
          var isOnlineForFirestore = {
            "state": 'online',
            "last_changed": Timestamp.fromDate(DateTime.now()).toString(),
            "have_story": story,
          };
          await ref.update(isOnlineForFirestore);

          Get.offNamed(RouteConfig.home);
        }
      } else {
        emit(state.copyWith(loadStatus: LoadStatus.failure));
        // Get.offNamed(RouteConfig.inputCode);
      }
    } catch (error) {
      logger.e(error);
      emit(state.copyWith(loadStatus: LoadStatus.failure));
    }
  }

  void verifyPhone() async {
    print('cmome - ${state.phone}');
    if (state.phone == '') {
      AppSnackbar.showError(message: 'Phone is empty');
      return;
    }
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "+${state.phone}",
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('wait .. user da co roi verificationCompleted');
      },
      verificationFailed: (FirebaseAuthException e) async {
        print(e.message);
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid. - ${state.phone}');
        }
        emit(state.copyWith(loadStatus: LoadStatus.failure));
      },
      codeSent: (String? verificationCode, int? resendToken) async {
        print("Nhap code di ban oi  - $verificationCode -- $resendToken");
        emit(state.copyWith(verificationCode: verificationCode));
        // Get.offNamed(RouteConfig.inputCode);

        print('sang roi dyy');
      },
      codeAutoRetrievalTimeout: (String verificationCode) async {},
      timeout: const Duration(seconds: 100),
    );
    // Get.to(() => InputCodePage());
  }
}
