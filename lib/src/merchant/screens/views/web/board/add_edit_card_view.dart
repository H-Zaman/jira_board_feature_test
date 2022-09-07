import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/board_controller.dart';
import 'package:ordermanagement/src/merchant/model/card_model.dart';

class AddEditCardView extends StatelessWidget {
  final int? columnId;
  final CardModel? item;
  const AddEditCardView({Key? key, this.columnId, this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bool isUpdate = item != null;

    int? columnId = this.columnId;
    final _controller = BoardController.get;

    final _textController = TextEditingController();

    if(isUpdate) _textController.text = item!.comment;

    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      return AlertDialog(
        title: Text(
          '${isUpdate ? 'Update' : 'Create'} card'
        ),
        content: TextField(
          controller: _textController,
        ),
        actions: [

          Wrap(
            children: _controller.columns.map((column) => GestureDetector(
              onTap: (){
                setState((){
                  columnId = column.index;
                });
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                          column.name
                      ),
                      Checkbox(
                          value: columnId == column.index,
                          onChanged: (newValue){
                            setState((){
                              columnId = column.index;
                            });
                          }
                      )
                    ],
                  ),
                ),
              ),
            )).toList(),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                child: Text(
                  'Cancel'
                ),
                onPressed: Get.back,
              ),
              TextButton(
                child: Text(
                  isUpdate? 'Update' : 'Add'
                ),
                onPressed: (){

                  // CardModel? data;
                  //
                  // if(_textController.text.isNotEmpty){
                  //
                  //   final insertColumnIndex = columnId == null ? 0 : _controller.columns.indexWhere((column) => column.index == columnId);
                  //
                  //   if(isUpdate){
                  //
                  //     final colIndex = _controller.columns.indexWhere((column) => column.index == item!.column);
                  //     final itemIndex = _controller.columns[colIndex].items.indexWhere((item) => item.id == this.item!.id);
                  //
                  //     if(columnId != this.item!.column){
                  //       _controller.columns[colIndex].items.removeAt(itemIndex);
                  //       _controller.columns[insertColumnIndex].items.add(
                  //         this.item!
                  //           ..column = columnId!
                  //           ..comment = _textController.text
                  //       );
                  //     }else{
                  //       _controller.columns[insertColumnIndex].items[itemIndex]
                  //         ..comment = _textController.text;
                  //     }
                  //
                  //   }else{
                  //     _controller.columns[insertColumnIndex].items.add(CardModel(
                  //       id: _controller.itemID,
                  //       column: _controller.columns[insertColumnIndex].index,
                  //       comment: _textController.text
                  //     ));
                  //     _controller.itemID++;
                  //   }
                  //
                  //
                  //   _controller.columns.refresh();
                  //   Get.back(result: data);
                  // }
                },
              ),
            ],
          )
        ],
      );
    });
  }
}
