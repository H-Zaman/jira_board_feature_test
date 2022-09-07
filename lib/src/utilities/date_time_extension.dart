import 'package:jiffy/jiffy.dart';

extension DateTimeExtention on DateTime{
  String get fr {
    // final offset = DateTime.now().timeZoneOffset;
    return Jiffy(this).fromNow();
  }
}