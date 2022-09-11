import 'package:flutter/material.dart';
import 'package:vnotifyu/src/widgets/_widgets.dart';
import '../board_view.dart';

class HomeScreenMobile extends StatelessWidget {
  const HomeScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MobileAppbar(),
      drawer: AppDrawer(),
      body: IndexedStack(
        index: 0,
        children: [
          BoardView()
        ],
      ),
    );
  }
}
