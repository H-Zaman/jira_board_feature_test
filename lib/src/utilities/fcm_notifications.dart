import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

Future<void> _backgroundNotification(RemoteMessage message) async{
  print('notification');
}

class FcmNotifications{

  static const _vapidKey = 'BK4PbphDW9DpdPTLscF2Tdh_U56WO1zhtd457r9Y823P4MlTY8cNH-Nfxe7rkdqjr3MpQbHYwLVcJBQYLC3YE3k';

  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  static String? fcmToken;

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

    if(defaultTargetPlatform == TargetPlatform.iOS){
      await _fcm.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true
      );
    }

    bool isWeb = defaultTargetPlatform != TargetPlatform.android && defaultTargetPlatform != TargetPlatform.iOS;

    fcmToken = await _fcm.getToken(
      vapidKey: isWeb ? _vapidKey : null
    );

    print(fcmToken);

    _fcm.onTokenRefresh.listen((newFcmToken) => fcmToken = newFcmToken);

    FirebaseMessaging.onBackgroundMessage(_backgroundNotification);
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  static void _onMessage(RemoteMessage notification) {
    print('notification');
  }

  static void _onMessageOpenedApp(RemoteMessage notification) {
    print('notification');
  }

}