import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/board_controller.dart';
import 'package:ordermanagement/src/merchant/model/column_model.dart';
import 'package:ordermanagement/src/merchant/screens/views/web/board/add_edit_column_view.dart';
import 'package:ordermanagement/src/merchant/screens/views/web/top_app_bar_web.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';

class BoardConfigurationWeb extends StatefulWidget {
  const BoardConfigurationWeb({Key? key}) : super(key: key);

  @override
  State<BoardConfigurationWeb> createState() => _BoardConfigurationWebState();
}

class _BoardConfigurationWebState extends State<BoardConfigurationWeb> {

  bool loading = false;
  final boardController = BoardController.get;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopAppBarWeb(
          actions: [
            TextButton(
              onPressed: () async{
                final res = await Get.dialog(AddEditColumnView());
                if(res != null && res){
                  setState(() {
                    loading = true;
                  });
                  await boardController.updateColumn();
                  setState(() {
                    loading = false;
                  });
                }
              },
              child: Text(
                'Add Column'
              )
            )
          ],
        ),

        Obx(()=>Expanded(
          child: OverlayLoader(
            loading: loading,
            shrink: true,
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
                Expanded(
                  child: DragAndDropLists(
                    listWidth: 350,
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
          ),
        ))
      ],
    );
  }
}

class _UpdateColumnHeader extends StatefulWidget {
  final ColumnModel column;
  final bool canUpdate;
  const _UpdateColumnHeader({Key? key, required this.column, required this.canUpdate}) : super(key: key);

  @override
  State<_UpdateColumnHeader> createState() => _UpdateColumnHeaderState();
}

class _UpdateColumnHeaderState extends State<_UpdateColumnHeader> {

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final _controller = BoardController.get;
    return OverlayLoader(
      loading: loading,
      shrink: true,
      child: DeviceHelper(
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
                    widget.column.name,
                    style: TextStyle(
                      fontSize: deviceType == DeviceType.MOBILE ? 20 : 24,
                      color: Colors.black,
                      fontWeight: FontWeight.w900
                    ),
                  ),
                  subtitle: Text(
                    '${_controller.cards.where((card) => card.column == widget.column.name).length} items available',
                    style: TextStyle(
                      fontSize: deviceType == DeviceType.MOBILE ? 12 : 14,
                      color: Colors.grey,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if(widget.canUpdate) GestureDetector(
                        onTap: () async{
                          if(!widget.canUpdate) return ;

                          final res = await Get.dialog(AddEditColumnView(column: widget.column));
                          if(res != null && res){
                            setState(() {
                              loading = true;
                            });
                            await _controller.updateColumn();
                            setState(() {
                              loading = false;
                            });
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: 12),
                          child: Icon(
                            Icons.edit,
                          ),
                        ),
                      ),

                      GestureDetector(
                        onTap: () async{
                          if(!widget.canUpdate) return ;
                          setState(() {
                            loading = true;
                          });
                          final index = _controller.columns.indexWhere((column) => column.name == widget.column.name);
                          _controller.columns[index].notify = !_controller.columns[index].notify;
                          await _controller.updateColumn();
                          setState(() {
                            loading = false;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: widget.column.notify ? Colors.green : Colors.transparent,
                            shape: BoxShape.circle
                          ),
                          margin: EdgeInsets.only(right: widget.canUpdate ? 32 : 12),
                          padding: EdgeInsets.all(6),
                          child: Icon(
                            Icons.notification_add_outlined,
                            color: widget.column.notify ? Colors.white : Colors.grey,
                          ),
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
      ),
    );
  }
}