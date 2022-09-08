import 'package:ordermanagement/src/merchant/model/user.dart';
import 'package:ordermanagement/src/utilities/api/_api.dart';

class StaffRepo{
  Future<List<User>> allStaff() async{
    final res = await Api.get(Endpoints.staffList);
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

    return await Api.post(Endpoints.staffList, data: data);
  }

  Future<AResponse> updateStaff({
    String? name,
    String? email,
    String? phone,
    required String uid
  }) async{
    final data = {
      if(name != null) 'name' : name,
      if(email != null) 'email' : email,
      if(phone != null) 'phone-number' : phone,
      if(phone != null) 'user-id' : uid,
    };

    return await Api.patch(Endpoints.staffList, data: data);
  }
}