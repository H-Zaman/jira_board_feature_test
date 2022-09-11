import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/board_controller.dart';
import 'package:ordermanagement/src/merchant/model/column_model.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';

class AddEditColumnView extends StatelessWidget {
  final ColumnModel? column;
  const AddEditColumnView({Key? key, this.column}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = BoardController.get;

    bool isUpdate = this.column != null;

    TextEditingController _textController = TextEditingController();
    if(isUpdate){
      _textController.text = this.column!.name;
    }

    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) => AlertDialog(
      title: Text(
        '${isUpdate ? Translate.update.tr : 'Enter'} Column Name'
      ),
      content: TextField(
        controller: _textController,
      ),
      actions: [
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
                isUpdate ? Translate.update.tr : Translate.add.tr
              ),
              onPressed: (){
                if(_textController.text.isNotEmpty){

                  if(isUpdate){

                    final _colIndex = _controller.columns.indexOf(this.column);

                    _controller.columns[_colIndex]
                      ..name = _textController.text
                    ;

                  }else{
                    _controller.columns.insert(
                      1,
                      ColumnModel(
                        index: 10000,
                        name: _textController.text,
                      )
                    );
                  }

                  _controller.columns.refresh();
                  Get.back(result: true);
                }
              },
            ),
          ],
        )
      ],
    ));
  }
}
