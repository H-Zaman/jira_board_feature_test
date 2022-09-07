class CardModel{
  String id;
  String column;
  String comment;
  String qr;
  String user;
  DateTime updatedAt;

  CardModel({
    required this.id,
    required this.column,
    required this.comment,
    required this.qr,
    required this.user,
    required this.updatedAt,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    id: json['queue-id'],
    column: json['current-state'],
    comment: json['comment'],
    qr: json['customer-qr-link'],
    user: json['user-name'],
    updatedAt: DateTime.parse(json['updated-at']),
  );
}
