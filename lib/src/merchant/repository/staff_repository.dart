import 'package:vnotifyu/src/merchant/model/user.dart';
import 'package:vnotifyu/src/utilities/api/_api.dart';

class StaffRepo{
  Future<List<User>> allStaff() async{
    final res = await Api.get(Endpoints.users);
    if(res.error) return [];

    return List<User>.from(res.data.map((staff) => User.fromJson(staff)));
  }
}