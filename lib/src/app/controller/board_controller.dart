import 'package:get/get.dart';
import 'package:ordermanagement/src/app/model/_model.dart';
import 'package:ordermanagement/src/app/screens/views/web/board/add_edit_card_view.dart';
import 'package:ordermanagement/src/app/screens/views/web/board/add_edit_column_view.dart';

class BoardController extends GetxController{
  static BoardController get = Get.isRegistered<BoardController>() ? Get.find<BoardController>() : Get.put(BoardController());

  int itemID = 14;

  RxList<ColumnModel> columns = [
    ColumnModel(
        id: 1,
        columnName: 'To Do',
        items: [
          CardModel(id: 1, columnId: 1, message: 'Create New Wireframe'),
          CardModel(id: 2, columnId: 1, message: 'Complete Inspection'),
          CardModel(id: 3, columnId: 1, message: 'Start On Mobile View'),
        ]
    ),
    ColumnModel(
        id: 2,
        columnName: 'In Progress',
        items: [
          CardModel(id: 4, columnId: 2, message: 'Website Rework For Production'),
          CardModel(id: 5, columnId: 2, message: 'New UI/UX Implementation'),
          CardModel(id: 6, columnId: 2, message: 'Create Controllers For State Management'),
          CardModel(id: 7, columnId: 2, message: 'Release Blog'),
          CardModel(id: 8, columnId: 2, message: 'Do Usability Testing'),
        ]
    ),
    ColumnModel(
        id: 3,
        columnName: 'In Review',
        items: [
          CardModel(id: 9, columnId: 3, message: 'Add Advertisements'),
          CardModel(id: 10, columnId: 3, message: 'Pick-up and Drop-off Date Picker not working'),
          CardModel(id: 11, columnId: 3, message: 'Localization of French & Hindi'),
        ]
    ),
    ColumnModel(
        id: 4,
        columnName: 'Done',
        items: [
          CardModel(id: 12, columnId: 4, message: 'Landing Page Design'),
          CardModel(id: 13, columnId: 4, message: 'New Drawer Design'),
        ]
    ),
  ].obs;

  void onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    CardModel movedItem = columns[oldListIndex].items.removeAt(oldItemIndex);
    movedItem.columnId = columns[newListIndex].id;
    // make newItemIndex  0 if always add to first
    columns[newListIndex].items.insert(newItemIndex, movedItem);
    columns.refresh();
  }

  void onListReorder(int oldListIndex, int newListIndex) {
    ColumnModel movedList = columns.removeAt(oldListIndex);
    columns.insert(newListIndex, movedList);
    columns.refresh();
  }

  Future<void> addCard([ColumnModel? column]) async{
    int? columnId;

    if(column != null){
      columnId = column.id;
    }

    await Get.dialog(AddEditCardView(
      columnId: columnId
    ));
  }

  Future<void> addEditColumn([ColumnModel? column]) async => await Get.dialog(AddEditColumnView(column: column));

  Future<void> editCard(CardModel item) async => await Get.dialog(AddEditCardView(
    columnId: item.columnId,
    item: item
  ));
}