import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/common/app_colors.dart';
import 'package:chat_app/common/app_images.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/ui/messages/message_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MessagePage extends StatelessWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final userRepo = RepositoryProvider.of<UserRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return MessageCubit(
          userRepo: userRepo,
          appCubit: appCubit,
        );
      },
      child: const BuildChillMessagePage(),
    );
  }
}

class BuildChillMessagePage extends StatefulWidget {
  const BuildChillMessagePage({Key? key}) : super(key: key);

  @override
  State<BuildChillMessagePage> createState() => _BuildChillMessagePageState();
}

class _BuildChillMessagePageState extends State<BuildChillMessagePage> {
  late MessageCubit cubit;
  late TextEditingController contentMess;
  late Stream<QuerySnapshot> myMessage;
  late Stream<QuerySnapshot> userMessage;

  @override
  void initState() {
    cubit = BlocProvider.of<MessageCubit>(context);
    cubit.setUserId(
        id: Get.arguments["id"] ?? '', name: Get.arguments["name"] ?? '');
    contentMess = TextEditingController();
    cubit.getMessages();
    myMessage = cubit.listenMyMessage();
    userMessage = cubit.listenFriendMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MessageCubit, MessageState>(
      bloc: cubit,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leadingWidth: 50,
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back_ios,
                size: 12,
                color: Colors.black,
              ),
            ),
            titleSpacing: 0,
            title: Text(
              state.name ?? '',
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
          body: StreamBuilder<QuerySnapshot>(
            stream: userMessage,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              return StreamBuilder<QuerySnapshot>(
                  stream: myMessage,
                  builder: (context, snapshot) {
                    return SafeArea(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: AppColors.textFieldBackground,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: snapshot.hasData
                                  ? ListView.builder(
                                      itemCount: snapshot.data?.docs.length,
                                      itemBuilder: (context, index) {
                                        print(snapshot.data?.docs[index]
                                            ['content']);
                                        return Text(snapshot.data?.docs[index]
                                            ['content']);
                                      },
                                    )
                                  : Container(),
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
                                      constraints: const BoxConstraints(
                                          minHeight: 36, maxHeight: 36),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.transparent),
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
                                    controller: contentMess,
                                    onChanged: (String value) => {
                                      print("value - $value"),
                                      cubit.setMessage(value)
                                    },
                                    onSubmitted: (String value) {
                                      print("submmitt $value");
                                      cubit.sendMess();
                                    },
                                  ),
                                ),
                                const SizedBox(width: 10),
                                TextButton(
                                  onPressed: () {
                                    print("onpress - ${state.content}");
                                    cubit.sendMess();
                                  },
                                  child: Image.asset(
                                    AppImages.icSend,
                                    width: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        );
      },
    );
  }

  // SafeArea(
  // child: Column(
  // children: [
  // Expanded(
  // child: Container(
  // color: AppColors.textFieldBackground,
  // padding: const EdgeInsets.symmetric(horizontal: 16),
  // child: ListView.builder(
  // itemCount: 10,
  // itemBuilder: (BuildContext context, int index) {
  // return buildMyChatItem();
  // },
  // ),
  // ),
  // ),
  // Container(
  // height: 56,
  // padding: const EdgeInsets.symmetric(horizontal: 12),
  // child: Row(
  // mainAxisAlignment: MainAxisAlignment.start,
  // children: [
  // const Icon(
  // Icons.add,
  // size: 24,
  // color: AppColors.gray,
  // ),
  // const SizedBox(width: 10),
  // Expanded(
  // child: TextField(
  // textAlignVertical: TextAlignVertical.bottom,
  // decoration: InputDecoration(
  // filled: true,
  // border: InputBorder.none,
  // constraints: const BoxConstraints(
  // minHeight: 36, maxHeight: 36),
  // enabledBorder: const OutlineInputBorder(
  // borderSide: BorderSide(color: Colors.transparent),
  // borderRadius: BorderRadius.all(
  // Radius.circular(4.0),
  // ),
  // ),
  // fillColor: AppColors.textFieldBackground,
  // hintText: 'Write something',
  // hintStyle: AppTextStyle.greyS14,
  // helperStyle: AppTextStyle.greyS14,
  // alignLabelWithHint: false,
  // ),
  // style: AppTextStyle.blackS14,
  // controller: contentMess,
  // onChanged: (String value) => {
  // print("value - $value"),
  // cubit.setMessage(value)
  // },
  // onSubmitted: (String value) {
  // print("submmitt $value");
  // cubit.sendMess();
  // },
  // ),
  // ),
  // const SizedBox(width: 10),
  // TextButton(
  // onPressed: () {
  // print("onpress - ${state.content}");
  // cubit.sendMess();
  // },
  // child: Image.asset(
  // AppImages.icSend,
  // width: 18,
  // ),
  // ),
  // ],
  // ),
  // ),
  // ],
  // ),
  // )

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
                'Good morning, did you sleep well? dddddddddddddding, did you sleep well? dddddddddddddding, did you sleep well?dddddddddddddding, did you sleep well?ddddddddddddddd',
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
