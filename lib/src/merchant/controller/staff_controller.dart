import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/model/user.dart';
import 'package:ordermanagement/src/merchant/repository/staff_repository.dart';
import 'package:ordermanagement/src/utilities/api/_api.dart';

class StaffController extends GetxController{
  static StaffController get = Get.isRegistered<StaffController>() ? Get.find<StaffController>() : Get.put(StaffController());

  final _repo = StaffRepo();

  RxBool _loading = RxBool(false);
  bool get loading => _loading.value;

  RxBool _addEditLoading = RxBool(false);
  bool get addEditLoading => _addEditLoading.value;

  RxList<User> staffList = RxList();

  Rxn<User> _selectedStaff = Rxn();
  User? get selectedStaff => _selectedStaff.value;
  set selectedStaff (User? staff) => _selectedStaff.value = staff;

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData () async{
    await Future.wait([
      getStaffList(),
    ]);
  }

  Future<List<User>> getStaffList() async{
    _loading(true);
    staffList(await _repo.allStaff());
    _loading(false);

    return staffList;
  }


  Future<AResponse> updateStaff({
    String? name,
    String? email,
    String? phone,
    required uid
  }) async{

    _addEditLoading(true);
    final res = await _repo.updateStaff(
      name: name,
      email: email,
      phone: phone,
      uid: uid
    );
    if(!res.error)await getData();
    _addEditLoading(false);
    return res;
  }

  Future<AResponse> addStaff({
    required String name,
    required String email,
    required String username,
    required String phone,
    required String password,
  }) async{
    _addEditLoading(true);
    final res = await _repo.addStaff(
      name: name,
      email: email,
      phone: phone,
      password: password,
      username: username
    );
    await getData();
    _addEditLoading(false);
    return res;
  }
}