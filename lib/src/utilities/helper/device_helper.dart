import 'package:flutter/material.dart';

class DeviceHelper extends StatelessWidget {
  final Widget tabView;
  final Widget mobileView;
  final Widget webView;
  const DeviceHelper({
    Key? key,
    required this.mobileView,
    required this.tabView,
    required this.webView
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints){
        if(constraints.maxWidth > 600 && constraints.maxWidth < 992){
          return tabView;
        }else if(constraints.maxWidth > 992){
          return webView;
        }else{
          return mobileView;
        }
      }
    );
  }
}