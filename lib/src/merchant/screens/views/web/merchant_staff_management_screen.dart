import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/staff_controller.dart';
import 'package:ordermanagement/src/merchant/controller/user_controller.dart';
import 'package:ordermanagement/src/merchant/screens/views/web/top_app_bar_web.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';

class MerchantStaffManagementScreenWeb extends StatefulWidget {
  const MerchantStaffManagementScreenWeb({Key? key}) : super(key: key);

  @override
  State<MerchantStaffManagementScreenWeb> createState() => _MerchantStaffManagementScreenWebState();
}

class _MerchantStaffManagementScreenWebState extends State<MerchantStaffManagementScreenWeb> {

  final _userController = UserController.get;
  final _staffController = StaffController.get;

  @override
  Widget build(BuildContext context) {
    return _userController.loading || _staffController.loading ? Loader() : Column(
      children: [

        /// HEADER
        TopAppBarWeb(
          actions: [],
          onAction: (val){},
        ),

        Obx(()=>Expanded(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      'Staff List',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500
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
                          final staff = _staffController.staffList[0];
                          return ListTile(
                            title: Text(
                              staff.name
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),

              /// selected staff details
              Expanded(
                child: Container(
                  color: Colors.red,
                ),
              )
            ],
          ),
        ))
      ],
    );
  }
}