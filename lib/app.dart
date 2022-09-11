import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vnotifyu/src/customer/screens/home_screen.dart';
import 'package:vnotifyu/src/merchant/screens/home_screen.dart';
import 'package:vnotifyu/src/merchant/screens/merchant_staff_management_screen.dart';
import 'package:vnotifyu/src/merchant/screens/splash_screen.dart';
import 'package:vnotifyu/src/sys_admin/screens/home_screen.dart';
import 'package:vnotifyu/src/utilities/helper/localization/locale_config.dart';
import 'package:vnotifyu/src/utilities/helper/localization/translation_keys.dart';

class MyAppMain extends StatelessWidget {
  const MyAppMain({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Demo Board Management Web',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.dmSansTextTheme(),
        scaffoldBackgroundColor: Colors.white
      ),
      locale: Translate.localeEn,
      translations: AllTranslations(),
      routes: {
        SplashScreen.route : (context) => SplashScreen(),
        HomeBoardScreen.route : (context) => HomeBoardScreen(),
        HomeScreenSysAdmin.route : (context) => HomeScreenSysAdmin(),
        MerchantStaffManagementScreen.route : (context) => MerchantStaffManagementScreen(),
      },
      initialRoute: SplashScreen.route,
    );
  }
}

class MyAppCustomer extends StatelessWidget {
  const MyAppCustomer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final params = Uri.base.queryParameters;
    return GetMaterialApp(
      title: 'Customer Section',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.dmSansTextTheme(),
        scaffoldBackgroundColor: Colors.white
      ),
      locale: Translate.localeEn,
      translations: AllTranslations(),
      routes: {
        '/' : (context) => HomeScreenCustomer(
          merchantId: params['mId']!,
          orderId: params['oId'],
        ),
      },
      initialRoute: '/',
    );
  }
}