import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/app/screens/home_screen.dart';
import 'package:ordermanagement/src/app/widgets/_widgets.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';
import 'package:ordermanagement/src/utilities/resources/_resources.dart';

class LoginDialogWeb extends StatelessWidget {
  const LoginDialogWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                          title: Translate.email.tr,
                          hint: Translate.enter_your_obj.trParams({
                            'obj' : Translate.email.tr
                          }),
                          borderColor: Colors.black,
                        ),
                        const SizedBox(height: 24),
                        CTextField(
                          title: Translate.password.tr,
                          hint: Translate.enter_your_obj.trParams({
                            'obj' : Translate.password.tr
                          }),
                          borderColor: Colors.black,
                          password: true,
                        ),
                        const SizedBox(height: 32),

                        SizedBox(
                          width: 180,
                          child: StatefulBuilder(builder: (BuildContext context, void Function(void Function()) setState) {
                            return CButton(
                              loading: loading,
                              onPressed: (){

                                setState((){
                                  loading = true;
                                });

                                Future.delayed(Duration(seconds: 1),(){
                                  Get.offAll(() => HomeScreen());
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
