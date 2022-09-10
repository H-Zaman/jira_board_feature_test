import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/board_controller.dart';
import 'package:ordermanagement/src/merchant/model/column_model.dart';
import 'package:ordermanagement/src/merchant/screens/views/web/top_app_bar_web.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';

class BoardConfigurationWeb extends StatefulWidget {
  const BoardConfigurationWeb({Key? key}) : super(key: key);

  @override
  State<BoardConfigurationWeb> createState() => _BoardConfigurationWebState();
}

class _BoardConfigurationWebState extends State<BoardConfigurationWeb> {
  @override
  Widget build(BuildContext context) {

    final boardController = BoardController.get;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopAppBarWeb(),

        Obx(()=>Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 32),
                child: Text(
                  'Board-Configuration',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),

              // Expanded(
              //   child: ReorderableList(
              //     primary: false,
              //     padding: EdgeInsets.only(
              //       top: 20,
              //       left: 32
              //     ),
              //     itemCount: boardController.columns.length,
              //     onReorder: (oldIndex, newIndex){
              //       setState(() {
              //         if (newIndex > boardController.columns.length) newIndex = boardController.columns.length;
              //         if (oldIndex < newIndex) newIndex -= 1;
              //         final column = boardController.columns.removeAt(oldIndex);
              //         boardController.columns.insert(newIndex, column);
              //       });
              //     },
              //     itemBuilder: (_, index){
              //       final column = boardController.columns[index];
              //       return ListTile(
              //         onTap: (){
              //           print(column.name);
              //         },
              //         key: ValueKey(column.name),
              //         title: Text(
              //           column.name
              //         ),
              //       );
              //     },
              //   ),
              // )
              Expanded(
                child: DragAndDropLists(
                  listWidth: 300,
                  itemDragOnLongPress: false,
                  itemSizeAnimationDurationMilliseconds: 0,
                  listDecoration: BoxDecoration(
                    color: Color(0xffFFFAFA),
                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  listPadding: EdgeInsets.only(
                    left: 32,
                    top: 20
                  ),
                  axis: Axis.horizontal,
                  listDragHandle: DragHandle(
                    verticalAlignment: DragHandleVerticalAlignment.top,
                    child: Padding(
                      padding: EdgeInsets.only(right: 12, top: 28),
                      child: Icon(
                        Icons.menu,
                        color: Colors.black26,
                      ),
                    ),
                  ),
                  children: boardController.columns.map((column) {
                    return DragAndDropList(
                      canDrag: column.cards.isEmpty,
                      header: _UpdateColumnHeader(
                        column : column,
                        canUpdate: column.cards.isEmpty
                      ),
                      contentsWhenEmpty: SizedBox(),
                      children: [],
                    );
                  }).toList(),
                  onItemReorder: (_,__,___,____){},
                  onListReorder: (oldIndex, newIndex){
                    final column = boardController.columns.removeAt(oldIndex);
                    boardController.columns.insert(newIndex, column);
                  },
                )
              )
            ],
          ),
        ))
      ],
    );
  }
}

class _UpdateColumnHeader extends StatelessWidget {
  final ColumnModel column;
  final bool canUpdate;
  const _UpdateColumnHeader({Key? key, required this.column, required this.canUpdate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = BoardController.get;
    return DeviceHelper(
      builder: (deviceType)=>Container(
        padding: EdgeInsets.symmetric(
          horizontal: deviceType == DeviceType.MOBILE ? 12 : 16,
          vertical: deviceType == DeviceType.MOBILE ? 4 : 8
        ),
        child: Column(
          children: [
            ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  column.name,
                  style: TextStyle(
                    fontSize: deviceType == DeviceType.MOBILE ? 20 : 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w900
                  ),
                ),
                subtitle: Text(
                  '${_controller.cards.where((card) => card.column == column.name).length} items available',
                  style: TextStyle(
                    fontSize: deviceType == DeviceType.MOBILE ? 12 : 14,
                    color: Colors.grey,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if(column.notify) Padding(
                      padding: EdgeInsets.only(right: canUpdate ? 32 : 12),
                      child: Icon(
                        Icons.notification_add_outlined
                      ),
                    ),
                  ],
                )
            ),

            Divider(
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}