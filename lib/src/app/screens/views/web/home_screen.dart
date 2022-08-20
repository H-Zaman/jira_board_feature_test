import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/app/screens/splash_screen.dart';
import 'package:ordermanagement/src/app/widgets/_widgets.dart';

import 'board/board_screen.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({Key? key}) : super(key: key);

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          _Drawer(),
          Expanded(
            flex: 85,
            child: IndexedStack(
              index: 0,
              children: [
                BoardScreenWeb()
              ],
            )
          )
        ],
      ),
    );
  }
}

class _Drawer extends StatelessWidget {
  const _Drawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 15,
      child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: Colors.grey.shade300,
                width: 2
              )
            )
          ),
          child: Column(
            children: [
              /// HEADER
              Container(
                height: Get.height * .15,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 2
                    )
                  )
                ),
                padding: EdgeInsets.symmetric(horizontal: 14),
                child: Row(
                  children: [
                    AppLogo(),
                    SizedBox(width: 14),
                    Expanded(
                      child: AutoSizeText(
                        'App_Name',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    )
                  ],
                ),
              ),

              /// MAIN_MENU
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10
                ),
                child: Column(
                  children: [
                    DrawerListTile(
                      icon: Icons.dashboard_outlined,
                      label: 'Board',
                      selected: true,
                    ),
                    DrawerListTile(
                      icon: Icons.bug_report_outlined,
                      label: 'Reports',
                    ),
                    DrawerListTile(
                      icon: CupertinoIcons.chat_bubble_2,
                      label: 'Messages',
                      count: 10,
                    ),
                    for(int i = 0; i< 5; i++)
                      DrawerListTile(
                        icon: Icons.api_outlined,
                        label: 'Menu ${i+1}',
                      )
                  ],
                ),
              ),

              Spacer(),
              /// END_MENU
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10
                ),
                child: Column(
                  children: [
                    DrawerListTile(
                      icon: Icons.info_outline_rounded,
                      label: 'FAQ',
                    ),
                    DrawerListTile(
                      icon: Icons.headset_mic_outlined,
                      label: 'Help Center',
                    ),
                    DrawerListTile(
                      onPressed: (){
                        Get.offAll(()=>SplashScreen());
                      },
                      icon: Icons.logout,
                      label: 'Logout',
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}
