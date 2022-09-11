import 'package:ordermanagement/src/merchant/model/card_model.dart';
import 'package:ordermanagement/src/merchant/model/column_model.dart';
import 'package:ordermanagement/src/utilities/api/_api.dart';

class BoardRepo{

  Future<List<ColumnModel>> getAllColumns() async{

    final res = await Api.get(Endpoints.columns);

    if(res.error) return [];

    return List<ColumnModel>.from(res.data['state-list'].map((column) => ColumnModel.fromJson(column)));
  }

  Future<bool> createUpdateColumns(List<ColumnModel> columns) async{

    int colIndex = 0;

    final data = {
      "state-list": List<dynamic>.from(columns.map((column) {
        colIndex++;
        return column.toJson(colIndex);
      }))
    };

    final res = await Api.put(Endpoints.columns, data: data);

    return res.error;
  }

  Future<List<CardModel>> getAllCards() async{

    final res = await Api.get(Endpoints.cards);

    if(res.error) return [];

    return List<CardModel>.from(res.data.map((column) => CardModel.fromJson(column)));
  }

  Future<bool> addCard({
    String? comment,
    required String column,
    bool? flag,
    required String cardId
  }) async{
    final data = {
      "comment": comment ?? '',
      "current-state": column,
      "flag": flag ?? false,
      "queue-id": cardId
    };

    final res = await Api.post(Endpoints.card, data: data);

    return res.error;
  }

  Future<void> moveCard(CardModel movedItem, ColumnModel movedColumn) async{
    final data = {
      "new-status": movedColumn.name,
      "queue-id": movedItem.id
    };

    await Api.patch(Endpoints.updateCardStatus, data: data);
  }

  Future<bool> updateCard({required String cardId, required String comment, required bool flag}) async{
    final data = {
      "comment": comment,
      "flag": flag,
      "queue-id": cardId
    };

    final res = await Api.patch(Endpoints.card, data: data);

    return res.error;
  }

}