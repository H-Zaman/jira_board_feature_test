import 'package:flutter/material.dart';
import 'package:ordermanagement/src/merchant/screens/views/mobile/merchant_staff_management_screen.dart';
import 'package:ordermanagement/src/merchant/screens/views/web/merchant_staff_management_screen.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';

class MerchantStaffManagementScreen extends StatelessWidget {
  static const String route = 'MerchantStaffManagementScreen';
  const MerchantStaffManagementScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeviceHelperWidget(
      mobileView: MerchantStaffManagementScreenMobile(),
      tabView: MerchantStaffManagementScreenWeb(),
      webView: MerchantStaffManagementScreenWeb()
    );
  }
}
