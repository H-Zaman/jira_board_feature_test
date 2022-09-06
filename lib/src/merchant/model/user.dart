class User {
  User({
    required this.username,
    required this.userId,
    required this.name,
    required this.userRole,
    required this.email,
    required this.phoneNumber,
    this.imageId,
  });

  String username;
  String userId;
  String name;
  String userRole;
  String email;
  String phoneNumber;
  String? imageId;

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: json["username"],
    userId: json["user-id"],
    name: json["name"],
    userRole: json["user-role"],
    email: json["email"],
    phoneNumber: json["phone-number"],
    imageId: json["image-id"] == null || json["image-id"] == '' ? null : json["image-id"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "user-id": userId,
    "name": name,
    "user-role": userRole,
    "email": email,
    "phone-number": phoneNumber,
    "image-id": imageId,
  };
}
