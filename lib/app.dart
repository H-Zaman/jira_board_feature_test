import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ordermanagement/src/customer/screens/home_screen.dart';
import 'package:ordermanagement/src/merchant/screens/home_screen.dart';
import 'package:ordermanagement/src/merchant/screens/merchant_staff_management_screen.dart';
import 'package:ordermanagement/src/merchant/screens/splash_screen.dart';
import 'package:ordermanagement/src/sys_admin/screens/home_screen.dart';
import 'package:ordermanagement/src/utilities/helper/localization/locale_config.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
        HomeScreenCustomer.route : (context) => HomeScreenCustomer(),
        HomeBoardScreen.route : (context) => HomeBoardScreen(),
        HomeScreenSysAdmin.route : (context) => HomeScreenSysAdmin(),
        MerchantStaffManagementScreen.route : (context) => MerchantStaffManagementScreen(),
      },
      // initialRoute: Uri.base.path,
      initialRoute: SplashScreen.route,
    );
  }
}