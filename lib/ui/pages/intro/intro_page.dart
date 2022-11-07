import 'package:chat_app/common/app_colors.dart';
import 'package:chat_app/common/app_images.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:chat_app/ui/pages/sign_in/sign_in_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 80),
              child: Column(
                children: [
                  Center(
                    child: SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset(AppImages.imgSplash),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: 280,
                    child: Text(
                      "Connect easily with your family and friends over countries",
                      style: AppTextStyle.blackS24Bold,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Text(
                    'Terms & Privacy Policy',
                    style: AppTextStyle.blackS14,
                  ),
                  const SizedBox(height: 18),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(() => const SignInPage());
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 18),
                      height: 55,
                      width: 327,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AppColors.blue,
                          borderRadius: BorderRadius.circular(30)),
                      child: Text(
                        'Start Messaging',
                        style: AppTextStyle.whiteS16,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
