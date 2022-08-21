import 'package:flutter/material.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';

import 'views/mobile/home_screen.dart';
import 'views/tab/home_screen.dart';
import 'views/web/home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeviceHelper(
      mobileView: HomeScreenMobile(),
      tabView: HomeScreenTab(),
      webView: HomeScreenWeb()
    );
  }
}