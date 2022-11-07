import 'package:chat_app/common/app_colors.dart';
import 'package:chat_app/common/app_images.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:chat_app/ui/messages/message_page.dart';
import 'package:chat_app/ui/widgets/gradien_container/gradien_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 108,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildButtonAddStory(),
              const SizedBox(width: 8),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: buildAvatarStory(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        const Divider(),
        buildSearch(),
        buildListContacts(),
      ],
    );
  }

  Padding buildSearch() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: TextField(
        textAlignVertical: TextAlignVertical.bottom,
        decoration: InputDecoration(
          filled: true,
          constraints: const BoxConstraints(minHeight: 36, maxHeight: 36),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          fillColor: AppColors.textFieldBackground,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Image.asset(
              AppImages.icSearch,
              height: 22,
            ),
          ),
          hintText: 'Search',
          hintStyle: AppTextStyle.greyS14,
          helperStyle: AppTextStyle.greyS14,
          alignLabelWithHint: false,
        ),
        style: AppTextStyle.greyS14,
        onTap: () => {},
      ),
    );
  }

  Expanded buildListContacts() {
    return Expanded(
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print('see chat');
              Get.to(() => MessagePage());
            },
            child: buildContactItem(index),
          );
        },
      ),
    );
  }

  Widget buildContactItem(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              buildAvatar(),
              const SizedBox(width: 12),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Athalia Putri',
                    style: AppTextStyle.blackS14SemiBold,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Good morning, did you sleep well?',
                    style: AppTextStyle.greyS12,
                  )
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Today',
                style: AppTextStyle.greyS10,
              ),
              const SizedBox(height: 10),
              Container(
                width: 20,
                height: 20,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.violet,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '1',
                  style: AppTextStyle.blueS10Bold,
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Stack buildAvatar() {
    return Stack(
      children: [
        SizedBox(
          height: 56,
          width: 56,
          child: GradientOutline(
            strokeWidth: 3,
            radius: 18,
            gradient: const LinearGradient(
              colors: [AppColors.startGradient, AppColors.endGradient],
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  'https://i.bloganchoi.com/bloganchoi.com/wp-content/uploads/2019/11/dich-le-nhiet-ba-0-696x435.jpg',
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            onPressed: () {
              print('see story');
            },
          ),
        ),
        Container(
          alignment: Alignment.topRight,
          height: 56,
          width: 56,
          child: Container(
            height: 14,
            width: 14,
            decoration: BoxDecoration(
              color: AppColors.onlineGreen,
              border: Border.all(
                color: AppColors.textWhite,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildAvatarStory() {
    return SizedBox(
      width: 56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              SizedBox(
                height: 56,
                width: 56,
                child: GradientOutline(
                  strokeWidth: 3,
                  radius: 18,
                  gradient: const LinearGradient(
                    colors: [AppColors.startGradient, AppColors.endGradient],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://i.bloganchoi.com/bloganchoi.com/wp-content/uploads/2019/11/dich-le-nhiet-ba-0-696x435.jpg',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  onPressed: () {
                    print('see story');
                  },
                ),
              ),
              Container(
                alignment: Alignment.topRight,
                height: 56,
                width: 56,
                child: Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: AppColors.onlineGreen,
                    border: Border.all(
                      color: AppColors.textWhite,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ),
            ],
          ),
          Text(
            'Midala huggggg',
            style:
                AppTextStyle.blackS10.copyWith(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }

  Widget buildButtonAddStory() {
    return SizedBox(
      width: 56,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 56,
            width: 56,
            child: GradientOutline(
              strokeWidth: 2,
              radius: 18,
              gradient: const LinearGradient(
                colors: [AppColors.grayBackground, AppColors.grayBackground],
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    width: 48,
                    height: 48,
                    color: AppColors.textFieldBackground,
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: AppColors.grayBackground,
                        size: 14,
                      ),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                print('see story');
              },
            ),
          ),
          Text(
            'Your Story',
            style:
                AppTextStyle.blackS10.copyWith(overflow: TextOverflow.ellipsis),
          )
        ],
      ),
    );
  }
}
