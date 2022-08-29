import 'package:get/get.dart';

class HomeController extends GetxController{
  RxBool allowNotification = RxBool(false);
  RxBool enterNumberView = RxBool(true);

  Rx<OrderStatus> orderStatus = OrderStatus.PREPARING.obs;

  void onChangeNotificationPermission(bool value) {
    allowNotification(value);
  }
}

enum OrderStatus{
  ACCEPTED,
  PREPARING,
  COMPLETE
}