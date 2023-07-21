import 'package:auction_bd24/controller/controllers/login_controller.dart';
import 'package:auction_bd24/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            // sized box for image view
            SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width / 1.5,
                child: Image.asset('assets/login/login.png')),

            SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
                  child: Text(
                    'Login',
                    style: AppTheme.appText.loginHeader,
                  ),
                )),

            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                  padding: EdgeInsets.only(top: 5, left: 20, bottom: 5),
                  child: Text(
                      'Your account is just few clicks away! Please provide the information bellow to create account ')),
            ),

            // Sizedbox for input box and a sending button
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: TextField(
                    controller: loginController.loginEmailController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.appColor.focusBorderColor!)),
                        focusColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.mail),
                        prefixIconColor: AppTheme.appColor.prefixIconColor,
                        hintText: 'e.g example@gmail.com'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: TextField(
                    controller: loginController.loginPassController,
                    obscureText: true,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: AppTheme.appColor.focusBorderColor!)),
                        focusColor: Colors.black,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.key),
                        prefixIconColor: AppTheme.appColor.prefixIconColor,
                        hintText: ' enter password'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: GestureDetector(
                    onTap: () async {
                      SharedPreferences loginPref =
                          await SharedPreferences.getInstance();
                      loginController.logprf = loginPref.get('isLoggedIn');
                      loginController.loginWithEmail(
                          loginController.loginEmailController.text,
                          loginController.loginPassController.text);
                      loginController.loginEmailController.clear();
                      loginController.loginPassController.clear();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppTheme.appColor.signInBtn),
                      child: Center(
                        child: Text(
                          'Login',
                          style: AppTheme.appText.loginButtonText,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: SizedBox(
                    width: width,
                    height: height / 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have account? "),
                        SizedBox(
                          width: width / 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.toNamed('/signup');
                          },
                          child: Text(
                            'Sign-Up',
                            style: AppTheme.appText.signUPTextBtn,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: SizedBox(
                    width: width,
                    height: height / 25,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1,
                          width: width / 3,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        GestureDetector(
                          child: Text('Or', style: AppTheme.appText.orText),
                        ),
                        SizedBox(
                          width: width / 20,
                        ),
                        Container(
                          height: 1,
                          width: width / 3,
                          color: Colors.black,
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      loginController.googleSign();
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height / 15,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: AppTheme.appColor.signInBtn),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/login/g_logo.png',
                            height: 40,
                            width: 40,
                          ),
                          Center(
                            child: Text(
                              'Sign In With Google',
                              style: AppTheme.appText.googleSigninBurronText,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
