import 'package:ordermanagement/src/merchant/controller/auth_controller.dart';
import 'package:ordermanagement/src/merchant/model/user.dart';
import 'package:ordermanagement/src/utilities/api/_api.dart';
import 'dart:convert';

class UserRepo{
  Future<User?> getUser() async{
    final uid = utf8.decode(base64.decode(AuthController.get.token!.split(' ').last)).split(':').last;
    final res = await Api.get(Endpoints.user(uid));
    if(res.error) return null;
    return User.fromJson(res.data);
  }
}