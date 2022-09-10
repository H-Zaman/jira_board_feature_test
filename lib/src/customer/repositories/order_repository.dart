import 'package:ordermanagement/src/customer/models/order.dart';
import 'package:ordermanagement/src/utilities/api/_api.dart';

class OrderRepo{
  Future<Order?> getOrderInfo(String merchantId, String orderId) async{
    final res = await Api.get(Endpoints.order(merchantId, orderId));

    if(res.error) return null;

    return Order.fromJson(res.data);
  }
}