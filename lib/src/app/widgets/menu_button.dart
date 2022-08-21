import 'package:flutter/material.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';

class MenuButton extends StatelessWidget {
  final String menu;
  final bool selected;
  final VoidCallback onPressed;
  const MenuButton({
    Key? key,
    required this.menu,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeviceHelper(
      mobileView: _MenuButtonMobile(
        menu: menu,
        onPressed: onPressed,
        selected: selected,
        key: key,
      ),
      tabView: _MenuButtonWeb(
        menu: menu,
        onPressed: onPressed,
        selected: selected,
        key: key,
      ),
      webView: _MenuButtonWeb(
        menu: menu,
        onPressed: onPressed,
        selected: selected,
        key: key,
      )
    );
  }
}

class _MenuButtonWeb extends StatelessWidget {
  final String menu;
  final bool selected;
  final VoidCallback onPressed;
  const _MenuButtonWeb({
    Key? key,
    required this.menu,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.fromLTRB(32,10,32,20),
          ),
          child: Text(
            menu,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20
            ),
          )
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom: selected ? 0 : -10,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black,
            height: 4,
          ),
        )
      ],
    );
  }
}

class _MenuButtonMobile extends StatelessWidget {
  final String menu;
  final bool selected;
  final VoidCallback onPressed;
  const _MenuButtonMobile({
    Key? key,
    required this.menu,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.fromLTRB(12,0,12,0),
          ),
          child: Text(
            menu,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16
            ),
          )
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom: selected ? 0 : -10,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8),
            color: Colors.black,
            height: 2,
          ),
        )
      ],
    );
  }
}

