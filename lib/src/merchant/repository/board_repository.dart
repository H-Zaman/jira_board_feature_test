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

    final data = {
      "state-list": List<dynamic>.from(columns.map((column) => column.toJson()))
    };

    final res = await Api.put(Endpoints.columns, data: data);

    return res.error;
  }

  Future<List<CardModel>> getAllCards() async{

    final res = await Api.get(Endpoints.cards);

    if(res.error) return [];

    return List<CardModel>.from(res.data.map((column) => CardModel.fromJson(column)));
  }

}