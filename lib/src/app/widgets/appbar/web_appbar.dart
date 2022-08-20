import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WebAppBar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? leading;
  final List<Widget>? menu;
  final List<Widget>? actions;
  const WebAppBar({
    Key? key,
    this.leading,
    this.menu,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * .1,
      padding: EdgeInsets.fromLTRB(42, 32, 42, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [

          if(leading != null) leading!,

          if(menu != null) Row(
            children: menu!
          ),

          if(actions != null) Row(
            children: actions!
          )

        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size(
    double.infinity,
    Get.height * .1
  );
}
