import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/user_controller.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';

class TopAppBarWeb extends StatelessWidget {
  final List<PopupMenuEntry<int>> menu;
  final Function(int)? onAction;
  final List<Widget> actions;
  const TopAppBarWeb({
    Key? key,
    this.menu = const [],
    this.actions = const [],
    this.onAction
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final _userController = UserController.get;

    return Container(
      height: Get.height * .15,
      padding: EdgeInsets.all(32),
      child: Obx(()=>Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if(!_userController.loading) AutoSizeText(
            _userController.user.business!.name,
            style: TextStyle(
              fontSize: 42,
            ),
          ),
          SizedBox(width: 12),
          if(!_userController.loading) AutoSizeText(
            Translate.created_on_date.trParams({
              'date' : 'Aug 12 1234'
            }),
            style: TextStyle(
                fontSize: 16,
                height: 3
            ),
          ),
          Spacer(),
          ...actions,
          SizedBox(width: 20),
          if(menu.isNotEmpty && onAction != null)Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: PopupMenuButton(
              child: Row(
                children: [
                  Text(
                    Translate.menu.tr,
                  ),
                  Icon(
                      Icons.more_vert
                  )
                ],
              ),
              onSelected: onAction,
              itemBuilder: (_) => menu,
            ),
          )
        ],
      )),
    );
  }
}
