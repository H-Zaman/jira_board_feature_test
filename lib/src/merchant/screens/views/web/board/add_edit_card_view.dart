import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/board_controller.dart';
import 'package:ordermanagement/src/merchant/model/card_model.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';

class AddEditCardView extends StatelessWidget {
  final CardModel? card;
  const AddEditCardView({Key? key, this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final bool isUpdate = card != null;

    final _controller = BoardController.get;

    final _cardController = TextEditingController();
    final _commentController = TextEditingController();
    bool flag = false;

    if(isUpdate) {
      _cardController.text = card!.id;
      _commentController.text = card!.comment;
      flag = card!.flag;
    }

    return StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
      return AlertDialog(
        title: Text(
          '${isUpdate ? 'Update' : 'Create'} card'
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if(!isUpdate)CTextField(
              controller: _cardController,
              hint: 'Enter card id',
              title: 'Card Id',
            ),
            CTextField(
              controller: _commentController,
              hint: 'Enter comment',
              title: 'Comment',
            ),
            CheckboxListTile(
              value: flag,
              onChanged: (value){
                if(value == null) return ;
                setState((){
                  flag = value;
                });
              },
              title: Text(
                'Flag'
              ),
            )
          ],
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
                  isUpdate? 'Update' : 'Add'
                ),
                onPressed: () async{

                  if(_cardController.text.isNotEmpty){

                    if(isUpdate){

                      _controller.editCard(
                        cardId: _cardController.text,
                        flag: flag,
                        comment: _commentController.text,
                      );

                    }else{
                      _controller.addCard(
                        cardId: _cardController.text,
                        flag: flag,
                        comment: _commentController.text
                      );
                    }

                    Get.back();
                  }
                },
              ),
            ],
          )
        ],
      );
    });
  }
}
