class Endpoints{


  Endpoints._();

  static const String baseUrl = 'http://dev.gcp.bookmyfood.se:8086/bnotified';

  static const String account = '/account';
  static const String login = '$account/login';

  static bool isAuthRequired (String endpoint) => [

  ].contains(endpoint);
}