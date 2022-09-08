class Endpoints{


  Endpoints._();

  static const String baseUrl = 'http://dev.gcp.bookmyfood.se:8086/bnotified';

  static const String account = '/account';
  static const String login = '$account/login';
  static String user (String userid) => '$account/user/$userid';
  static const String users = '/merchant/user';

  static const String columns = '/merchant/state';
  static const String cards = '/merchant/queues';
  static const String card = '/merchant/queue';

  static const String adminMerchants = '/admin/merchants';
}