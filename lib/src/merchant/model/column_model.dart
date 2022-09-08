class ColumnModel{
  int index;
  String name;
  String? subject;
  String? message;
  bool isFirstColumn;
  bool isLastColumn;
  bool notify;

  bool? _sortByFlag;
  bool get sortByFlag {
    return _sortByFlag == null ? false : _sortByFlag!;
  }
  set sortByFlag (bool value) => _sortByFlag = value;

  ColumnModel({
    required this.index,
    required this.name,
    this.subject,
    this.message,
    this.notify = false,
    this.isFirstColumn = false,
    this.isLastColumn = false,
  });

  factory ColumnModel.fromJson(Map<String, dynamic> json) => ColumnModel(
    index: json['index'],
    name: json['name'],
    subject: json['subject'],
    message: json['message'],
    notify: json['notify'],
  );

  Map<String, dynamic> toJson() =>     {
    "index": index,
    "message": message,
    "name": name,
    "notify": notify,
    "subject": subject
  };
}