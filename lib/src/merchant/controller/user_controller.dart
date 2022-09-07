import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/model/user.dart';
import 'package:ordermanagement/src/merchant/repository/user.dart';

class UserController extends GetxController{
  static UserController get = Get.isRegistered<UserController>() ? Get.find<UserController>() : Get.put(UserController());

  UserRepo _repo = UserRepo();

  Rxn<User> _user = Rxn();
  User get user => _user.value!;
  set user (User user)=> _user(user);

  Future<User?> getSetUser() async => _user(await _repo.getUser());
}