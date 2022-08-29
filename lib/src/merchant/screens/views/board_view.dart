import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:ordermanagement/src/merchant/controller/board_controller.dart';
import 'package:ordermanagement/src/merchant/model/card_model.dart';
import 'package:ordermanagement/src/merchant/model/column_model.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';


class BoardView extends StatefulWidget {
  const BoardView({Key? key}) : super(key: key);

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
            listDecoration: BoxDecoration(
              color: Color(0xffFFFAFA),
              borderRadius: BorderRadius.all(Radius.circular(7.0)),
            ),
            listPadding: EdgeInsets.only(right: deviceType == DeviceType.MOBILE ? 14 : 24),
            axis: Axis.horizontal,
            scrollController: _scrollController,
            children: _controller.columns.map((column) => DragAndDropList(
              header: _ColumnHeader(column : column),
              contentsWhenEmpty: _EmptyColumn(),
              children: column.items.map((item) => DragAndDropItem(child: _ColumnCard(item: item))).toList()
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
                column.columnName,
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
              trailing: Card(
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
                )
            ),

            Container(
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

    return GestureDetector(
      onTap: (){
        _controller.editCard(item);
      },
      child: DeviceHelper(
        builder: (deviceType)=>Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4)
          ),
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.message,
                style: TextStyle(
                  fontSize: deviceType == DeviceType.MOBILE ? 16 : 18,
                  fontWeight: FontWeight.w700
                ),
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