import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:ordermanagement/src/utilities/helper/device_helper.dart';

class DrawerListTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final int count;
  final bool selected;
  final VoidCallback? onPressed;
  const DrawerListTile({
    Key? key,
    required this.icon,
    required this.label,
    this.count = 0,
    this.selected = false,
    this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DeviceHelper(
      builder: (deviceType)=>Stack(
        children: [
          ListTile(
              onTap: (){
                FocusScope.of(context).unfocus();
                if(onPressed != null) onPressed!.call();
              },
              leading: SizedBox(
                width: 52,
                child: Row(
                  children: [
                    if(selected) Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 6,
                      ),
                    ),
                    Icon(
                      icon,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              title: AutoSizeText(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: deviceType == DeviceType.MOBILE ? 16 : 18
                ),
              )
          ),
          if( count > 0 ) Positioned(
            right: 12,
            top: 12,
            bottom: 12,
            child: Container(
              alignment: Alignment.centerRight,
              decoration: BoxDecoration(
                color: Colors.yellow.withOpacity(.2),
                borderRadius: BorderRadius.circular(8)
              ),
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                count.toString(),
                style: TextStyle(
                  fontSize: 12
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
