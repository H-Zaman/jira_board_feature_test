import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/model/user.dart';
import 'package:ordermanagement/src/merchant/repository/auth_repository.dart';
import 'package:ordermanagement/src/merchant/screens/splash_screen.dart';
import 'package:ordermanagement/src/utilities/api/_api.dart';
import 'package:ordermanagement/src/utilities/local_storage.dart';
import 'user_controller.dart';

class AuthController extends GetxController{
  static AuthController get = Get.isRegistered<AuthController>() ? Get.find<AuthController>() : Get.put(AuthController());

  AuthRepo _authRepo = AuthRepo();

  final _user = UserController.get;

  LocalStorage _localStorage = LocalStorage();

  String? token;

  RxBool _loading = RxBool(false);
  bool get loading => _loading.value;

  Future<String?> login(String userName, String password) async{
    final res = await _authRepo.logIn(userName, password);
    if(res.error) {
      EResponse? error = res.data == null ? null : res.data as EResponse;
      return error == null ? res.message : error.res;
    }

    _localStorage.saveToken(res.token!);
    token = res.token!;
    _user.user = User.fromJson(res.data['profile']);

    return null;
  }

  Future<void> logout() async{
    await _localStorage.deleteToken();
    token = null;
    Get.offAllNamed(SplashScreen.route);
  }
}