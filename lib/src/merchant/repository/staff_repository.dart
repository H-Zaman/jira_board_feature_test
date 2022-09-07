import 'package:ordermanagement/src/merchant/model/user.dart';
import 'package:ordermanagement/src/utilities/api/_api.dart';

class StaffRepo{
  Future<List<User>> allStaff() async{
    final res = await Api.get(Endpoints.staffList);
    if(res.error) return [];

    return List<User>.from(res.data.map((staff) => User.fromJson(staff)));
  }
}