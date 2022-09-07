import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/home_controller.dart';
import 'package:ordermanagement/src/merchant/screens/merchant_staff_management_screen.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';
import 'board/board_screen.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({Key? key}) : super(key: key);

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {

  final _homeController = MainHomeController.get;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppDrawer(),
          Expanded(
            flex: 85,
            child: Obx(()=>IndexedStack(
              index: _homeController.homePageIndex.value,
              children: [
                BoardScreenWeb(),
                MerchantStaffManagementScreen()
              ],
            ))
          )
        ],
      ),
    );
  }
}