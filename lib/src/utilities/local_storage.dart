import 'dart:ui';
import 'package:get_storage/get_storage.dart';
import 'package:ordermanagement/src/merchant/controller/auth_controller.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';

class LocalStorage{

  static final _instance = GetStorage();

  static Future<void> init() async{
    await _instance.initStorage;
    AuthController.get.token = 'Basic c21rbWE6MTIzNDU2';
  }

  Future<void> saveToken(String token) async => await _instance.write(LocalStorageKeys.token, token);

  Future<void> deleteToken() async => await _instance.remove(LocalStorageKeys.token);

  Future<void> saveLanguagePreference(Locale locale) async => await _instance.write(LocalStorageKeys.locale, locale.languageCode);

  Locale getLanguagePreference() {
    String? langKey = _instance.read(LocalStorageKeys.locale);
    if(langKey == null || langKey == 'en'){
      return Translate.localeEn;
    }
    return Translate.localeEn;
  }

}

class LocalStorageKeys{
  LocalStorageKeys._();

  static const String user = 'user_profile';
  static const String token = 'user_auth_token';
  static const String locale = 'user_lang_pref';
  static const String location = 'user_last_location';
  static const String searchedLocations = 'user_location_search_list';
}