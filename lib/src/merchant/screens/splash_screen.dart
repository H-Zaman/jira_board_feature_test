import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnotifyu/src/merchant/controller/auth_controller.dart';
import 'package:vnotifyu/src/merchant/controller/home_controller.dart';
import 'package:vnotifyu/src/merchant/controller/user_controller.dart';
import 'package:vnotifyu/src/merchant/model/user.dart';
import 'package:vnotifyu/src/merchant/screens/home_screen.dart';
import 'package:vnotifyu/src/sys_admin/screens/home_screen.dart';
import 'package:vnotifyu/src/utilities/helper/device_helper.dart';
import 'package:vnotifyu/src/widgets/_widgets.dart';

import 'views/mobile/splash_screen.dart';
import 'views/web/splash_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final _userController = UserController.get;

  @override
  void initState() {
    super.initState();
    if(AuthController.get.token != null){
      _userController.getSetUser().then((user){
        if(user != null){
          if(user.userType == UserType.STAFF){
            MainHomeController.get.onChange(0);
          }
          if(user.userType == UserType.SYS_ADMIN){
            Future.delayed(Duration(milliseconds: 300),(){
              Get.offAllNamed(HomeScreenSysAdmin.route);
            });
          }else{
            Future.delayed(Duration(milliseconds: 300),(){
              Get.offAllNamed(HomeBoardScreen.route);
            });
          }
        }
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return OverlayLoader(
      loading: AuthController.get.token != null,
      text: 'Logging In...',
      child: DeviceHelperWidget(
        mobileView: SplashScreenMobile(),
        tabView: SplashScreenWeb(),
        webView: SplashScreenWeb()
      ),
    );
  }
}

