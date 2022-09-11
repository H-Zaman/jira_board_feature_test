import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';
import 'package:ordermanagement/src/utilities/resources/_resources.dart';
import 'package:get/get.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';
import 'login_bottom_sheet.dart';

class SplashScreenMobile extends StatefulWidget {
  const SplashScreenMobile({Key? key}) : super(key: key);

  @override
  State<SplashScreenMobile> createState() => _SplashScreenMobileState();
}

class _SplashScreenMobileState extends State<SplashScreenMobile> {

  String selectedMenu = 'Home';

  final demoMenu = [
    'Home',
    'About',
    'Gallery',
  ];

  LiquidController _controller = LiquidController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          LiquidSwipe(
            liquidController: _controller,
            pages: [
              _HomePage(),
              Container(color: Colors.red),
              Container(color: Colors.yellow),
            ],
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: demoMenu.map((menu) => MenuButton(
                  menu: menu,
                  selected: selectedMenu == menu,
                  onPressed: (){
                    setState(() {
                      selectedMenu = menu;
                    });
                    _controller.animateToPage(
                      page: demoMenu.indexOf(menu),
                      duration: 500
                    );
                  }
              )).toList()
            ),
          ),

          Positioned(
            bottom: 20,
            left: 32,
            right: 32,
            child: TextButton.icon(
              onPressed: (){
                Get.bottomSheet(
                  LoginBottomSheet(),
                );
              },
              icon: Icon(
                Icons.person,
                color: Colors.black,
                size: 18,
              ),
              label: AutoSizeText(
                Translate.sign_in_workspace.tr,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14
                )
              )
            )
          )
        ],
      )
    );
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(Images.splashBg),
          fit: BoxFit.cover
        )
      ),
      width: double.infinity,
      padding: EdgeInsets.only(
        top: Get.height * .17,
        left: 20,
        right: 20
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          AutoSizeText(
            Translate.splash_header.tr.replaceAll('\n', ' '),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 1.5
            ),
          ),
          SizedBox(height: 14),
          AutoSizeText(
            Translate.splash_subtitle.tr,
          ),
        ],
      ),
    );
  }
}

