import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/model/card_model.dart';
import 'package:ordermanagement/src/merchant/model/column_model.dart';
import 'package:ordermanagement/src/merchant/repository/board_repository.dart';
import 'package:ordermanagement/src/merchant/screens/views/web/board/add_edit_column_view.dart';

class BoardController extends GetxController{
  static BoardController get = Get.isRegistered<BoardController>() ? Get.find<BoardController>() : Get.put(BoardController());

  final _repo = BoardRepo();

  RxBool _loading = RxBool(false);
  bool get loading => _loading.value;

  RxBool _addCardOngoing = RxBool(false);
  bool get addCardOngoing => _addCardOngoing.value;

  RxnString updateCardId = RxnString();

  RxList<ColumnModel> columns = RxList();
  RxList<CardModel> cards = RxList();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData([bool load = true]) async{
    if(load) _loading(true);
    await getAllCards();
    await getAllColumns();
    if(load) _loading(false);
  }

  Future<void> getAllColumns() async {
    columns(await _repo.getAllColumns());

    columns.sort((a,b) => a.index.compareTo(b.index));
    columns.first.isFirstColumn = true;
    columns.last.isLastColumn = true;

    columns.forEach((column) {
      column.cards = cards.where((card) => card.column == column.name).toList();
    });
  }

  Future<void> getAllCards() async => cards(await _repo.getAllCards());

  Future<void> addCard({
    required String cardId,
    String? comment,
    bool? flag
  }) async {
    _addCardOngoing(true);
    await _repo.addCard(
      cardId: cardId,
      column: columns.first.name,
      comment: comment,
      flag: flag
    );
    await getData(false);
    _addCardOngoing(false);
  }

  Future<void> editCard({
    required String cardId,
    required String comment,
    required bool flag
  }) async {
    updateCardId(cardId);
    await _repo.updateCard(
      cardId: cardId,
      comment: comment,
      flag: flag
    );
    await getData(false);
    updateCardId.value = null;
  }

  Future<void> updateColumn () async {
    await _repo.createUpdateColumns(columns);
    await getAllColumns();
  }

  void onItemReorder(oldItemIndex, oldListIndex, _, newListIndex) async{
    if(oldListIndex == newListIndex) return ;
    CardModel movedItem = columns[oldListIndex].cards.removeAt(oldItemIndex);
    columns[newListIndex].cards.insert(0, movedItem);
    columns.refresh();
    await _repo.moveCard(
      movedItem,
      columns[newListIndex]
    );
    await getData(false);
    columns.refresh();
  }




  void onListReorder(int oldListIndex, int newListIndex) {
    ColumnModel movedList = columns.removeAt(oldListIndex);
    columns.insert(newListIndex, movedList);
    columns.refresh();
  }

  Future<void> addEditColumn([ColumnModel? column]) async => await Get.dialog(AddEditColumnView(column: column));

}