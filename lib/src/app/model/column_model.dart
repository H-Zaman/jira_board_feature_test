import 'card_model.dart';

class ColumnModel{
  int id;
  String columnName;
  bool isFirstColumn;
  bool isLastColumn;
  List<CardModel> items;

  ColumnModel({
    required this.id,
    required this.columnName,
    this.isFirstColumn = false,
    this.isLastColumn = false,
    this.items = const []
  });
}