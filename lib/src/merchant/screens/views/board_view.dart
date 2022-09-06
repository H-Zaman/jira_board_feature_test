import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:ordermanagement/src/merchant/controller/board_controller.dart';
import 'package:ordermanagement/src/merchant/model/card_model.dart';
import 'package:ordermanagement/src/merchant/model/column_model.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';

class BoardView extends StatefulWidget {
  final ScrollController? scrollController;
  const BoardView({Key? key, this.scrollController}) : super(key: key);

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> {

  final _scrollController = ScrollController();
  final _controller = BoardController.get;

  @override
  Widget build(BuildContext context) {
    return DeviceHelper(
      builder: (deviceType){
        return Container(
          padding: deviceType == DeviceType.MOBILE ? EdgeInsets.fromLTRB(14, 12, 0, 4) : EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 12
          ),
          child: Obx(()=>DragAndDropLists(
            listWidth: deviceType == DeviceType.MOBILE ? 270 : 300,
            itemDragOnLongPress: false,
            itemSizeAnimationDurationMilliseconds: 0,
            listDecoration: BoxDecoration(
              color: Color(0xffFFFAFA),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            listPadding: EdgeInsets.only(right: deviceType == DeviceType.MOBILE ? 14 : 24),
            axis: Axis.horizontal,
            scrollController: widget.scrollController ?? _scrollController,
            itemDragHandle: DragHandle(
              verticalAlignment: DragHandleVerticalAlignment.top,
              child: Padding(
                padding: EdgeInsets.only(right: 10, top: 20),
                child: Icon(
                  Icons.menu,
                  color: Colors.black26,
                ),
              ),
            ),
            children: _controller.columns.map((column) => DragAndDropList(
              header: _ColumnHeader(column : column),
              contentsWhenEmpty: _EmptyColumn(),
              children: column.items.map((item) => DragAndDropItem(child: _ColumnCard(item: item))).toList(),
              canDrag: false,
            )).toList(),
            onItemReorder: _controller.onItemReorder,
            onListReorder: _controller.onListReorder,
          )),
        );
      },
    );
  }
}

class _ColumnHeader extends StatelessWidget {
  final ColumnModel column;
  const _ColumnHeader({Key? key, required this.column}) : super(key: key);

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
                '${column.items.length} items available',
                style: TextStyle(
                  fontSize: deviceType == DeviceType.MOBILE ? 12 : 14,
                  color: Colors.grey,
                ),
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if(column.notify) Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.notification_add_outlined
                    ),
                  ),
                  Card(
                    margin: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(111)
                    ),
                    child: IconButton(
                      constraints: BoxConstraints(),
                      icon: Icon(Icons.more_horiz),
                      onPressed: () async{
                        _controller.addEditColumn(column);
                      },
                    ),
                  ),
                ],
              )
            ),

            if(column.isFirstColumn) Container(
              margin: EdgeInsets.symmetric(vertical: deviceType == DeviceType.MOBILE ? 8 : 14),
              height: deviceType == DeviceType.MOBILE ? 42 : 48,
              child: CButton(
                onPressed: (){
                  _controller.addCard(column);
                },
                label: 'add new',
                fontSize: deviceType == DeviceType.MOBILE ? 14 : 16,
                icon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.yellow.withOpacity(.4)
                  ),
                  child: Icon(
                    Icons.add,
                    size: 14,
                  ),
                )
              ),
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

class _EmptyColumn extends StatelessWidget {
  const _EmptyColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 24
      ),
      child: Text(
        'Nothing'
      ),
    );
  }
}

class _ColumnCard extends StatelessWidget {
  final CardModel item;
  const _ColumnCard({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = BoardController.get;

    final qrView = QrImage(
      data: "1234567890",
      version: QrVersions.auto,
      padding: EdgeInsets.zero,
      size: 200,
    );

    return GestureDetector(
      onTap: (){
        _controller.editCard(item);
      },
      child: DeviceHelper(
        builder: (deviceType)=>Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(2,2),
              )
            ]
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.fromLTRB(6, 6, 6, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      item.message,
                      style: TextStyle(
                        fontSize: deviceType == DeviceType.MOBILE ? 16 : 18,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.dialog(AlertDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: (){},
                              icon: Icon(
                                Icons.print
                              )
                            ),
                            IconButton(
                              onPressed: (){},
                              icon: Icon(
                                Icons.share
                              )
                            )
                          ],
                        ),
                        content: Container(
                          height: Get.height * .2,
                          width: deviceType == DeviceType.MOBILE ? Get.width * .7 : Get.width * .1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: qrView,
                              ),
                              SizedBox(height: 14),
                              Row(
                                children: [
                                  Text(
                                    'some links'
                                  ),
                                ],
                              )
                            ],
                          )
                        ),
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 24, left: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 32,
                      width: 32,
                      child: qrView
                    ),
                  )
                ],
              ),
              SizedBox(height: 8),
              Text(
                'Buzz Aldrin, 4h ago',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey
                ),
              ),
              SizedBox(height: 14),
              Text(
                'Some info about this, it can be small or big basically anything regarding this card',
              ),
            ],
          ),
        ),
      ),
    );
  }
}