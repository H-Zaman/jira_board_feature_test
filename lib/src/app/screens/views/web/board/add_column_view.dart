import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/app/controller/_controllers.dart';
import 'package:ordermanagement/src/app/model/_model.dart';

class AddColumnView extends StatelessWidget {
  const AddColumnView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = BoardController.get;

    bool firstColumn = false;
    bool lastColumn = false;
    final _textController = TextEditingController();

    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) => AlertDialog(
      title: Text(
        'Enter Column Name'
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

                  _controller.columns.insert(
                      firstColumn ? 0 : _controller.columns.length,
                      ColumnModel(
                          id: _controller.columns.length+1,
                          columnName: _textController.text,
                          isFirstColumn: firstColumn,
                          isLastColumn: lastColumn
                      )
                  );
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
