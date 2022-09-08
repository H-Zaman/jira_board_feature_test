import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/auth_controller.dart';
import 'package:ordermanagement/src/merchant/controller/home_controller.dart';
import 'package:ordermanagement/src/merchant/controller/user_controller.dart';
import 'package:ordermanagement/src/merchant/screens/splash_screen.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';

import '_widgets.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeviceHelperWidget(
      mobileView: _MobileDrawer(),
      tabView: _WebDrawer(),
      webView: _WebDrawer()
    );
  }
}

class _MobileDrawer extends StatelessWidget {
  const _MobileDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: Get.width * .7,
        backgroundColor: Colors.white,
        child: Column(
          children: [
            /// HEADER
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(
                color: Colors.white
              ),
              currentAccountPictureSize: Size(
                Get.width * .6,
                72
              ),
              currentAccountPicture: Row(
                children: [
                  AppLogo(size: 52),
                  SizedBox(width: 8),
                  Expanded(
                    child: AutoSizeText(
                      'App_Name',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w900
                      ),
                    ),
                  )
                ],
              ),
              accountName: Text(
                'Some Name',
                style: TextStyle(
                  color: Colors.black
                ),
              ),
              accountEmail: Text(
                'some@email.com',
                style: TextStyle(
                  color: Colors.black
                ),
              )
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
                  for(int i = 0; i< 3; i++)
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
                      Get.offAllNamed(SplashScreen.route);
                    },
                    icon: Icons.logout,
                    label: 'Logout',
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WebDrawer extends StatelessWidget {
  const _WebDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _userController = UserController.get;
    final _homeController = MainHomeController.get;

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
        child: Obx(()=>Column(
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
                    selected: _homeController.homePageIndex.value == 0,
                    onPressed: () => _homeController.homePageIndex(0),
                  ),
                  if(_userController.isMerchant) DrawerListTile(
                    icon: CupertinoIcons.person_2_fill,
                    label: 'Staff',
                    selected: _homeController.homePageIndex.value == 1,
                    onPressed: () => _homeController.homePageIndex(1),
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
                    onPressed: (){
                      if(!_userController.loading) _homeController.scaffoldKey.currentState!.openEndDrawer();
                    },
                    icon: Icons.person,
                    label: 'Profile',
                  ),
                  DrawerListTile(
                    icon: Icons.info_outline_rounded,
                    label: 'FAQ',
                  ),
                  DrawerListTile(
                    icon: Icons.headset_mic_outlined,
                    label: 'Help Center',
                  ),
                  DrawerListTile(
                    onPressed: AuthController.get.logout,
                    icon: Icons.logout,
                    label: 'Logout',
                  )
                ],
              ),
            ),
          ],
        ))
      ),
    );
  }
}


