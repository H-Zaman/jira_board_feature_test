import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnotifyu/src/merchant/controller/home_controller.dart';
import 'package:vnotifyu/src/merchant/controller/user_controller.dart';
import 'package:vnotifyu/src/merchant/screens/add_edit_user_view.dart';
import 'package:vnotifyu/src/merchant/screens/merchant_staff_management_screen.dart';
import 'package:vnotifyu/src/merchant/screens/views/web/board/board_configuration_view.dart';
import 'package:vnotifyu/src/widgets/_widgets.dart';
import 'board/board_screen.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({Key? key}) : super(key: key);

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {

  final _homeController = MainHomeController.get;
  final _userController = UserController.get;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _homeController.scaffoldKey,
      endDrawer: Obx(()=> AddEditUserView(
        onCancel: (){
          if(_homeController.scaffoldKey.currentState != null){
            _homeController.scaffoldKey.currentState!.closeEndDrawer();
          }
        },
        user: _userController.user,
        isProfile: true,
        onDone: () => _userController.getSetUser(false),
      )),
      body: Row(
        children: [
          AppDrawer(),
          Expanded(
            flex: 85,
            child: Obx(()=>IndexedStack(
              index: _homeController.homePageIndex.value,
              children: [
                BoardScreenWeb(),
                MerchantStaffManagementScreen(),
                BoardConfigurationWeb()
              ],
            ))
          )
        ],
      ),
    );
  }
}