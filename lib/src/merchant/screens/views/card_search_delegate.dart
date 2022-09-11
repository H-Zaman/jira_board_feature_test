import 'package:flutter/material.dart';
import 'package:ordermanagement/src/merchant/controller/board_controller.dart';
import 'package:ordermanagement/src/merchant/model/card_model.dart';

class CardSearch extends SearchDelegate<CardModel?>{

  @override
  String get searchFieldLabel => 'Enter Id';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) =>  _SearchResultView(
    query: query,
    onSelect: close
  );

  @override
  Widget buildSuggestions(BuildContext context) => _SearchResultView(
    query: query,
    onSelect: close
  );
}

class _SearchResultView extends StatelessWidget {
  const _SearchResultView({
    Key? key,
    required this.query,
    required this.onSelect
  }) : super(key: key);

  final String query;
  final Function(BuildContext context, CardModel? result) onSelect;

  @override
  Widget build(BuildContext context) {
    final boardController = BoardController.get;
    return Builder(
      builder: (_){

        if(query == '') return SizedBox();

        final data = boardController.cards.where((card) => card.id.toLowerCase().contains(query.toLowerCase())).toList();

        if(data.isEmpty) return Center(
          child: Text(
            'No cards found'
          ),
        );

        return Container(
          color: Colors.white,
          child: ListView.builder(
            itemCount: data.length,
            shrinkWrap: true,
            itemBuilder: (_, index){
              final card = data[index];
              return ListTile(
                onTap: (){
                  onSelect.call(context, card);
                },
                title: Text(
                  card.id
                ),
                subtitle: Text(
                  card.comment
                ),
                leading: card.flag ? Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.red,
                ) : null
              );
            },
          ),
        );
      },
    );
  }
}