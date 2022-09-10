class CardModel{
  String id;
  String column;
  String comment;
  String qr;
  String user;
  bool flag;
  DateTime updatedAt;

  CardModel({
    required this.id,
    required this.column,
    required this.comment,
    required this.qr,
    required this.user,
    required this.flag,
    required this.updatedAt,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    id: json['queue-id'],
    column: json['current-state'],
    comment: json['comment'] == null ? json['message'] ?? '' : json['comment'],
    qr: json['customer-qr-link'] ?? '',
    user: json['user-name'] ?? '',
    flag: json['flag'] == null ? json['notify'] ?? false : json['flag'],
    updatedAt: json['updated-at'] == null ? DateTime(1990) : DateTime.parse(json['updated-at']),
  );
}
