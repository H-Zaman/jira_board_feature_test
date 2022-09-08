import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/model/user.dart';
import 'package:ordermanagement/src/merchant/repository/staff_repository.dart';

class StaffController extends GetxController{
  static StaffController get = Get.isRegistered<StaffController>() ? Get.find<StaffController>() : Get.put(StaffController());

  final _repo = StaffRepo();

  RxBool _loading = RxBool(false);
  bool get loading => _loading.value;

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
}