import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/common/app_colors.dart';
import 'package:chat_app/common/app_images.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:chat_app/models/enums/load_status.dart';
import 'package:chat_app/repositories/user_repository.dart';
import 'package:chat_app/ui/messages/message_page.dart';
import 'package:chat_app/ui/pages/contacts/contacts_cubit.dart';
import 'package:chat_app/ui/widgets/gradien_container/gradien_container.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class ContactsPage extends StatelessWidget {
  const ContactsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        final userRepo = RepositoryProvider.of<UserRepository>(context);
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return ContactsCubit(userRepo: userRepo, appCubit: appCubit);
      },
      child: const ContactsChillPage(),
    );
  }
}

class ContactsChillPage extends StatefulWidget {
  const ContactsChillPage({Key? key}) : super(key: key);

  @override
  State<ContactsChillPage> createState() => _ContactsChillPageState();
}

class _ContactsChillPageState extends State<ContactsChillPage> {
  late ContactsCubit cubit;
  late Stream<DatabaseEvent> streamStatus;

  @override
  void initState() {
    cubit = BlocProvider.of<ContactsCubit>(context);
    cubit.getAllUser();
    streamStatus = cubit.listenOnlineStatus();
    streamStatus.listen((DatabaseEvent event) {
      cubit.updateStatus(event);
    });
    super.initState();
  }

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

  Widget buildListContacts() {
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        if (state.loadUser == LoadStatus.failure) {
          return const Text('faild to load');
        } else if (state.loadUser == LoadStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                cubit.getAllUser();
              },
              child: ListView.separated(
                itemCount: state.allUser?.length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print('see chat');
                      Get.to(() => MessagePage());
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
            ),
          );
        }
      },
    );
  }

  Widget buildContactItem(int index) {
    return BlocBuilder<ContactsCubit, ContactsState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
          child: Row(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 56,
                    width: 56,
                    child: state.allUser?[index].haveStory == ''
                        ? Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: state.allUser?[index].avatarUrl == ''
                                  ? Image.network(
                                      'https://i.bloganchoi.com/bloganchoi.com/wp-content/uploads/2019/11/dich-le-nhiet-ba-0-696x435.jpg',
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      state.allUser?[index].avatarUrl ?? '',
                                      width: 48,
                                      height: 48,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          )
                        : GradientOutline(
                            strokeWidth: 3,
                            radius: 18,
                            gradient: const LinearGradient(
                              colors: [
                                AppColors.startGradient,
                                AppColors.endGradient
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: state.allUser?[index].avatarUrl == ''
                                    ? Image.network(
                                        'https://i.bloganchoi.com/bloganchoi.com/wp-content/uploads/2019/11/dich-le-nhiet-ba-0-696x435.jpg',
                                        width: 48,
                                        height: 48,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.network(
                                        state.allUser?[index].avatarUrl ?? '',
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
                  state.allUser?[index].isOnline ?? false
                      ? Container(
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
                        )
                      : const SizedBox(),
                ],
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  var parameters = <String, String>{
                    "id": state.allUser?[index].id ?? '',
                    "name":
                        '${state.allUser?[index].firstName} ${state.allUser?[index].lastName}',
                  };
                  Get.to(const MessagePage(), arguments: parameters);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${state.allUser?[index].firstName} ${state.allUser?[index].lastName}",
                      style: AppTextStyle.blackS14SemiBold,
                    ),
                    const SizedBox(height: 5),
                    state.allUser?[index].isOnline ?? false
                        ? const SizedBox()
                        : Text(
                            "Online ${(cubit.readTimestamp(state.allUser?[index].lastChanged?.millisecondsSinceEpoch ?? Timestamp.now().millisecondsSinceEpoch))}",
                            style: AppTextStyle.greyS12,
                          )
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
