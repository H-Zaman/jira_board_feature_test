class Endpoints{


  Endpoints._();

  static const String baseUrl = 'http://dev.gcp.bookmyfood.se:8086/vnotifyu';

  static const String account = '/account';
  static const String login = '$account/login';
  static String user (String userid) => '$account/user/$userid';
  static const String images = '/account/images';
  static const String resetPassword = '/account/changePassword';

  static const String users = '/merchant/user';
  static const String columns = '/merchant/state';
  static const String cards = '/merchant/queues';
  static const String card = '/merchant/queue';
  static const String updateCardStatus = '/merchant/queue/status';
  static const String updatePassword = '/merchant/user/reset-password';

  static const String adminMerchants = '/admin/merchants';

  static String order(String merchantId, String orderId) => '/public/status/$merchantId/$orderId';
  static String cardFcm(String merchantId, String orderId) => '/public/token/$merchantId/$orderId';
}