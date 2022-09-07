import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/board_controller.dart';
import 'package:ordermanagement/src/merchant/screens/views/board_view.dart';
import 'package:ordermanagement/src/merchant/screens/views/web/top_app_bar_web.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';

class BoardScreenWeb extends StatefulWidget {
  const BoardScreenWeb({Key? key}) : super(key: key);

  @override
  State<BoardScreenWeb> createState() => _BoardScreenWebState();
}

class _BoardScreenWebState extends State<BoardScreenWeb> {

  final _controller = BoardController.get;
  // final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Obx(()=>_controller.loading ? Loader(
      color: Colors.black,
    ) : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// HEADER
        TopAppBarWeb(
          actions: [
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
          onAction: (val){
            _controller.allCards();
            // if(val == 1){
            //   _controller.addEditColumn();
            // }else if(val == 2){
            //   _controller.addCard();
            // }
          },
        ),

        /// COLUMNS
        // Expanded(
        //   child: Scrollbar(
        //     controller: _scrollController,
        //     interactive: true,
        //     thickness: 14,
        //     thumbVisibility: true,
        //     trackVisibility: true,
        //     scrollbarOrientation: ScrollbarOrientation.bottom,
        //     child: BoardView(
        //       scrollController: _scrollController
        //     ),
        //   ),
        // )
        Expanded(
          child: BoardView(
            // scrollController: _scrollController
          ),
        )
      ],
    ));
  }
}