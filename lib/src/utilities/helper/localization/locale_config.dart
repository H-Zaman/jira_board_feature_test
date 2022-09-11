import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:flutter/services.dart' show rootBundle;

import '_temp_en.dart';

class AllTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {};

  static Future<void> initTranslation() async{
    // final translationStrings = await Future.wait([
    //   rootBundle.loadString('assets/lang/en_US.json'),
    //   rootBundle.loadString('assets/lang/kr_KR.json'),
    // ]);
    //
    // final enMap = jsonDecode(translationStrings.first) as Map<String, dynamic>;
    // final krMap = jsonDecode(translationStrings.last) as Map<String, dynamic>;

    // Map<String, String> enMapFinal = {};
    // Map<String, String> krMapFinal = {};
    //
    // enMap.forEach((key, value) {
    //   enMapFinal.addIf(true, key, value);
    // });
    // krMap.forEach((key, value) {
    //   krMapFinal.addIf(true, key, value);
    // });

    Get.clearTranslations();
    Get.addTranslations({
      'en' : enLang,
    });
  }
}