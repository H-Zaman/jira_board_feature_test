import 'package:get/get.dart';
import 'package:vnotifyu/src/merchant/model/user.dart';
import 'package:vnotifyu/src/merchant/repository/staff_repository.dart';

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

  Future<void> getData ([bool load = true]) async{
    if(load) _loading(true);
    await Future.wait([
      getStaffList(),
    ]);
    if(load) _loading(false);
  }

  Future<List<User>> getStaffList() async{
    staffList(await _repo.allStaff());
    staffList.removeWhere((user) => user.userType == UserType.MERCHANT);
    return staffList;
  }
}