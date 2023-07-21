import 'package:auction_bd24/controller/bindings/bindings.dart';
import 'package:auction_bd24/controller/controllers/login_controller.dart';
import 'package:auction_bd24/routes/app_routes.dart';
import 'package:auction_bd24/themes/app_theme.dart';
import 'package:auction_bd24/views/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark));

  Get.put<LoginController>(LoginController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Auction BD24',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appThemeData(),
      initialBinding: ControllerBindings(),
      getPages: AppRoute.getPage,
      home: AuctionSplash(),
    );
  }
}
