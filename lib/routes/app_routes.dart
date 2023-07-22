import 'package:auction_bd24/views/bottombar_view/auction_gellary.dart';
import 'package:auction_bd24/views/signup_page.dart';
import 'package:get/get.dart';

import '../views/login_page.dart';

class AppRoute {
  static List<GetPage> getPage = [
    GetPage(
        name: '/login',
        page: () => LoginPage(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/landing',
        page: () => LandingPage(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500)),
    GetPage(
        name: '/signup',
        page: () => SignupPage(),
        transition: Transition.fadeIn,
        transitionDuration: Duration(milliseconds: 500))
  ];
}
