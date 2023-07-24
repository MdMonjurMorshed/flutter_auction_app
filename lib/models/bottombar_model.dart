import 'package:flutter/material.dart';

class BottomBar {
  Widget tab;
  String title;
  GlobalKey<NavigatorState>? navigatorKey;
  IconData icon;
  BottomBar(
      {required this.tab,
      required this.title,
      this.navigatorKey,
      required this.icon});
}
