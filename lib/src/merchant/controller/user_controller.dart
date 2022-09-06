import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/repository/user.dart';
import 'package:ordermanagement/src/utilities/api/_api.dart';

class UserController extends GetxController{
  static UserController get = Get.isRegistered<UserController>() ? Get.find<UserController>() : Get.put(UserController());

  UserRepo _repo = UserRepo();

}