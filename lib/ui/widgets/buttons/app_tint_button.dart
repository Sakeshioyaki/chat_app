import 'package:chat_app/common/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_button.dart';

class AppTintButton extends AppButton {
  const AppTintButton({
    Key? key,
    @required String? title,
    bool isLoading = false,
    VoidCallback? onPressed,
  }) : super(
            key: key,
            title: title,
            isLoading: isLoading,
            onPressed: onPressed,
            textStyle: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
            backgroundColor: AppColors.blue,
            cornerRadius: 30.0);
}
