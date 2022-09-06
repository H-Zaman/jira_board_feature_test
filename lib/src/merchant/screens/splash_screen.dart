import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/auth_controller.dart';
import 'package:ordermanagement/src/merchant/screens/home_screen.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';

import 'views/mobile/splash_screen.dart';
import 'views/web/splash_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  // @override
  // void initState() {
  //   super.initState();
  //
  //   if(AuthController.get.token != null){
  //     Future.delayed(Duration(milliseconds: 100),(){
  //       Get.offAllNamed(HomeBoardScreen.route);
  //     });
  //   }
  // }
  
  @override
  Widget build(BuildContext context) {
    return DeviceHelperWidget(
      mobileView: SplashScreenMobile(),
      tabView: SplashScreenWeb(),
      webView: SplashScreenWeb()
    );
  }
}

