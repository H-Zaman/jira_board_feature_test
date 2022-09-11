class AResponse{
  bool error;
  String? message;
  String? token;
  dynamic data;

  AResponse({
    required this.error,
    this.message,
    this.token,
    this.data
  });
}

class EResponse{
  String message;
  String identifier;
  int code;
  String res;

  EResponse({
    required this.message,
    required this.identifier,
    required this.code,
    required this.res,
});

  factory EResponse.fromJson(Map<String, dynamic> json) {
    return EResponse(
      message: json['message'],
      identifier: json['identifier'],
      code: int.tryParse(json['code'].toString()) ?? 100,
      res: json['resolution']
    );
  }
}