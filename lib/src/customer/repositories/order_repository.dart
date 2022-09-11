import 'package:vnotifyu/src/customer/models/order.dart';
import 'package:vnotifyu/src/utilities/api/_api.dart';

class OrderRepo{
  Future<Order?> getOrderInfo(String merchantId, String orderId) async{
    final res = await Api.get(Endpoints.order(merchantId, orderId));

    if(res.error) return null;

    return Order.fromJson(res.data);
  }

  Future<void> addFcmToken(String merchantId, String orderId, String fcmToken) async{
    final data = {
      "merchant-id": merchantId,
      "queue-id": orderId,
      "token": fcmToken
    };

    await Api.put(Endpoints.cardFcm(merchantId,orderId), data: data);
  }
}