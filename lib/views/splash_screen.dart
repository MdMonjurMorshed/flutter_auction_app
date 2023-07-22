import 'package:auction_bd24/controller/controllers/login_controller.dart';
import 'package:auction_bd24/views/bottombar_view/auction_gellary.dart';
import 'package:auction_bd24/views/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuctionSplash extends StatelessWidget {
  AuctionSplash({super.key});
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      loginController.checkLoggedIn().then((value) {
        Navigator.pushReplacement(
            context,
            GetPageRoute(
              page: () => value ? LandingPage() : LoginPage(),
            ));
      });
    });

    //media query to get the resposnsive view
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Container(
          width: width / 2,
          height: height / 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  image: AssetImage('assets/splahScreen/auction_splash.png'),
                  fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
