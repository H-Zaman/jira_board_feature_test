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

/*
QR shown
--scans
--
*/

// class CardModel {
//   CardModel({
//     this.queueId,
//     this.currentState,
//     this.userName,
//     this.comment,
//     this.flag,
//     this.customerQrLink,
//     this.updatedAt,
//   });
//
//   String queueId;
//   String currentState;
//   String userName;
//   String comment;
//   bool flag;
//   String customerQrLink;
//   DateTime updatedAt;
//
//   factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
//     queueId: json["queue-id"] == null ? null : json["queue-id"],
//     currentState: json["current-state"] == null ? null : json["current-state"],
//     userName: json["user-name"] == null ? null : json["user-name"],
//     comment: json["comment"] == null ? null : json["comment"],
//     flag: json["flag"] == null ? null : json["flag"],
//     customerQrLink: json["customer-qr-link"] == null ? null : json["customer-qr-link"],
//     updatedAt: json["updated-at"] == null ? null : DateTime.parse(json["updated-at"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "queue-id": queueId == null ? null : queueId,
//     "current-state": currentState == null ? null : currentState,
//     "user-name": userName == null ? null : userName,
//     "comment": comment == null ? null : comment,
//     "flag": flag == null ? null : flag,
//     "customer-qr-link": customerQrLink == null ? null : customerQrLink,
//     "updated-at": updatedAt == null ? null : updatedAt.toIso8601String(),
//   };
// }
