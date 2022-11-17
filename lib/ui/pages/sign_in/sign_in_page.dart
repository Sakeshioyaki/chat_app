import 'package:chat_app/common/app_colors.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:chat_app/models/enums/load_status.dart';
import 'package:chat_app/ui/commons/phone_field/intl_phone_field.dart';
import 'package:chat_app/ui/pages/sign_in/input_code/input_code_page.dart';
import 'package:chat_app/ui/widgets/buttons/app_tint_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'sign_in_cubit.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        return SignInCubit();
      },
      child: const SignInChildPage(),
    );
  }
}

class SignInChildPage extends StatefulWidget {
  const SignInChildPage({Key? key}) : super(key: key);

  @override
  State<SignInChildPage> createState() => _SignInChildPageState();
}

class _SignInChildPageState extends State<SignInChildPage> {
  late TextEditingController phoneTextController;

  late SignInCubit cubit;

  @override
  void initState() {
    super.initState();
    phoneTextController = TextEditingController(text: '962150299');

    cubit = BlocProvider.of<SignInCubit>(context);
    cubit.changePhone(phone: phoneTextController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBodyWidget(),
      resizeToAvoidBottomInset: false,
    );
  }

  Widget buildBodyWidget() {
    return Scaffold(
      appBar: AppBar(
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
        backgroundColor: Colors.transparent,
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
                'Enter Your Phone Number',
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
              BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
                return Container(
                  height: 36,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: IntlPhoneField(
                    dropdownTextStyle: AppTextStyle.greyS14,
                    showDropdownIcon: false,
                    decoration: InputDecoration(
                      hintText: 'Phone Number',
                      // labelText: '962150299',
                      hintStyle: AppTextStyle.greyS14,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(4.0),
                          borderSide: BorderSide.none),
                      fillColor: AppColors.textFieldBackground,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                    ),
                    initialCountryCode: 'VN',
                    disableLengthCheck: true,
                    onChanged: (phone) {
                      cubit.changePhone(phone: phone.completeNumber);
                      print(phone);
                    },
                    keyboardType: TextInputType.number,
                    // keyboardAppearance:,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9.,]')),
                    ],
                    validator: (value) {
                      {
                        String pattern = r'(^[0-9]{9,10}$)';
                        RegExp regExp = RegExp(pattern);
                        if (value!.number.isEmpty) {
                          return 'Please enter mobile number';
                        } else if (!regExp.hasMatch(value!.number)) {
                          print('${value!.number}');
                          return 'Please enter valid mobile number';
                        }
                        return null;
                      }
                    },
                  ),
                );
              }),
              const SizedBox(height: 80),
              _buildSignButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSignButton() {
    return BlocBuilder<SignInCubit, SignInState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: AppTintButton(
            title: 'Continue',
            onPressed: () {
              // Get.toNamed("/inputCode/:${state.phone}");
              // cubit.verifyPhone();
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const InputCodePage(state.phone),
              //   ),
              // );
              Get.to(const InputCodePage(), arguments: state.phone);
            },
            isLoading: state.signInStatus == LoadStatus.loading,
          ),
        );
      },
    );
  }
}
