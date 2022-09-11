import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vnotifyu/src/merchant/screens/home_screen.dart';
import 'package:vnotifyu/src/utilities/helper/localization/translation_keys.dart';
import 'package:vnotifyu/src/widgets/_widgets.dart';

class LoginBottomSheet extends StatelessWidget {
  const LoginBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool loading = false;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(22),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  Translate.log_in.tr,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Spacer(),
                AppLogo(size: 52)
              ],
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
                      Get.offAllNamed(HomeBoardScreen.route);
                    });

                  },
                  label: Translate.login.tr.toUpperCase(),
                );
              }),
            )

          ],
        ),
      ),
    );
  }
}
