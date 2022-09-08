import 'package:ordermanagement/src/merchant/model/user.dart';
import 'package:ordermanagement/src/utilities/api/_api.dart';

class StaffRepo{
  Future<List<User>> allStaff() async{
    final res = await Api.get(Endpoints.users);
    if(res.error) return [];

    return List<User>.from(res.data.map((staff) => User.fromJson(staff)));
  }

  Future<AResponse> addStaff({
    required String name,
    required String email,
    required String username,
    required String phone,
    required String password,
  }) async{
    final data = {
      "email": email,
      "image-id": '',
      "name": name,
      "password": password,
      "phone-number": phone,
      "user-role": "STAFF",
      "username": username
    };

    return await Api.post(Endpoints.users, data: data);
  }
}