import 'package:chat_app/common/app_colors.dart';
import 'package:flutter/material.dart';

import 'app_button.dart';

class AppWhiteButton extends AppButton {
  const AppWhiteButton({
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
            color: AppColors.secondary,
            fontWeight: FontWeight.bold,
          ),
          backgroundColor: Colors.white,
        );
}
