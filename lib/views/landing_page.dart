import 'package:auction_bd24/controller/controllers/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              loginController.googleSignout();
            },
            child: Text('logout')),
      ),
    );
  }
}
