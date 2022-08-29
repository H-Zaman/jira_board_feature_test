import 'package:flutter/material.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';

import 'views/mobile/home_screen.dart';
import 'views/web/home_screen.dart';

class HomeScreenMerchant extends StatelessWidget {
  static const String route = '/HomeScreenMerchant';


  const HomeScreenMerchant({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeviceHelperWidget(
      mobileView: HomeScreenMobile(),
      tabView: HomeScreenWeb(),
      webView: HomeScreenWeb()
    );
  }
}