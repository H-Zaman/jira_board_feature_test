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

  RxList<ColumnModel> columns = RxList();
  RxList<CardModel> cards = RxList();

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async{
    _loading(true);
    await getAllColumns();
    await getAllCards();
    _loading(false);
  }

  Future<void> getAllColumns() async {
    columns(await _repo.getAllColumns());

    columns.sort((a,b) => a.index.compareTo(b.index));
    columns.first.isFirstColumn = true;
    columns.last.isLastColumn = true;
  }

  Future<void> getAllCards() async => cards(await _repo.getAllCards());

  Future<void> addCard({
    required String cardId,
    String? comment,
    bool? flag
  }) async {
    _loading(true);
    await _repo.addCard(
      cardId: cardId,
      column: columns.first.name,
      comment: comment,
      flag: flag
    );
    await getAllCards();
    _loading(false);
  }

  RxBool flagSort = RxBool(false);
  void sortByFlagged() {
    flagSort.value = !flagSort.value;
    if(flagSort.value){
      cards.sort((a,b){
        if(b.flag){
          return 1;
        }
        return -1;
      });
    }else{
      cards.sort((a,b) => a.updatedAt.compareTo(b.updatedAt));
    }
  }









  int itemID = 14;



  void onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    // CardModel movedItem = columns[oldListIndex].items.removeAt(oldItemIndex);
    // movedItem.column = columns[newListIndex].index;
    // // make newItemIndex  0 if always add to first
    // columns[newListIndex].items.insert(newItemIndex, movedItem);
    // columns.refresh();
  }

  void onListReorder(int oldListIndex, int newListIndex) {
    ColumnModel movedList = columns.removeAt(oldListIndex);
    columns.insert(newListIndex, movedList);
    columns.refresh();
  }

  Future<void> addEditColumn([ColumnModel? column]) async => await Get.dialog(AddEditColumnView(column: column));

  Future<void> editCard(CardModel item) async {
    // await Get.dialog(AddEditCardView(
    //     columnId: item.column,
    //     item: item
    // ));
  }
}