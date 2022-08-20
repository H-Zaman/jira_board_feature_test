import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/utilities/resources/_resources.dart';
import 'package:ordermanagement/src/app/widgets/_widgets.dart';

import 'login_dialog.dart';

class SplashScreenWeb extends StatefulWidget {
  const SplashScreenWeb({Key? key}) : super(key: key);

  @override
  State<SplashScreenWeb> createState() => _SplashScreenWebState();
}

class _SplashScreenWebState extends State<SplashScreenWeb> {

  String selectedMenu = 'Home';

  final demoMenu = [
    'Home',
    'About',
    'Gallery',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: WebAppBar(
        leading: AppLogo(),
        menu: demoMenu.map((menu) => _MenuButton(
          menu: menu,
          selected: selectedMenu == menu,
          onPressed: (){
            setState(() {
              selectedMenu = menu;
            });
          }
        )).toList(),
        actions: [

          TextButton.icon(
            onPressed: (){
              Get.dialog(LoginDialogWeb());
            },
            icon: Icon(
              Icons.person,
              color: Colors.black,
            ),
            label: Text(
              'Sign in to workspace',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18
              )
            )
          )

        ],
      ),
      body: Stack(
        children: [
          _Background(),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: Get.width * .25,
              vertical: Get.height * .25
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Beautiful Workspace in the heart\nof your city',
                  style: TextStyle(
                    letterSpacing: 4,
                    fontSize: 52,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Expanded(child: Text(
                      'Whether you need a desk, office, suite, or entire HQ, we create environments that increase productivity, innovation and collaboration.',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black
                      ),
                    )),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Background extends StatelessWidget {
  const _Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 35,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(Images.splashBg),
                fit: BoxFit.cover
              )
            ),
          )
        ),
        Expanded(
          flex: 65,
          child: Container(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String menu;
  final bool selected;
  final VoidCallback onPressed;
  const _MenuButton({
    Key? key,
    required this.menu,
    required this.selected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextButton(
          onPressed: onPressed,
          style: TextButton.styleFrom(
            padding: EdgeInsets.fromLTRB(32,10,32,20),
          ),
          child: Text(
            menu,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 20
            ),
          )
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          bottom: selected ? 0 : -10,
          left: 0,
          right: 0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            color: Colors.black,
            height: 4,
          ),
        )
      ],
    );
  }
}
