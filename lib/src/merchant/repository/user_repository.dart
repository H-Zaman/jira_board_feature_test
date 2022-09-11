import 'dart:typed_data';
import 'package:vnotifyu/src/merchant/controller/auth_controller.dart';
import 'package:vnotifyu/src/merchant/model/user.dart';
import 'package:vnotifyu/src/utilities/api/_api.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class UserRepo{
  Future<User?> getUser() async{
    final uid = utf8.decode(base64.decode(AuthController.get.token!.split(' ').last)).split(':').last;
    final res = await Api.get(Endpoints.user(uid));
    if(res.error) return null;
    return User.fromJson(res.data);
  }

  Future<AResponse> updateUser({
    String? name,
    String? email,
    String? phone,
    required String uid
  }) async{
    final data = {
      if(name != null) 'name' : name,
      if(email != null) 'email' : email,
      if(phone != null) 'phone-number' : phone,
      if(phone != null) 'user-id' : uid,
    };

    return await Api.patch(Endpoints.users, data: data);
  }

  Future<AResponse> addUser({
    required String name,
    required String email,
    required String username,
    required String phone,
    required String password,
  }) async{
    final data = {
      "email": email,
      "image-id": '',
      "name": name,
      "password": password,
      "phone-number": phone,
      "user-role": "STAFF",
      "username": username
    };

    return await Api.post(Endpoints.users, data: data);
  }

  Future<void> uploadImage(Uint8List imageData, String id, String type) async{
    final data = {
      'files' : [MultipartFile.fromBytes(imageData)],
      'id' : id,
      'type' : type,
    };
    // final data = {
    //   'files' : [MultipartFile.fromString(base64.encode(imageData))],
    //   'id' : id,
    //   'type' : type,
    // };
    //
    print(data);
    final formData = FormData.fromMap(data);
    
    await Api.post(Endpoints.images, data: formData);
  }

  Future<void> updatePassword(String password, String userId) async{
    final data = {
      'password' : password,
      'user-id' : userId,
    };
    await Api.patch(Endpoints.resetPassword, data: data);

  }
}