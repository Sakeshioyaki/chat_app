import 'package:chat_app/common/app_colors.dart';
import 'package:chat_app/common/app_images.dart';
import 'package:chat_app/common/app_text_styles.dart';
import 'package:chat_app/ui/pages/chat/chat_page.dart';
import 'package:chat_app/ui/pages/contacts/contacts_page.dart';
import 'package:chat_app/ui/pages/more/more_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  @override
  bool get wantKeepAlive => true;
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = [
    ContactsPage(),
    ChatPage(),
    MorePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _selectedIndex == 0
          ? buildAppBarContact()
          : (_selectedIndex == 1 ? buildAppBarChat() : buildAppBarMore()),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.textWhite,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.icContacts,
              width: 27,
            ),
            label: 'Contacts',
            activeIcon: Column(
              children: [
                Text('Contacts', style: AppTextStyle.blackS14),
                const SizedBox(height: 6),
                Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ],
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              AppImages.icChats,
              width: 24,
            ),
            label: 'Chats',
            activeIcon: Column(
              children: [
                Text('Chats', style: AppTextStyle.blackS14),
                const SizedBox(height: 6),
                Container(
                  height: 4,
                  width: 4,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(2)),
                ),
              ],
            ),
          ),
          BottomNavigationBarItem(
              icon: Image.asset(
                AppImages.icMore,
                width: 21,
              ),
              label: 'More',
              activeIcon: Column(
                children: [
                  Text('More', style: AppTextStyle.blackS14),
                  const SizedBox(height: 6),
                  Container(
                    height: 4,
                    width: 4,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(2)),
                  ),
                ],
              )),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  PreferredSize buildAppBarMore() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(30.0), // here the desired height
      child: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 70,
        leading: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            'More',
            style: AppTextStyle.blackS18Bold,
          ),
        ),
        shadowColor: Colors.transparent,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              color: Colors.transparent,
            )),
      ),
    );
  }

  PreferredSize buildAppBarChat() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(30.0), // here the desired height
      child: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 80,
        leading: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            'Chats',
            style: AppTextStyle.blackS18Bold,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.icNewMessage,
              width: 19,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(right: 24),
            alignment: Alignment.center,
            child: Image.asset(
              AppImages.icListMessage,
              width: 19,
            ),
          ),
        ],
        shadowColor: Colors.transparent,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              color: Colors.transparent,
            )),
      ),
    );
  }

  PreferredSize buildAppBarContact() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(30.0), // here the desired height
      child: AppBar(
        leadingWidth: 110,
        backgroundColor: Colors.transparent,
        leading: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            'Contacts',
            style: AppTextStyle.blackS18Bold,
          ),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 24),
            alignment: Alignment.center,
            child: const Icon(
              Icons.add,
              size: 24,
              color: Colors.black,
            ),
          )
        ],
        shadowColor: Colors.transparent,
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(2.0),
            child: Container(
              color: Colors.transparent,
            )),
      ),
    );
  }
}
