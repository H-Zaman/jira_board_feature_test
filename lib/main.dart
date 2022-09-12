import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vnotifyu/firebase_options.dart';
import 'package:vnotifyu/src/customer/screens/home_screen.dart';
import 'package:vnotifyu/src/utilities/env.dart';
import 'package:vnotifyu/src/utilities/helper/localization/locale_config.dart';
import 'package:vnotifyu/src/utilities/local_storage.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Env.initialize();

  await AllTranslations.initTranslation();

  await LocalStorage.init();

  if(Uri.base.queryParameters.containsKey(HomeScreenCustomer.route.replaceAll('/', ''))){
    runApp(const MyAppCustomer());
  }else{
    runApp(const MyAppMain());
  }
}