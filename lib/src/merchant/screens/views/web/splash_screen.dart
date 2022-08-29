import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:ordermanagement/src/customer/screens/home_screen.dart';
import 'package:ordermanagement/src/utilities/helper/localization/translation_keys.dart';
import 'package:ordermanagement/src/utilities/resources/_resources.dart';
import 'package:ordermanagement/src/widgets/_widgets.dart';
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

  LiquidController _controller = LiquidController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: WebAppBar(
        leading: GestureDetector(
          onTap: (){
            Get.offAllNamed(HomeScreenCustomer.route);
          },
            child: AppLogo()),
        menu: demoMenu.map((menu) => MenuButton(
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
            label: AutoSizeText(
              Translate.sign_in_workspace.tr,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18
              )
            )
          )

        ],
      ),
      body: LiquidSwipe(
        liquidController: _controller,
        initialPage: 0,
        pages: [
          _HomeView(),
          _AboutView(),
          Container(
            color: Colors.purple,
          )
        ],
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  const _HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            Expanded(
              flex: 35,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Images.splashBg),
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
        ),
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
                Translate.splash_header.tr,
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
                    Translate.splash_subtitle.tr,
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
        ),
      ],
    );
  }
}

class _AboutView extends StatelessWidget {
  const _AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(Get.width * .07, Get.height * .12, Get.width * .07, Get.height * .025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Padding(
            padding: EdgeInsets.only(
              left: Get.width * .08,
              bottom: 24
            ),
            child: AutoSizeText(
              'Dedicated Teams.\nFor Your Dedicated Dreams.',
              style: TextStyle(
                letterSpacing: 4,
                fontSize: 52,
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          Expanded(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 78,
                      child: Container(
                        margin: EdgeInsets.zero,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          image: DecorationImage(
                            image: AssetImage(Images.aboutBg),
                            fit: BoxFit.cover
                          )
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 22,
                      child: Row(
                        children: [
                          Expanded(child: SizedBox()),
                          Expanded(
                            child: AutoSizeText(
                              'Helping You\nGrow In Every Stage',
                              style: TextStyle(
                                letterSpacing: 2,
                                fontSize: 42,
                                color: Colors.black,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Positioned(
                  bottom: Get.height * .015,
                  left: Get.width * .05,
                  child: Container(
                    height: Get.height * .25,
                    width: Get.width * .25,
                    decoration: BoxDecoration(
                      color: Color(0xffFBE7E0),
                      borderRadius: BorderRadius.circular(2)
                    ),
                    padding: EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          'Why We Do This',
                          style: TextStyle(
                            letterSpacing: 2,
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        AutoSizeText(
                          'Our founders also feel the burden of creating their very fast business, As their frustration manifest this product, signed is born to help fellow entrepreneurs to be focused on one aspect, do business.',
                          style: TextStyle(
                            letterSpacing: 1.1,
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),

                        SizedBox(
                          height: 52,
                          child: CButton(
                            label: 'Read Our Blog',
                            fontSize: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )


        ],
      ),
    );
  }
}