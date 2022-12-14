import 'package:chat_app/common/app_images.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:chat_app/router/route_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  State<MorePage> createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 16),
        buildProfileUser(),
        const SizedBox(height: 16),
        buildSettingUser(),
        const SizedBox(height: 12),
        buildSettingApp(),
      ],
    );
  }

  Widget buildProfileUser() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.network(
                  'https://i.bloganchoi.com/bloganchoi.com/wp-content/uploads/2019/11/dich-le-nhiet-ba-0-696x435.jpg',
                  height: 50,
                  width: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Almayra Zamzamy',
                    style: AppTextStyle.blackS14,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '+62 1309 - 1710 - 1920',
                    style: AppTextStyle.greyS14,
                  )
                ],
              ),
            ],
          ),
          const Icon(
            Icons.navigate_next,
            size: 20,
            color: Colors.black,
          ),
        ],
      ),
    );
  }

  Widget buildSettingUser() {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Get.offNamed(RouteConfig.inputName);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      AppImages.icAccount,
                      width: 16,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Account',
                      style: AppTextStyle.blackS14,
                    ),
                  ],
                ),
                const Icon(
                  Icons.navigate_next,
                  size: 20,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.icChats,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Chats',
                    style: AppTextStyle.blackS14,
                  ),
                ],
              ),
              const Icon(
                Icons.navigate_next,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSettingApp() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.icAppearance,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Appereance',
                    style: AppTextStyle.blackS14,
                  ),
                ],
              ),
              const Icon(
                Icons.navigate_next,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.icNotify,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Notification',
                    style: AppTextStyle.blackS14,
                  ),
                ],
              ),
              const Icon(
                Icons.navigate_next,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.icPrivacy,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Privacy',
                    style: AppTextStyle.blackS14,
                  ),
                ],
              ),
              const Icon(
                Icons.navigate_next,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.icDataFile,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Data Usage',
                    style: AppTextStyle.blackS14,
                  ),
                ],
              ),
              const Icon(
                Icons.navigate_next,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Divider(),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.help_outline,
                    size: 20,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Help',
                    style: AppTextStyle.blackS14,
                  ),
                ],
              ),
              const Icon(
                Icons.navigate_next,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          height: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.icInvite,
                    width: 16,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Invite Your Friends',
                    style: AppTextStyle.blackS14,
                  ),
                ],
              ),
              const Icon(
                Icons.navigate_next,
                size: 20,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
