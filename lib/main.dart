import 'package:flutter/material.dart';
import 'package:ordermanagement/src/utilities/helper/localization/locale_config.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  setPathUrlStrategy();

  await AllTranslations.initTranslation();

  runApp(const MyApp());
}