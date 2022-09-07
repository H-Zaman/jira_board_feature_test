import 'package:get/get.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';

class TextValidators{

  TextValidators._();

  static String? email(String? string) {
    final String msg = Translate.validEmail.tr;
    if(string == null) return msg;
    final str = string.trim();
    return str.isEmail ? null : msg;
  }

  static String? password(String? string) {
    final String msg = Translate.validPassword.tr;
    if(string == null) return msg;
    final str = string.trim();
    return str.length >= 6 ? null : msg;
  }

  static String? phone(String? string) {
    final String msg = Translate.validPhoneNumber.tr;
    if(string == null) return msg;
    final str = string.trim();
    return str.isNotEmpty ? null : msg;
  }

  static String? confirmPassword(String? val, String? password) {
    if(val == null || password == null){
      return 'Translate.validPassword.tr';
    }else{
      if(val.length < 6){
        return 'Translate.validPassword.tr';
      }else if(val != password){
        return 'Translate.validConfPassword.tr';
      }else{
        return null;
      }
    }
  }

  static normal(String? string, String msg) {
    if(string == null) return msg;
    final str = string.trim();
    return str.isEmpty ? msg : null;
  }
}