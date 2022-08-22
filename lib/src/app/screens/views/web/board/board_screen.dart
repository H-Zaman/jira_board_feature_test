import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/app/controller/_controllers.dart';
import 'package:ordermanagement/src/app/screens/views/board_view.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';

class BoardScreenWeb extends StatefulWidget {
  const BoardScreenWeb({Key? key}) : super(key: key);

  @override
  State<BoardScreenWeb> createState() => _BoardScreenWebState();
}

class _BoardScreenWebState extends State<BoardScreenWeb> {

  final _controller = BoardController.get;
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// HEADER
        Container(
          height: Get.height * .15,
          padding: EdgeInsets.all(32),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AutoSizeText(
                'Some Board Name',
                style: TextStyle(
                  fontSize: 42,
                ),
              ),
              SizedBox(width: 12),
              AutoSizeText(
                Translate.created_on_date.trParams({
                  'date' : 'Aug 12 1234'
                }),
                style: TextStyle(
                  fontSize: 16,
                  height: 3
                ),
              ),
              Spacer(),
              PopupMenuButton(
                child: Row(
                  children: [
                    Text(
                      Translate.menu.tr,
                    ),
                    Icon(
                        Icons.more_vert
                    )
                  ],
                ),
                onSelected: (val) async{
                  if(val == 1){
                    _controller.addEditColumn();
                  }else if(val == 2){
                    _controller.addCard();
                  }
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      Translate.add_obj.trParams({
                        'obj' : Translate.column.tr
                      })
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                      Translate.add_obj.trParams({
                        'obj' : Translate.card.tr
                      })
                    ),
                  )
                ],
              )
            ],
          ),
        ),

        /// COLUMNS
        Expanded(
          child: Scrollbar(
            controller: _scrollController,
            interactive: true,
            thickness: 14,
            thumbVisibility: true,
            trackVisibility: true,
            scrollbarOrientation: ScrollbarOrientation.bottom,
            child: BoardView(),
          ),
        )
      ],
    );
  }
}