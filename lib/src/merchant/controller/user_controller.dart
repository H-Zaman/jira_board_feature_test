import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:vnotifyu/src/merchant/controller/auth_controller.dart';
import 'package:vnotifyu/src/merchant/model/user.dart';
import 'package:vnotifyu/src/merchant/repository/user_repository.dart';
import 'package:vnotifyu/src/utilities/api/_api.dart';
import 'package:vnotifyu/src/utilities/local_storage.dart';

class UserController extends GetxController{
  static UserController get = Get.isRegistered<UserController>() ? Get.find<UserController>() : Get.put(UserController());

  UserRepo _repo = UserRepo();
  LocalStorage _localStorage = LocalStorage();

  RxBool _loading = RxBool(false);
  bool get loading => _loading.value;

  RxBool _updateLoading = RxBool(false);
  bool get updateLoading => _updateLoading.value;

  Rxn<User> _user = Rxn();
  User get user => _user.value!;
  set user (User user)=> _user(user);

  bool get isMerchant {
    if(_user.value == null) return false;
    return user.userType == UserType.MERCHANT;
  }
  bool get isSYSAdmin {
    if(_user.value == null) return false;
    return user.userType == UserType.SYS_ADMIN;
  }
  bool get isStaff {
    if(_user.value == null) return false;
    return user.userType == UserType.STAFF;
  }

  Future<User?> getSetUser([bool load = true]) async {
    if(load) _loading(true);
    _user(await _repo.getUser());
    if(load) _loading(false);
    return user;
  }

  Future<AResponse> updateUser({
    String? name,
    String? email,
    String? phone,
    required uid,
    bool load = true
  }) async{
    _updateLoading(true);
    final res = await _repo.updateUser(
        name: name,
        email: email,
        phone: phone,
        uid: uid
    );
    _updateLoading(false);
    return res;
  }

  Future<AResponse> addUser({
    required String name,
    required String email,
    required String username,
    required String phone,
    required String password,
  }) async{
    _updateLoading(true);
    final res = await _repo.addUser(
      name: name,
      email: email,
      phone: phone,
      password: password,
      username: username
    );
    _updateLoading(false);
    return res;
  }

  Future<void> uploadImage(Uint8List imageData, String id, UserType type) async {
    _updateLoading(true);
    await _repo.uploadImage(
        imageData,
        id,
        type.name
    );
    _updateLoading(false);
  }

  Future<void> updatePassword(String password, String userId) async {
    _updateLoading(true);
    if(userId == user.userId){
      final res = await _repo.changePassword(password, userId);
      if(!res.error) {
        _localStorage.saveToken(res.token!);
        AuthController.get.token = res.token!;
        user = User.fromJson(res.data['profile']);
      }

    }else{
      await _repo.updatePassword(password, userId);
    }
    _updateLoading(false);
  }

}