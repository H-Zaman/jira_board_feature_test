import 'package:get/get.dart';

class MainHomeController extends GetxController{
  static MainHomeController get = Get.isRegistered<MainHomeController>() ? Get.find<MainHomeController>() : Get.put(MainHomeController());

  RxInt homePageIndex = RxInt(0);
}