import 'package:vnotifyu/src/utilities/api/_api.dart';

class AuthRepo{
  Future<AResponse> logIn(String userName, String password) async {

    final data = {
      'username' : userName,
      'password' : password
    };

    return await Api.post(Endpoints.login, data: data);
  }
}