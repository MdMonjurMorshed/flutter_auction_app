import 'package:auction_bd24/models/bottombar_model.dart';
import 'package:auction_bd24/views/bottombar_view/auction_gellary.dart';
import 'package:auction_bd24/views/persistent_bottombar.dart';
import 'package:flutter/material.dart';

import 'bottombar_view/dashboard_page.dart';

class BottomBarPage extends StatelessWidget {
  BottomBarPage({super.key});
  final _dashBoardKey = GlobalKey<NavigatorState>();
  final _auctionGellaryKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return PersistentBottomBar(items: [
      BottomBar(
          tab: DashboardPage(),
          title: 'Dashboard',
          icon: Icons.dashboard,
          navigatorKey: _dashBoardKey),
      BottomBar(
          tab: LandingPage(),
          title: 'Auction Gellary',
          icon: Icons.gavel_outlined,
          navigatorKey: _auctionGellaryKey)
    ]);
  }
}
