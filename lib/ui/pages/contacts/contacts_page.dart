import 'package:chat_app/common/app_colors.dart';
import 'package:chat_app/common/app_images.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:chat_app/ui/widgets/gradien_container/gradien_container.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
      child: ListView.separated(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print('see chat');
            },
            child: buildContactItem(index),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Divider(),
          );
        },
      ),
    );
  }

  Widget buildContactItem(int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
      child: Row(
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
                'Last seen yesterday',
                style: AppTextStyle.greyS12,
              )
            ],
          )
        ],
      ),
    );
  }
}
