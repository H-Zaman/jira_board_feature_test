import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:vnotifyu/src/customer/controllers/home_controller.dart';
import 'package:vnotifyu/src/utilities/helper/localization/translation_keys.dart';
import 'package:vnotifyu/src/widgets/_widgets.dart';

class HomeScreenCustomer extends StatefulWidget {
  static const String route = '/HomeScreenCustomer';

  final String merchantId;
  final String? orderId;

  const HomeScreenCustomer({
    Key? key,
    required this.merchantId,
    this.orderId
  }) : super(key: key);

  @override
  State<HomeScreenCustomer> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreenCustomer> {

  HomeController _controller = Get.put(HomeController());

  @override
  void initState() {
    _controller.merchantId(widget.merchantId);
    super.initState();
    if(widget.orderId != null){
      _controller.getOrder(widget.orderId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(()=>OverlayLoader(
      loading: _controller.loading,
      text: 'Fetching Order info...',
      child: Scaffold(
        body: Container(
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(Images.homeBG),
          //     fit: BoxFit.cover
          //   )
          // ),
          padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14
          ),
          child: SafeArea(
            child: _controller.enterNumberView.value ? _EnterNumberView() : _OrderStatusView()
          ),
        ),
      ),
    ));
  }
}

class _EnterNumberView extends StatelessWidget {
  const _EnterNumberView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    HomeController controller = Get.find();

    return Obx(()=>Column(
      children: [

        Text(
          Translate.home_header.tr,
          style: TextStyle(
            fontSize: 32,
            letterSpacing: 1.5
          ),
        ),
        SizedBox(height: 8),
        Text(
          Translate.home_subtitle.tr,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        SizedBox(height: 32),

        SwitchListTile(
          value: controller.allowNotification.value,
          onChanged: controller.onChangeNotificationPermission,
          activeColor: Colors.black,
          title: Text(
            Translate.allow_obj.trParams({
              'obj' : Translate.notification.tr
            })
          ),
          contentPadding: EdgeInsets.zero,
          subtitle: Text(
            Translate.allow_notification_subtitle.tr
          ),
        ),

        SizedBox(height: 22),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: TextField(
                controller: controller.orderIdController,
                onChanged: controller.orderId,
                decoration: InputDecoration(
                  hintText: Translate.enter_obj.trParams({
                    'obj' : Translate.order_number.tr
                  }),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(
                      color: Colors.grey
                    )
                  )
                ),
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle
              ),
              padding: EdgeInsets.symmetric(horizontal: 32),
              child: IconButton(
                onPressed: () => controller.getOrder(controller.orderIdController.text),
                icon: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                )
              ),
            )

          ],
        ),


        Spacer(),
        TextButton(
          onPressed: (){},
          child: Text(
            Translate.terms_conditions.tr,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black
            ),
          )
        )

      ],
    ));
  }
}

class _OrderStatusView extends StatelessWidget {
  const _OrderStatusView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeController controller = Get.find();

    return Obx(()=>Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Text(
          'You order\n${controller.order.order.id}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
          ),
        ),

        SizedBox(height: 40),

        Text(
          'Estimated delivery time',
          style: TextStyle(
            color: Colors.grey
          ),
        ),
        SizedBox(height: 6),
        Text(
          '12:30 pm - 12:45 pm',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),
        ),


        Padding(
          padding: const EdgeInsets.all(20),
          child: Lottie.network(
            'https://assets9.lottiefiles.com/packages/lf20_PygJmaEUwf.json',
            height: 150,
            width: double.infinity
          ),
        ),

        LoadingBars(),
        SizedBox(height: 20),
        Text(
          controller.order.order.comment
        ),
        Text(
          controller.order.order.column
        ),
        SizedBox(height: 10),
        SwitchListTile(
          value: controller.allowNotification.value,
          onChanged: controller.onChangeNotificationPermission,
          activeColor: Colors.black,
          title: Text(
            Translate.allow_obj.trParams({
              'obj' : Translate.notification.tr
            })
          ),
          contentPadding: EdgeInsets.zero,
          subtitle: Text(
            Translate.allow_notification_subtitle.tr
          ),
        ),
      ],
    ));
  }
}