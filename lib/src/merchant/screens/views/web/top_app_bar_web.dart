import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnotifyu/src/merchant/controller/user_controller.dart';
import 'package:vnotifyu/src/utilities/helper/localization/translation_keys.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

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

    final link = Uri.base.origin+'?HomeScreenCustomer=true'+'&mId=${_userController.user.business!.ownerId}';

    final qrView = QrImage(
      data: link,
      size: 200,
      version: QrVersions.auto,
      padding: EdgeInsets.zero,
    );

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
          GestureDetector(
            onTap: (){
              Get.dialog(AlertDialog(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.print
                      )
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: Icon(
                        Icons.share
                      )
                    )
                  ],
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 200,
                      height: 200,
                      child: qrView,
                    ),
                    SizedBox(height: 14),
                    SizedBox(
                      width: 200,
                      child: TextButton(
                        onPressed: (){
                          launchUrlString(link);
                        },
                        child: Text(
                          link,
                          style: TextStyle(
                            decoration: TextDecoration.underline
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ));
            },
            child: qrView
          ),
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
