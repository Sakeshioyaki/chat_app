import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:chat_app/repositories/auth_repository.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/ui/pages/sign_in/input_code/input_code_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class InputCodePage extends StatelessWidget {
  const InputCodePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) {
          final authRepo = RepositoryProvider.of<AuthRepository>(context);
          final userRepo = RepositoryProvider.of<UserRepository>(context);
          final appCubit = RepositoryProvider.of<AppCubit>(context);
          return InputCodeCubit(
            authRepo: authRepo,
            userRepo: userRepo,
            appCubit: appCubit,
          );
        },
        child: BuildChillPage());
  }
}

class BuildChillPage extends StatefulWidget {
  const BuildChillPage({Key? key}) : super(key: key);

  @override
  State<BuildChillPage> createState() => _BuildChillPageState();
}

class _BuildChillPageState extends State<BuildChillPage> {
  late TextEditingController textCtrl;
  late InputCodeCubit cubit;
  String? phone = Get.parameters["phone"];

  @override
  void initState() {
    super.initState();
    textCtrl = TextEditingController(text: '');
    print('vao roi kho lam ');
    cubit = BlocProvider.of<InputCodeCubit>(context);
    cubit.updatePhone(phone: Get.parameters["phone"] ?? '+84962150299');
    cubit.verifyPhone();
    // AppSnackbar.showInfo(
    //     message:
    //         'Ma code da duoc gui den may cua ban. Vui long kiem tra tin nhan tren dien thoai.');
    // print('come thers');
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<InputCodeCubit, InputCodeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: TextButton(
              onPressed: () {
                Navigator.of(context).pop;
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 12,
              ),
            ),
            shadowColor: Colors.transparent,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(2.0),
                child: Container(
                  color: Colors.transparent,
                )),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              // reverse: true,
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Enter Code',
                    style: AppTextStyle.blackS24Bold,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 295,
                    child: Text(
                      "Please confirm your country code and enter your phone number",
                      style: AppTextStyle.blackS14,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 48),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35),
                    child: BlocBuilder<InputCodeCubit, InputCodeState>(
                        builder: (context, state) {
                      return PinCodeTextField(
                          appContext: context,
                          length: 6,
                          blinkWhenObscuring: false,
                          animationType: AnimationType.fade,
                          pinTheme: PinTheme(
                            shape: PinCodeFieldShape.circle,
                            borderWidth: 1.5,
                            activeFillColor: Colors.transparent,
                            activeColor: Colors.transparent,
                            selectedFillColor: Colors.transparent,
                            selectedColor: Colors.transparent,
                            inactiveColor: Colors.transparent,
                            inactiveFillColor: Colors.grey,
                            fieldOuterPadding: EdgeInsets.zero,
                          ),
                          textStyle: const TextStyle(fontSize: 20),
                          cursorColor: Colors.black,
                          cursorHeight: 10,
                          animationDuration: const Duration(milliseconds: 200),
                          enableActiveFill: true,
                          controller: textCtrl,
                          autoDisposeControllers: false,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          keyboardType: TextInputType.number,
                          onChanged: (String value) {
                            print(value);
                            cubit.enterCode(code: value);
                          },
                          onCompleted: (String pin) async {
                            await cubit.signIn(pin);
                          });
                    }),
                  ),
                  const SizedBox(height: 60),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Resend Code',
                      style: AppTextStyle.blueS16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
