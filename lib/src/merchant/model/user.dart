import 'package:vnotifyu/src/merchant/model/business.dart';

class User {
  User({
    required this.username,
    required this.userId,
    required this.name,
    required this.userType,
    required this.email,
    required this.phoneNumber,
    this.imageId,
    this.business
  });

  String username;
  String userId;
  String name;
  UserType userType;
  String email;
  String phoneNumber;
  int? imageId;
  Business? business;

  factory User.fromJson(Map<String, dynamic> json) {
    Business? business;
    if(json['merchant-profile'] != null && json['merchant-profile'] is Map){
      business = Business.fromJson(json['merchant-profile']);
    }

    return User(
      username: json["username"],
      userId: json["user-id"],
      name: json["name"],
      userType: UserType.values.firstWhere((element) => element.name == json["user-role"]),
      email: json["email"],
      phoneNumber: json["phone-number"],
      imageId: json["image-id"] == null || json["image-id"] == '' ? null : json["image-id"],
      business: business
    );
  }
}

enum UserType{
  SYS_ADMIN,
  MERCHANT,
  STAFF
}