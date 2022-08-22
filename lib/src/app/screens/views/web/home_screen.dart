import 'package:flutter/material.dart';
import 'package:ordermanagement/src/app/widgets/_widgets.dart';
import 'board/board_screen.dart';

class HomeScreenWeb extends StatefulWidget {
  const HomeScreenWeb({Key? key}) : super(key: key);

  @override
  State<HomeScreenWeb> createState() => _HomeScreenWebState();
}

class _HomeScreenWebState extends State<HomeScreenWeb> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          AppDrawer(),
          Expanded(
            flex: 85,
            child: IndexedStack(
              index: 0,
              children: [
                BoardScreenWeb()
              ],
            )
          )
        ],
      ),
    );
  }
}