import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/app/controller/_controllers.dart';
import 'package:ordermanagement/src/app/model/_model.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:ordermanagement/src/app/widgets/_widgets.dart';

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
    return Obx(()=>Column(
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
                'Created on Aug 14 2030',
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
                      'Menu'
                    ),
                    Icon(
                      Icons.more_vert
                    )
                  ],
                ),
                onSelected: (val) async{
                  if(val == 1){
                    _controller.addColumn();
                  }else if(val == 2){
                    _controller.addCard();
                  }

                  setState(() {});
                },
                itemBuilder: (_) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text(
                      'Add Column'
                    ),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text(
                      'Add Card'
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
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 12
              ),
              child: DragAndDropLists(
                listWidth: 300,
                listDecoration: BoxDecoration(
                  color: Color(0xffFFFAFA),
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                listPadding: EdgeInsets.only(right: 24),
                axis: Axis.horizontal,
                scrollController: _scrollController,
                children: _controller.columns.map((column) => DragAndDropList(
                  header: _ColumnHeader(column : column),
                  contentsWhenEmpty: _EmptyColumn(),
                  children: column.items.map((item) => DragAndDropItem(child: _ColumnCard(item: item))).toList()
                )).toList(),
                onItemReorder: _controller.onItemReorder,
                onListReorder: _controller.onListReorder,
              ),
            ),
          ),
        )
      ],
    ));
  }
}

class _ColumnHeader extends StatelessWidget {
  final ColumnModel column;
  const _ColumnHeader({Key? key, required this.column}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = BoardController.get;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              column.columnName,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
                fontWeight: FontWeight.w900
              ),
            ),
            subtitle: Text(
              '${column.items.length} items available',
              style: TextStyle(
                fontSize: 14,
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
                  final _textController = TextEditingController(text: column.columnName);

                  await showDialog(
                      context: context,
                      builder: (_)=> AlertDialog(
                        title: Text(
                            'Edit Column Name'
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
                                onPressed: (){
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                    'Done'
                                ),
                                onPressed: (){
                                  if(_textController.text.isNotEmpty){

                                    // final index = columns.indexOf(column);
                                    // columns[index].columnName = _textController.text;

                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      )
                  );
                  // setState(() {});
                },
              ),
            )
          ),

          Container(
            margin: EdgeInsets.symmetric(vertical: 14),
            height: 48,
            child: CButton(
              onPressed: (){
                _controller.addCard(column);
              },
              label: 'add new',
              fontSize: 16,
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
      child: Container(
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
                fontSize: 18,
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
    );
  }
}
