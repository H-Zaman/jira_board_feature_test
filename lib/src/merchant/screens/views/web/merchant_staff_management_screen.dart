import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/staff_controller.dart';
import 'package:ordermanagement/src/merchant/controller/user_controller.dart';
import 'package:ordermanagement/src/merchant/model/user.dart';
import 'package:ordermanagement/src/merchant/screens/views/web/top_app_bar_web.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';
import 'package:ordermanagement/src/utilities/helper/text_validators.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';

class MerchantStaffManagementScreenWeb extends StatefulWidget {
  const MerchantStaffManagementScreenWeb({Key? key}) : super(key: key);

  @override
  State<MerchantStaffManagementScreenWeb> createState() => _MerchantStaffManagementScreenWebState();
}

class _MerchantStaffManagementScreenWebState extends State<MerchantStaffManagementScreenWeb> {

  final _userController = UserController.get;
  final _staffController = StaffController.get;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: _userController.loading || _staffController.loading ? Loader() : Column(
        children: [

          /// HEADER
          TopAppBarWeb(
            actions: [
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
                  scaffoldKey.currentState!.openEndDrawer();
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
                        leading: Icon(
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
      endDrawer: _AddEditStaffView(
        onCancel: (){
          scaffoldKey.currentState!.closeEndDrawer();
        },
      ),
      endDrawerEnableOpenDragGesture: false,
    );
  }
}

class _AddEditStaffView extends StatelessWidget {
  final VoidCallback onCancel;
  const _AddEditStaffView({Key? key, required this.onCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _staffController = StaffController.get;
    final GlobalKey<FormState> formKey = GlobalKey();

    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final userNameController = TextEditingController();
    final passwordController = TextEditingController();
    Rxn<String> errorMsg = Rxn();

    return Obx((){
      final bool isUpdate = _staffController.selectedStaff != null;

      if(isUpdate){
        nameController.text = _staffController.selectedStaff!.name;
        emailController.text = _staffController.selectedStaff!.email;
        phoneController.text = _staffController.selectedStaff!.phoneNumber;
      }
      return Container(
        margin: EdgeInsets.only(top: Get.height * .15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          ),
          color: Colors.white
        ),
        width: Get.width * .3,
        height: Get.height,
        padding: EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Text(
                isUpdate ? Translate.update_obj.trParams({
                  'obj' : Translate.staff.tr
                }) : Translate.add_obj.trParams({
                  'obj' : Translate.staff.tr
                }),
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height: 24),

              CTextField(
                controller: nameController,
                hint: Translate.enter_obj.trParams({
                  'obj' : Translate.name.tr
                }),
                title: Translate.name.tr,
                fillColor: Colors.grey.shade300,
                validator: (string) => TextValidators.normal(string, Translate.validObj.trParams({
                  'obj' : Translate.name.tr
                })),
              ),
              SizedBox(height: 14),
              CTextField(
                controller: emailController,
                hint: Translate.enter_obj.trParams({
                  'obj' : Translate.email.tr
                }),
                title: Translate.email.tr,
                fillColor: Colors.grey.shade300,
                validator: TextValidators.email,
              ),
              SizedBox(height: 14),
              CTextField(
                controller: phoneController,
                hint: Translate.enter_obj.trParams({
                  'obj' : Translate.phone_number.tr
                }),
                title: Translate.phone_number.tr,
                fillColor: Colors.grey.shade300,
                validator: TextValidators.phone,
              ),
              SizedBox(height: 14),
              if(!isUpdate) Column(
                children: [
                  CTextField(
                    controller: userNameController,
                    hint: Translate.username.trParams({
                      'obj' : Translate.username.tr
                    }),
                    title: Translate.username.tr,
                    fillColor: Colors.grey.shade300,
                    validator: (string) => TextValidators.normal(string, Translate.validObj.trParams({
                      'obj' : Translate.username.tr
                    })),
                  ),
                  SizedBox(height: 14),
                  CTextField(
                    controller: passwordController,
                    hint: Translate.enter_obj.trParams({
                      'obj' : Translate.password.tr
                    }),
                    title: Translate.password.tr,
                    fillColor: Colors.grey.shade300,
                    validator: TextValidators.password,
                  ),
                  SizedBox(height: 14),
                ],
              ),
              SizedBox(height: 24),
              if(errorMsg.value != null) Center(
                child: Text(
                  errorMsg.value!,
                  style: TextStyle(
                    color: Colors.red
                  ),
                ),
              ),
              Spacer(),


              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 140,
                    child: CButton(
                      onPressed: onCancel,
                      label: Translate.cancel.tr,
                    ),
                  ),
                  SizedBox(width: 32),
                  SizedBox(
                    width: 140,
                    child: CButton(
                      loading: _staffController.addEditLoading,
                      onPressed: () async{
                        if(!formKey.currentState!.validate()) return ;
                        errorMsg.value = null;
                        if(isUpdate){
                          final res = await _staffController.updateStaff(
                            name: nameController.text /*== _staffController.selectedStaff!.name ? null : nameController.text*/,
                            email: emailController.text /*== _staffController.selectedStaff!.email ? null : emailController.text*/,
                            phone: phoneController.text /*== _staffController.selectedStaff!.phoneNumber ? null : phoneController.text*/,
                            uid: _staffController.selectedStaff!.userId
                          );
                          if(res.error){
                            errorMsg(res.message);
                          }
                        }else{
                          final res = await _staffController.addStaff(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            username: userNameController.text,
                            password: passwordController.text
                          );
                          if(res.error){
                            errorMsg(res.message);
                          }
                        }
                      },
                      label: isUpdate ? Translate.update.tr : Translate.add.tr,
                      color: Colors.green,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
