import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/repository/auth.dart';
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
    if(res.error) return res.message;

    _localStorage.saveToken(res.token!);

    return null;
  }


}