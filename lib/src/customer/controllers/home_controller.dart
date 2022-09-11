import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnotifyu/src/customer/models/order.dart';
import 'package:vnotifyu/src/customer/repositories/order_repository.dart';
import 'package:vnotifyu/src/utilities/fcm_notifications.dart';

class HomeController extends GetxController{

  final _repo = OrderRepo();

  RxBool _loading = RxBool(false);
  bool get loading => _loading.value;

  RxBool allowNotification = RxBool(false);
  RxBool enterNumberView = RxBool(true);

  RxString merchantId = RxString('');

  TextEditingController orderIdController = TextEditingController();
  RxString orderId = RxString('');

  Rxn<Order> _orderData = Rxn();
  Order  get order => _orderData.value!;

  void onChangeNotificationPermission(bool value) async{
    allowNotification(value);

    if(value){
      await FcmNotifications.initialize();
      _repo.addFcmToken(
        merchantId.value,
        orderId.value,
        FcmNotifications.fcmToken!
      );
    }
  }

  Future<void> getOrder(String orderId) async{
    orderIdController.text = orderId;
    this.orderId(orderId);
    _loading(true);
    final order = await _repo.getOrderInfo(merchantId.value, orderId);
    if(order != null){
      _orderData(order);
      enterNumberView(false);
    }
    _loading(false);
  }
}