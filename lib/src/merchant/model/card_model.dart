class CardModel{
  String id;
  String column;
  String comment;
  String qr;
  DateTime updatedAt;

  CardModel({
    required this.id,
    required this.column,
    required this.comment,
    required this.qr,
    required this.updatedAt,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    id: json['queue-id'],
    column: json['current-state'],
    comment: json['comment'],
    qr: json['customer-qr-link'],
    updatedAt: DateTime.parse(json['updated-at']),
  );
}
