import 'package:flutter/material.dart';
import 'package:ordermanagement/src/customer/screens/home_screen.dart';
import 'package:ordermanagement/src/utilities/helper/localization/locale_config.dart';
import 'package:ordermanagement/src/utilities/local_storage.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  await AllTranslations.initTranslation();

  await LocalStorage.init();

  if(Uri.base.queryParameters.containsKey(HomeScreenCustomer.route.replaceAll('/', ''))){
    runApp(const MyAppCustomer());
  }else{
    runApp(const MyAppMain());
  }
}