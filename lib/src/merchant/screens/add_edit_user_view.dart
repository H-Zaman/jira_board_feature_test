import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnotifyu/src/merchant/controller/user_controller.dart';
import 'package:vnotifyu/src/merchant/model/user.dart';
import 'package:vnotifyu/src/utilities/helper/localization/translation_keys.dart';
import 'package:vnotifyu/src/utilities/helper/text_validators.dart';
import 'package:vnotifyu/src/widgets/_widgets.dart';

class AddEditUserView extends StatefulWidget {
  final VoidCallback onCancel;
  final User? user;
  final VoidCallback? onDone;
  final bool isProfile;
  const AddEditUserView({Key? key,
    required this.onCancel,
    this.user,
    this.onDone,
    this.isProfile = false
  }) : super(key: key);

  @override
  State<AddEditUserView> createState() => _AddEditUserViewState();
}

class _AddEditUserViewState extends State<AddEditUserView> {

  final _userController = UserController.get;

  final GlobalKey<FormState> formKey = GlobalKey();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  Rxn<String> errorMsg = Rxn();
  bool isUpdate = false;
  Uint8List? imageData;

  bool editMode = false;

  @override
  void initState() {
    isUpdate = widget.user != null;
    if(!isUpdate){
      editMode = true;
    }
    super.initState();
    if(isUpdate && !_userController.updateLoading){
      nameController.text = widget.user!.name;
      emailController.text = widget.user!.email;
      phoneController.text = widget.user!.phoneNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx((){
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

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Translate.profile.tr,
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  IconButton(
                    onPressed: (){
                      setState(() {
                        editMode = true;
                      });
                    },
                    icon: Icon(
                      Icons.edit
                    ),
                  )
                ],
              ),
              SizedBox(height: 24),

              if(isUpdate) StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setState) => Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: UserImage(
                      image: widget.user!.imageId,
                      newImageData: imageData,
                      onPickNewImage: (Uint8List? newImage){
                        if(newImage == null) return ;
                        setState((){
                          imageData = newImage;
                        });
                      },
                      name: widget.user!.name,
                      radius: 52,
                      isUpdate: isUpdate,
                    ),
                  ),
                )
              ),

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
                enabled: editMode,
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
                enabled: editMode,
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
                enabled: editMode,
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
                    enabled: editMode,
                  ),
                  SizedBox(height: 14),
                  CTextField(
                    controller: passwordController,
                    hint: Translate.enter_obj.trParams({
                      'obj' : Translate.password.tr
                    }),
                    title: Translate.password.tr,
                    fillColor: Colors.grey.shade300,
                    password: true,
                    validator: TextValidators.password,
                    enabled: editMode,
                  ),
                  SizedBox(height: 14),
                ],
              ),

              if(_userController.isMerchant && isUpdate) Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: (){
                    widget.onCancel.call();
                    final newPasswordController = TextEditingController();
                    final confPasswordController = TextEditingController();
                    final passwordFormKey = GlobalKey<FormState>();
                    Get.dialog(AlertDialog(
                      title: Text(
                        'Change password',
                      ),
                      content: Form(
                        key: passwordFormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CTextField(
                              controller: newPasswordController,
                              hint: Translate.enter_obj.trParams({
                                'obj' : Translate.newPassword.tr
                              }),
                              title: Translate.newPassword.tr,
                              fillColor: Colors.grey.shade300,
                              password: true,
                              validator: TextValidators.password,
                            ),
                            SizedBox(height: 14),
                            CTextField(
                              controller: confPasswordController,
                              hint: Translate.enter_obj.trParams({
                                'obj' : 'Password again'
                              }),
                              title: 'Confirm password',
                              fillColor: Colors.grey.shade300,
                              password: true,
                              validator: (string) => TextValidators.confirmPassword(string, newPasswordController.text),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: 140,
                              child: CButton(
                                onPressed: Get.back,
                                label: Translate.cancel.tr,
                              ),
                            ),
                            SizedBox(width: 32),
                            SizedBox(
                              width: 140,
                              child: CButton(
                                loading: _userController.updateLoading,
                                onPressed: () async{
                                  if(!passwordFormKey.currentState!.validate()) return ;
                                  _userController.updatePassword(
                                    newPasswordController.text,
                                    widget.user!.userId
                                  );
                                  Get.back();
                                },
                                label: Translate.update.tr,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        )
                      ],
                    ));
                  },
                  child: Text(
                    Translate.newPassword.tr
                  ),
                ),
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
              if(editMode) Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 140,
                    child: CButton(
                      onPressed: widget.onCancel,
                      label: Translate.cancel.tr,
                    ),
                  ),
                  SizedBox(width: 32),
                  SizedBox(
                    width: 140,
                    child: CButton(
                      loading: _userController.updateLoading,
                      onPressed: () async{
                        if(!formKey.currentState!.validate()) return ;
                        errorMsg.value = null;
                        if(isUpdate){

                          if(imageData != null){
                            _userController.uploadImage(
                              imageData!,
                              widget.user!.userId,
                              widget.user!.userType
                            );
                          }

                          final res = await _userController.updateUser(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            uid: widget.user!.userId,
                            load: !widget.isProfile
                          );
                          if(res.error){
                            errorMsg(res.message);
                          }else{
                            if(widget.onDone != null) widget.onDone!.call();
                          }
                        }else{
                          final res = await _userController.addUser(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            username: userNameController.text,
                            password: passwordController.text
                          );
                          if(res.error){
                            errorMsg(res.message);
                          }else{
                            if(widget.onDone != null) widget.onDone!.call();
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