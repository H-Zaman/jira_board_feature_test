import 'package:flutter/material.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';

import 'views/mobile/splash_screen.dart';
import 'views/tab/splash_screen.dart';
import 'views/web/splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeviceHelperWidget(
        mobileView: SplashScreenMobile(),
        tabView: SplashScreenTab(),
        webView: SplashScreenWeb()
    );
  }
}

