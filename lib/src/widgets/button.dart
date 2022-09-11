import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:vnotifyu/src/utilities/helper/device_helper.dart';

import 'loaders.dart';

class CButton extends StatelessWidget {
  final bool loading;
  final VoidCallback? onPressed;
  final String label;
  final double? fontSize;
  final Widget? icon;
  final Color? color;
  const CButton({
    Key? key,
    this.loading = false,
    this.onPressed,
    this.label = 'CONTINUE',
    this.fontSize,
    this.icon,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeviceHelperWidget(
      mobileView: _WebButton(
        key: key,
        onPressed: onPressed,
        label: label,
        loading: loading,
        icon: icon,
        fontSize: fontSize,
        color: color
      ),
      tabView: _WebButton(
        key: key,
        onPressed: onPressed,
        label: label,
        loading: loading,
        fontSize: fontSize,
        icon: icon,
        color: color
      ),
      webView: _WebButton(
        key: key,
        onPressed: onPressed,
        label: label,
        loading: loading,
        icon: icon,
        fontSize: fontSize,
        color: color
      )
    );
  }
}

class _WebButton extends StatelessWidget {
  final bool loading;
  final VoidCallback? onPressed;
  final String label;
  final double? fontSize;
  final Widget? icon;
  final Color? color;
  const _WebButton({
    Key? key,
    this.loading = false,
    this.onPressed,
    this.label = 'CONTINUE',
    this.fontSize,
    this.icon,
    this.color
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: (){
          FocusScope.of(context).unfocus();
          if(!loading && onPressed != null) onPressed!.call();
        },
        style: ElevatedButton.styleFrom(
          primary: color ?? Colors.black,
          elevation: 1
        ),
        child: loading ? Loader() : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            if(icon !=null) Padding(
              padding: EdgeInsets.only(
                right: 6
              ),
              child: icon,
            ),

            AutoSizeText(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                letterSpacing: 2,
                color: Colors.white,
                fontSize: fontSize ?? 20
              ),
            ),
          ],
        )
      )
    );
  }
}
