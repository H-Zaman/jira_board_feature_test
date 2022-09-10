class Business{
  String name;
  String ownerName;
  String ownerId;
  String? image;
  String address;
  String email;
  String phone;
  String qr;

  Business({
    required this.name,
    required this.qr,
    required this.address,
    required this.email,
    this.image,
    required this.phone,
    required this.ownerId,
    required this.ownerName
  });

  factory Business.fromJson(Map<String, dynamic> json) => Business(
    name: json['business-name'],
    qr: json['merchant-qr-link'] ?? '',
    address: json['merchant-address'],
    email: json['merchant-email'],
    phone: json['merchant-contact'],
    ownerId: json['merchant-id'],
    ownerName: json['merchant-name'],
    image: json['image-id'] == '' || json['image-id'] == null ? null : json['image-id']
  );

}