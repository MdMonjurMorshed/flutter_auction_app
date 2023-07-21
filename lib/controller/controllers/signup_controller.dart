import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final emailControlelr = TextEditingController();
  final pass1Controller = TextEditingController();
  final pass2Controller = TextEditingController();
  final RxBool _emailValidate = false.obs;
  bool getEmailValidate() => _emailValidate.value;
  setEmailValidate(value) {
    _emailValidate.value = value;
  }

  RxBool validEmail = false.obs;
  RxBool pass1Valivate = false.obs;

  RxBool passLen = false.obs;
  RxBool pass2Validate = false.obs;
}
