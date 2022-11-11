import 'package:chat_app/blocs/app_cubit.dart';
import 'package:chat_app/common/app_images.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:chat_app/router/route_config.dart';
import 'package:chat_app/ui/pages/more/more_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

class MorePage extends StatelessWidget {
  const MorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final appCubit = RepositoryProvider.of<AppCubit>(context);
        return MoreCubit(
          appCubit: appCubit,
        );
      },
      child: const BuildChillMorePage(),
    );
  }
}

class BuildChillMorePage extends StatefulWidget {
  const BuildChillMorePage({Key? key}) : super(key: key);
  @override
  State<BuildChillMorePage> createState() => _BuildChillMorePageState();
}

class _BuildChillMorePageState extends State<BuildChillMorePage> {
  late MoreCubit cubit;
  late AppCubit appCubit;

  @override
  void initState() {
    cubit = BlocProvider.of<MoreCubit>(context);
    appCubit = BlocProvider.of<AppCubit>(context);
    super.initState();
  }

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
    return BlocBuilder<AppCubit, AppState>(
      bloc: appCubit,
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: state.user?.avatarUrl != ''
                        ? Image.network(
                            state.user?.avatarUrl ?? '',
                            height: 50,
                            width: 50,
                            fit: BoxFit.cover,
                          )
                        : SizedBox(
                            height: 50,
                            width: 50,
                            child: Center(
                              child: Image.asset(
                                AppImages.icAccount,
                                width: 37,
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.user?.lastName == ''
                            ? state.user?.firstName ?? ''
                            : '${state.user!.firstName!} ${state.user!.lastName!}',
                        style: AppTextStyle.blackS14,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        state.user?.phone ?? '',
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
      },
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
        const SizedBox(height: 20),
        GestureDetector(
          onTap: () {
            appCubit.signOut();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
            height: 50,
            width: 327,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(30)),
            child: Text(
              'LogOut',
              style: AppTextStyle.whiteS16,
            ),
          ),
        )
      ],
    );
  }
}
