import 'package:chat_app/common/app_colors.dart';
import 'package:chat_app/common/app_images.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 50,
        leading: const Icon(
          Icons.arrow_back_ios,
          size: 12,
          color: Colors.black,
        ),
        titleSpacing: 0,
        title: const Text(
          'Athalia putri',
        ),
        titleTextStyle: AppTextStyle.blackS18,
        centerTitle: false,
        actions: [
          Image.asset(
            AppImages.icBlackSearch,
            width: 17,
          ),
          const SizedBox(width: 16),
          Image.asset(
            AppImages.icMenu,
            width: 18,
          ),
          const SizedBox(width: 20)
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: AppColors.textFieldBackground,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return buildMyChatItem();
                  },
                ),
              ),
            ),
            Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.add,
                    size: 24,
                    color: AppColors.gray,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      textAlignVertical: TextAlignVertical.bottom,
                      decoration: InputDecoration(
                        filled: true,
                        border: InputBorder.none,
                        constraints:
                            const BoxConstraints(minHeight: 36, maxHeight: 36),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(4.0),
                          ),
                        ),
                        fillColor: AppColors.textFieldBackground,
                        hintText: 'Write something',
                        hintStyle: AppTextStyle.greyS14,
                        helperStyle: AppTextStyle.greyS14,
                        alignLabelWithHint: false,
                      ),
                      style: AppTextStyle.blackS14,
                      onTap: () => {},
                    ),
                  ),
                  const SizedBox(width: 10),
                  Image.asset(
                    AppImages.icSend,
                    width: 18,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildChatItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning, did you sleep well?dddddddddddddding, did you sleep well?dddddddddddddding, did you sleep well?dddddddddddddding, did you sleep well?ddddddddddddddd',
                style: AppTextStyle.blackS14,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 5),
              Text(
                '09:45',
                style: AppTextStyle.greyS10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget buildMyChatItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
              minWidth: 100,
              maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            color: AppColors.blue,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Good morning, did you sleep well?dddddddddddddding, did you sleep well?dddddddddddddding, did you sleep well?dddddddddddddding, did you sleep well?ddddddddddddddd',
                style: AppTextStyle.whiteS14,
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 5),
              Text(
                '09:45. ${'Read'}',
                style: AppTextStyle.whiteS10,
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
