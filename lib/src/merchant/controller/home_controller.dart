import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnotifyu/src/merchant/controller/board_controller.dart';
import 'package:vnotifyu/src/merchant/controller/staff_controller.dart';

class MainHomeController extends GetxController{
  static MainHomeController get = Get.isRegistered<MainHomeController>() ? Get.find<MainHomeController>() : Get.put(MainHomeController());

  GlobalObjectKey<ScaffoldState> scaffoldKey = GlobalObjectKey('MainHomeController');

  RxInt homePageIndex = RxInt(0);


  void onChange(int index){
    homePageIndex(index);
    switch(index){
      case 0:
        BoardController.get.getData(false);
        break ;
      case 1:
        StaffController.get.getData(false);
        break ;
      case 2:
        BoardController.get.getData(false);
        break ;
      default:
        break;
    }
  }
}