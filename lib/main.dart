import 'package:flutter/material.dart';
import 'package:ordermanagement/src/utilities/helper/localization/locale_config.dart';

import 'app.dart';

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await AllTranslations.initTranslation();

  runApp(const MyApp());
}