class Images{
  Images._();

  static const _basePath = 'assets/images';

  static const splashBg = '$_basePath/splashBg.png';
  static const aboutBg = '$_basePath/aboutUsBg.png';
  static const logo = 'https://images.unsplash.com/photo-1602934445884-da0fa1c9d3b3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=958&q=80';
  static const loginDialogBg = '$_basePath/loginDialogBg.png';

  static String getImage(int imageLink) => 'http://dev.gcp.bookmyfood.se:8086/vnotifyu/account/get-image/$imageLink';
}