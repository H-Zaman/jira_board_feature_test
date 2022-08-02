import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {


  List<ColumnModel> columns = [
    ColumnModel(
      id: 1,
      columnName: 'column_1',
      items: [
        ItemModel(id: 1, columnId: 1, message: 'col_1_msg_1'),
        ItemModel(id: 2, columnId: 1, message: 'col_1_msg_2'),
        ItemModel(id: 3, columnId: 1, message: 'col_1_msg_3'),
      ]
    ),
    ColumnModel(
      id: 2,
      columnName: 'column_2',
      items: [
        ItemModel(id: 1, columnId: 2, message: 'col_2_msg_1'),
        ItemModel(id: 2, columnId: 2, message: 'col_2_msg_2'),
        ItemModel(id: 3, columnId: 2, message: 'col_2_msg_3'),
      ]
    ),
    ColumnModel(
      id: 3,
      columnName: 'column_3',
      items: [
        ItemModel(id: 1, columnId: 3, message: 'col_3_msg_1'),
        ItemModel(id: 2, columnId: 3, message: 'col_3_msg_2'),
        ItemModel(id: 3, columnId: 3, message: 'col_3_msg_3'),
      ]
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'some_restaurant_name',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
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
                      bool firstColumn = false;
                      bool lastColumn = false;
                      final _textController = TextEditingController();

                      await showDialog(
                        context: context,
                        builder: (_)=> StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                          return AlertDialog(
                            title: Text(
                                'Enter Column Name'
                            ),
                            content: TextField(
                              controller: _textController,
                            ),
                            actions: [

                              CheckboxListTile(
                                value: firstColumn,
                                title: Text(
                                  'is first column'
                                ),
                                onChanged: (newValue){
                                  if(lastColumn){
                                    setState((){
                                      lastColumn = false;
                                    });
                                  }
                                  setState((){
                                    firstColumn = newValue!;
                                  });
                                }
                              ),
                              CheckboxListTile(
                                value: lastColumn,
                                title: Text(
                                  'is last column'
                                ),
                                onChanged: (newValue){
                                  if(firstColumn){
                                    setState((){
                                      firstColumn = false;
                                    });
                                  }
                                  setState((){
                                    lastColumn = newValue!;
                                  });
                                }
                              ),

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
                                        'Add'
                                    ),
                                    onPressed: (){
                                      if(_textController.text.isNotEmpty){

                                        columns.insert(
                                          firstColumn ? 0 : columns.length,
                                          ColumnModel(
                                            id: columns.length+1,
                                            columnName: _textController.text,
                                            isFirstColumn: firstColumn,
                                            isLastColumn: lastColumn
                                          )
                                        );
                                        Navigator.of(context).pop();
                                      }
                                    },
                                  ),
                                ],
                              )
                            ],
                          );
                        },)
                      );
                    }else if(val == 2){
                      final _textController = TextEditingController();
                      int? columnId;

                      await showDialog(
                        context: context,
                        builder: (_)=> StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                            return AlertDialog(
                              title: Text(
                                'Enter card message'
                              ),
                              content: TextField(
                                controller: _textController,
                              ),
                              actions: [

                                Wrap(
                                  children: columns.map((column) => GestureDetector(
                                    onTap: (){
                                      setState((){
                                        columnId = column.id;
                                      });
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                                column.columnName
                                            ),
                                            Checkbox(
                                                value: columnId == column.id,
                                                onChanged: (newValue){
                                                  setState((){
                                                    columnId = column.id;
                                                  });
                                                }
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )).toList(),
                                ),

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
                                          'Add'
                                      ),
                                      onPressed: (){
                                        if(_textController.text.isNotEmpty){

                                          final insertColumnIndex = columnId == null ? 0 : columns.indexWhere((element) => element.id == columnId);

                                          columns[insertColumnIndex].items.add(ItemModel(
                                            id: columns[insertColumnIndex].items.length+1,
                                            columnId: columns[insertColumnIndex].id,
                                            message: _textController.text
                                          ));

                                          Navigator.of(context).pop();
                                        }
                                      },
                                    ),
                                  ],
                                )
                              ],
                            );
                          },)
                      );
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
            SizedBox(height: 20),

            Expanded(
              child: DragAndDropLists(
                listWidth: 250,
                // listDraggingWidth: 100,
                listDecoration: BoxDecoration(
                  color: Color(0xffF1F3F5),
                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                ),
                listPadding: EdgeInsets.only(right: 24),
                axis: Axis.horizontal,
                children: columns.map((column) => DragAndDropList(
                  header: Container(
                    padding: EdgeInsets.only(
                      left: 12,
                      top: 12,
                      bottom: 12
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          column.columnName,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        IconButton(onPressed: () async{
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

                                            final index = columns.indexOf(column);
                                            columns[index].columnName = _textController.text;

                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )
                          );
                          setState(() {});
                        }, icon: Icon(Icons.edit))
                      ],
                    ),
                  ),
                  contentsWhenEmpty: Text(
                    'Nothing'
                  ),
                  children: column.items.map((item) => DragAndDropItem(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(4)
                      ),
                      margin: EdgeInsets.all(6),
                      child: ListTile(
                        onTap: () async{
                          final _textController = TextEditingController(text: item.message);

                          await showDialog(
                              context: context,
                              builder: (_)=> AlertDialog(
                                title: Text(
                                    'Edit Message'
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

                                            final index = columns.indexOf(column);
                                            final itemIndex = columns[index].items.indexOf(item);
                                            columns[index].items[itemIndex].message = _textController.text;

                                            Navigator.of(context).pop();
                                          }
                                        },
                                      ),
                                    ],
                                  )
                                ],
                              )
                          );
                          setState(() {});
                        },
                        title: Text(
                          item.message
                        ),
                        subtitle: Text(
                          'original column -> ${item.columnId}'
                        ),
                      ),
                    )
                  )).toList()
                )).toList(),
                onItemReorder: _onItemReorder,
                onListReorder: _onListReorder,
              ),
            )
          ],
        ),
      ),
    );
  }

  _onItemReorder(int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      ItemModel movedItem = columns[oldListIndex].items.removeAt(oldItemIndex);
      movedItem.columnId = columns[newListIndex].id;
      // make newItemIndex  0 if always add to first
      columns[newListIndex].items.insert(newItemIndex, movedItem);
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = columns.removeAt(oldListIndex);
      columns.insert(newListIndex, movedList);
    });
  }
}


class ItemModel{
  int id;
  int columnId;
  String message;

  ItemModel({
    required this.id,
    required this.columnId,
    required this.message
  });
}

class ColumnModel{
  int id;
  String columnName;
  bool isFirstColumn;
  bool isLastColumn;
  List<ItemModel> items;

  ColumnModel({
    required this.id,
    required this.columnName,
    this.isFirstColumn = false,
    this.isLastColumn = false,
    this.items = const []
  });
}
