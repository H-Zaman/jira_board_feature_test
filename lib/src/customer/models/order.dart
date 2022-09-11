import 'package:ordermanagement/src/merchant/model/business.dart';
import 'package:ordermanagement/src/merchant/model/card_model.dart';

class Order{
  Business business;
  CardModel order;

  Order({
    required this.business,
    required this.order
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    business: Business.fromJson(json['merchant-info']),
    order: CardModel.fromJson(json['queue-info'])
  );
}