import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/merchant/controller/auth_controller.dart';
import 'package:ordermanagement/src/merchant/screens/home_screen.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';
import 'package:ordermanagement/src/utilities/helper/text_validators.dart';
import 'package:ordermanagement/src/utilities/resources/_resources.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';

class LoginDialogWeb extends StatelessWidget {
  const LoginDialogWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final _authController = AuthController.get;

    final GlobalKey<FormState> key = GlobalKey();
    final userNameController = TextEditingController(text: 'smkma');
    final passwordController = TextEditingController(text: '123456');

    bool loading = false;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Container(
            height: 500,
            width: 700,
            child: Row(
              children: [
                Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6),
                        bottomLeft: Radius.circular(6),
                      ),
                      image: DecorationImage(
                        image: AssetImage(Images.loginDialogBg),
                        fit: BoxFit.cover
                      )
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 42
                    ),
                    child: Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Translate.log_in.tr,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          const SizedBox(height: 32),
                          CTextField(
                            controller: userNameController,
                            title: Translate.username.tr,
                            hint: Translate.enter_your_obj.trParams({
                              'obj' : Translate.username.tr
                            }),
                            borderColor: Colors.black,
                            validator: (string) => TextValidators.normal(string, Translate.validUserName.tr),
                          ),
                          const SizedBox(height: 24),
                          CTextField(
                            controller: passwordController,
                            title: Translate.password.tr,
                            hint: Translate.enter_your_obj.trParams({
                              'obj' : Translate.password.tr
                            }),
                            borderColor: Colors.black,
                            password: true,
                            validator: TextValidators.password,
                          ),
                          const SizedBox(height: 32),

                          SizedBox(
                            width: 180,
                            child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                              return CButton(
                                loading: loading,
                                onPressed: () async{

                                  if(!key.currentState!.validate()) return ;

                                  setState((){
                                    loading = true;
                                  });

                                  final errorMsg = await _authController.login(userNameController.text, passwordController.text);

                                  if(errorMsg != null){

                                  }else{
                                    Get.offAllNamed(HomeBoardScreen.route);
                                  }

                                  setState((){
                                    loading = false;
                                  });

                                },
                                label: Translate.login.tr.toUpperCase(),
                              );
                            }),
                          )

                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: CloseButton(),
          )
        ],
      ),
    );
  }
}
