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
      builder: (deviceType) => Stack(
        children: [
          TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(
              padding: deviceType == DeviceType.MOBILE ?
              EdgeInsets.fromLTRB(12,0,12,0)
                :
              EdgeInsets.fromLTRB(32,10,32,20),
            ),
            child: Text(
              menu,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: deviceType == DeviceType.MOBILE ? 16 : 20
              ),
            )
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            bottom: selected ? 0 : -10,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: deviceType == DeviceType.MOBILE ? 10 : 20),
              color: Colors.black,
              height: deviceType == DeviceType.MOBILE ? 2 : 4,
            ),
          )
        ],
      ),
    );
  }
}