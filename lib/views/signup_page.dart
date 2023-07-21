import 'package:auction_bd24/controller/controllers/login_controller.dart';
import 'package:auction_bd24/controller/controllers/signup_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../themes/app_theme.dart';

class SignupPage extends StatelessWidget {
  SignupPage({super.key});
  final signupController = Get.find<SignupController>();
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Obx(() =>
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // sized box for image
              SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width / 1.5,
                  child: Image.asset('assets/signup/create.png')),

              SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    child: Text(
                      'Create Account',
                      style: AppTheme.appText.signupHeader,
                    ),
                  )),

              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                    padding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
                    child: Text(
                        'Your account is just few clicks away! Please provide the information bellow to create account')),
              ),

              // Sizedbox for input box and a signup button
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: TextField(
                      onChanged: (value) {
                        signupController.setEmailValidate(false);
                        if (RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                          signupController.validEmail.value = false;
                        }
                      },
                      controller: signupController.emailControlelr,
                      decoration: InputDecoration(
                          errorText: signupController.getEmailValidate()
                              ? 'email is a required property'
                              : signupController.validEmail.value
                                  ? 'please enter the valid email'
                                  : null,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme
                                      .appColor.signupFocusBorderColor!)),
                          focusColor: AppTheme.appColor.signupFocusBorderColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.mail),
                          prefixIconColor:
                              AppTheme.appColor.signupPrefixIconColor,
                          hintText: 'e.g example@gmail.com'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: TextField(
                      onChanged: (value) {
                        signupController.pass1Valivate.value = false;
                        if (value.length >= 8) {
                          signupController.passLen.value = false;
                        }
                      },
                      controller: signupController.pass1Controller,
                      obscureText: true,
                      decoration: InputDecoration(
                          errorText: signupController.pass1Valivate.value
                              ? 'must fill the password'
                              : signupController.passLen.value
                                  ? 'password should be at least 8 character'
                                  : loginController.emailAlreadyUsed.value
                                      ? 'This email is already in used'
                                      : null,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme
                                      .appColor.signupFocusBorderColor!)),
                          focusColor: AppTheme.appColor.signupFocusBorderColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.key),
                          prefixIconColor:
                              AppTheme.appColor.signupPrefixIconColor,
                          hintText: ' enter password'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: TextField(
                      onChanged: (value) {
                        signupController.pass2Validate.value = false;
                      },
                      controller: signupController.pass2Controller,
                      obscureText: true,
                      decoration: InputDecoration(
                          errorText: signupController.pass2Validate.value
                              ? 'password did not matched'
                              : null,
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppTheme
                                      .appColor.signupFocusBorderColor!)),
                          focusColor: AppTheme.appColor.signupFocusBorderColor,
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black),
                              borderRadius: BorderRadius.circular(10)),
                          prefixIcon: Icon(Icons.key),
                          prefixIconColor:
                              AppTheme.appColor.signupPrefixIconColor,
                          hintText: 'retype password'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        if (signupController.emailControlelr.text.isEmpty) {
                          signupController.setEmailValidate(true);
                        }
                        if (!RegExp(r'\S+@\S+\.\S+')
                            .hasMatch(signupController.emailControlelr.text)) {
                          signupController.validEmail.value = true;
                        }
                        if (signupController.pass1Controller.text.isEmpty) {
                          signupController.pass1Valivate.value = true;
                        }
                        if (signupController.pass2Controller.text.isEmpty ||
                            signupController.pass1Controller.text !=
                                signupController.pass2Controller.text) {
                          signupController.pass2Validate.value = true;
                        }
                        if (signupController.pass1Controller.text.length < 8) {
                          signupController.passLen.value = true;
                        }
                        if (!signupController.getEmailValidate() &&
                            !signupController.pass1Valivate.value &&
                            !signupController.pass2Validate.value &&
                            !signupController.validEmail.value &&
                            !signupController.passLen.value) {
                          loginController.createNewUser(
                              signupController.emailControlelr.text,
                              signupController.pass1Controller.text);
                          signupController.emailControlelr.clear();
                          signupController.pass1Controller.clear();
                          signupController.pass2Controller.clear();
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height / 15,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: AppTheme.appColor.signupBtn,
                            borderRadius: BorderRadius.circular(5)),
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: AppTheme.appText.signupButtonText,
                          ),
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            ])),
      ),
    ));
  }
}
