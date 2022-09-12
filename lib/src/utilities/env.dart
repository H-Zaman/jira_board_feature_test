import 'package:firebase_remote_config/firebase_remote_config.dart';

class Env{
  Env._();

  static final _remoteConfig = FirebaseRemoteConfig.instance;


  static late String baseApiUrl;

  static Future<void> initialize() async{
    await _remoteConfig.fetchAndActivate();

    baseApiUrl = _remoteConfig.getString(_EnvKeys.API_KEY);
  }
}

class _EnvKeys{
  static const String API_KEY = 'vnotifyu_base_api_url';
}