import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

Future<void> _backgroundNotification(RemoteMessage message) async{
  print('notification');
}

class FcmNotifications{

  static const _vapidKey = 'BK4PbphDW9DpdPTLscF2Tdh_U56WO1zhtd457r9Y823P4MlTY8cNH-Nfxe7rkdqjr3MpQbHYwLVcJBQYLC3YE3k';

  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static RxnString fcmToken = RxnString('fcm_token');

  static Future<void> initialize() async{
    await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true
    );

    bool isWeb = defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS;

    fcmToken.value = await _fcm.getToken(
      vapidKey: isWeb ? _vapidKey : null
    );

    print(fcmToken);

    _fcm.onTokenRefresh.listen((newFcmToken) => fcmToken.value = newFcmToken);

    FirebaseMessaging.onBackgroundMessage(_backgroundNotification);
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  static void _onMessage(RemoteMessage notification) {
    Get.snackbar(notification.notification!.title ?? '', notification.notification!.body ?? '');
  }

  static void _onMessageOpenedApp(RemoteMessage notification) {
    Get.snackbar(notification.notification!.title ?? '', notification.notification!.body ?? '');
  }

}