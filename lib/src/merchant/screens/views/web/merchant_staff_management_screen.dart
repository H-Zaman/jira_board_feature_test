import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnotifyu/src/merchant/controller/staff_controller.dart';
import 'package:vnotifyu/src/merchant/controller/user_controller.dart';
import 'package:vnotifyu/src/merchant/model/user.dart';
import 'package:vnotifyu/src/merchant/screens/add_edit_user_view.dart';
import 'package:vnotifyu/src/merchant/screens/views/web/top_app_bar_web.dart';
import 'package:vnotifyu/src/utilities/helper/localization/translation_keys.dart';
import 'package:vnotifyu/src/widgets/_widgets.dart';

class MerchantStaffManagementScreenWeb extends StatefulWidget {
  const MerchantStaffManagementScreenWeb({Key? key}) : super(key: key);

  @override
  State<MerchantStaffManagementScreenWeb> createState() => _MerchantStaffManagementScreenWebState();
}

class _MerchantStaffManagementScreenWebState extends State<MerchantStaffManagementScreenWeb> {

  final _userController = UserController.get;
  final _staffController = StaffController.get;

  final scaffoldKey = GlobalKey<ScaffoldState>(debugLabel: 'MerchantStaffManagementScreenWeb');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: _userController.loading || _staffController.loading ? Loader() : Column(
        children: [

          /// HEADER
          TopAppBarWeb(
            menu: [
              PopupMenuItem(
                value: 1,
                child: Text(
                  Translate.add_obj.trParams({
                    'obj' : Translate.staff.tr
                  })
                ),
              )
            ],
            onAction: (val){
              switch(val){
                case 1:
                  _staffController.selectedStaff = null;
                  if(scaffoldKey.currentState != null){
                    scaffoldKey.currentState!.openEndDrawer();
                  }
                  break;
                default:
                  break;
              }
            },
          ),

          Obx(()=>Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 32),
                  child: Text(
                    'Staff List',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),

                _staffController.staffList.isEmpty ? Center(
                  child: Text(
                      'No Staff Found'
                  ),
                ) : Expanded(
                  child: ListView.builder(
                    itemCount: _staffController.staffList.length,
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      final staff = _staffController.staffList[index];
                      return ListTile(
                        onTap: (){
                          _staffController.selectedStaff = staff;
                          scaffoldKey.currentState!.openEndDrawer();
                        },
                        leading: UserImage(
                          name: staff.name,
                          image: staff.imageId,
                        ),
                        trailing: Icon(
                          Icons.edit
                        ),
                        title: Row(
                          children: [
                            Text(
                              staff.name
                            ),
                            SizedBox(width: 12),

                            if(staff.userType == UserType.MERCHANT) Text(
                              staff.userType.name
                            )
                          ],
                        ),
                        subtitle: Text(
                          staff.email
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ))
        ],
      ),
      endDrawer: Obx(()=>AddEditUserView(
        onCancel: (){
          if(scaffoldKey.currentState != null) scaffoldKey.currentState!.closeEndDrawer();
        },
        user: _staffController.selectedStaff,
        onDone: _staffController.getData
      )),
      endDrawerEnableOpenDragGesture: false,
    );
  }
}