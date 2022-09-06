class CardModel{
  int id;
  int columnId;
  String message;

  CardModel({
    required this.id,
    required this.columnId,
    required this.message
  });

  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
    id: json[''],
    columnId: json[''],
    message: json['']
  );

  Map<String, dynamic> toJson() => {
    'comment':	'string',
    'current-state':	'string',
    'flag':	'boolean',
    'queue-id':	'string',
  };
}