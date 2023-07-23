import 'package:auction_bd24/controller/controllers/bottombar_controller.dart';
import 'package:auction_bd24/controller/controllers/mypost_controller.dart';
import 'package:auction_bd24/controller/controllers/productForm_controller.dart';
import 'package:auction_bd24/controller/controllers/login_controller.dart';
import 'package:auction_bd24/controller/controllers/product_fetch_controller.dart';
import 'package:auction_bd24/controller/controllers/signup_controller.dart';
import 'package:get/get.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
    Get.put(SignupController());
    Get.put(BottombarController());
    Get.put(ProductFormController());
    Get.put(ProductFetchController());
    Get.put(MyPostController());
  }
}
