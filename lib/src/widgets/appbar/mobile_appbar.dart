import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnotifyu/src/merchant/controller/board_controller.dart';
import 'package:vnotifyu/src/merchant/screens/views/web/board/add_edit_card_view.dart';
import 'package:vnotifyu/src/utilities/helper/localization/translation_keys.dart';

class MobileAppbar extends StatelessWidget implements PreferredSizeWidget{
  const MobileAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: Colors.black
      ),
      toolbarTextStyle: TextStyle(
        color: Colors.black
      ),
      titleTextStyle: TextStyle(
        color: Colors.black
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Some Board Name',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            Translate.created_on_date.trParams({
              'date' : 'Aug 12 1234'
            }),
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
      actions: [
        PopupMenuButton(
          child: Row(
            children: [
              Text(
                Translate.menu.tr,
                style: TextStyle(
                  fontSize: 12
                ),
              ),
              Icon(
                Icons.more_vert
              ),
              SizedBox(width: 12),
            ],
          ),
          onSelected: (val) async{
            if(val == 1){
              BoardController.get.addEditColumn();
            }else if(val == 2){
              await Get.dialog(AddEditCardView());
            }
          },
          itemBuilder: (_) => [
            PopupMenuItem(
              value: 1,
              child: Text(
                Translate.add_obj.trParams({
                  'obj' : Translate.column.tr
                }),
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: Text(
                Translate.add_obj.trParams({
                  'obj' : Translate.card.tr
                }),
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            )
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
