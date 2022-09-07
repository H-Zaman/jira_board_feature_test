import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/model/user.dart';
import 'package:ordermanagement/src/merchant/repository/user.dart';

class UserController extends GetxController{
  static UserController get = Get.isRegistered<UserController>() ? Get.find<UserController>() : Get.put(UserController());

  UserRepo _repo = UserRepo();

  RxBool _loading = RxBool(false);
  bool get loading => _loading.value;

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

  Future<User?> getSetUser() async {
    _loading(true);
    _user(await _repo.getUser());
    _loading(false);
    return user;
  }
}