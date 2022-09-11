import 'package:flutter/material.dart';

class DeviceHelperWidget extends StatelessWidget {
  final Widget tabView;
  final Widget mobileView;
  final Widget webView;
  const DeviceHelperWidget({
    Key? key,
    required this.mobileView,
    required this.tabView,
    required this.webView
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final value = MediaQuery.of(context).size.shortestSide;
    return Builder(
      builder: (context){
        if(value > 600 && value < 992){
          return tabView;
        }else if(value > 992){
          return webView;
        }else{
          return mobileView;
        }
      }
    );
  }
}

class DeviceHelper extends StatelessWidget {
  final Widget Function(DeviceType deviceType) builder;
  const DeviceHelper({Key? key, required this.builder}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final value = MediaQuery.of(context).size.shortestSide;
    return Builder(
      builder: (context){
        DeviceType deviceType;
        if(value > 600 && value < 992){
          deviceType = DeviceType.TAB;
        }else if(value > 992){
          deviceType = DeviceType.DESKTOP;
        }else{
          deviceType = DeviceType.MOBILE;
        }
        return builder(deviceType);
      },
    );
  }
}

enum DeviceType{
  MOBILE,
  TAB,
  DESKTOP
}