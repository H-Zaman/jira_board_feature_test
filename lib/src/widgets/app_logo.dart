import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:vnotifyu/src/utilities/resources/_resources.dart';

class AppLogo extends StatelessWidget {
  final double size;
  const AppLogo({Key? key, this.size = 100}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: Images.logo,
      height: size,
      width: size,
    );
  }
}
