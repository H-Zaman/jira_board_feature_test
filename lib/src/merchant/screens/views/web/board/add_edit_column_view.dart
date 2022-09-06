import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/board_controller.dart';
import 'package:ordermanagement/src/merchant/model/column_model.dart';

class AddEditColumnView extends StatelessWidget {
  final ColumnModel? column;
  const AddEditColumnView({Key? key, this.column}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = BoardController.get;

    bool isUpdate = this.column != null;

    bool firstColumn = false;
    bool lastColumn = false;
    TextEditingController _textController = TextEditingController();
    if(isUpdate){
      _textController.text = this.column!.name;
      firstColumn = this.column!.isFirstColumn;
      lastColumn = this.column!.isLastColumn;
    }

    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) => AlertDialog(
      title: Text(
        '${isUpdate ? 'Update' : 'Enter'} Column Name'
      ),
      content: TextField(
        controller: _textController,
      ),
      actions: [

        CheckboxListTile(
            value: firstColumn,
            title: Text(
                'is first column'
            ),
            onChanged: (newValue){
              if(lastColumn){
                setState((){
                  lastColumn = false;
                });
              }
              setState((){
                firstColumn = newValue!;
              });
            }
        ),
        CheckboxListTile(
            value: lastColumn,
            title: Text(
                'is last column'
            ),
            onChanged: (newValue){
              if(firstColumn){
                setState((){
                  firstColumn = false;
                });
              }
              setState((){
                lastColumn = newValue!;
              });
            }
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
                  'Add'
              ),
              onPressed: (){
                if(_textController.text.isNotEmpty){

                  if(isUpdate){

                    final _colIndex = _controller.columns.indexOf(this.column);

                    _controller.columns[_colIndex]
                      ..name = _textController.text
                      ..isFirstColumn = firstColumn
                      ..isLastColumn = lastColumn;

                  }else{
                    _controller.columns.insert(
                      firstColumn ? 0 : _controller.columns.length,
                      ColumnModel(
                        index: _controller.columns.length+1,
                        name: _textController.text,
                        isFirstColumn: firstColumn,
                        isLastColumn: lastColumn
                      )
                    );
                  }

                  _controller.columns.refresh();
                  Get.back();
                }
              },
            ),
          ],
        )
      ],
    ));
  }
}
