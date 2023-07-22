import 'package:auction_bd24/controller/controllers/bottombar_controller.dart';
import 'package:auction_bd24/controller/controllers/login_controller.dart';
import 'package:auction_bd24/controller/controllers/signup_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<LoginController>(LoginController());
    Get.put(SignupController());
    Get.put(BottombarController());
  }
}
