import 'package:auction_bd24/controller/controllers/bottombar_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../models/bottombar_model.dart';

class PersistentBottomBar extends StatelessWidget {
  final List<BottomBar> items;
  PersistentBottomBar({super.key, required this.items});
  final bottombarController = Get.find<BottombarController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: () async {
            if (items[bottombarController.currentIndex.value]
                    .navigatorKey
                    ?.currentState
                    ?.canPop() ??
                false) {
              items[bottombarController.currentIndex.value]
                  .navigatorKey
                  ?.currentState
                  ?.pop();
              return false;
            } else {
              return true;
            }
          },
          child: Scaffold(
              body: IndexedStack(
                index: bottombarController.currentIndex.value,
                children: items
                    .map((page) => Navigator(
                          key: page.navigatorKey,
                          onGenerateInitialRoutes: (navigator, route) {
                            return [
                              GetPageRoute(
                                  page: () => page.tab,
                                  transition: Transition.fadeIn,
                                  transitionDuration:
                                      Duration(milliseconds: 500))
                            ];
                          },
                        ))
                    .toList(),
              ),
              bottomNavigationBar: NavigationBarTheme(
                data: NavigationBarThemeData(
                    indicatorColor: Colors.white,
                    backgroundColor: Colors.purple[400]),
                child: NavigationBar(
                    selectedIndex: bottombarController.currentIndex.value,
                    onDestinationSelected: (index) {
                      if (index == bottombarController.currentIndex.value) {
                        items[index]
                            .navigatorKey
                            ?.currentState
                            ?.popUntil((route) => route.isFirst);
                      } else {
                        bottombarController.currentIndex.value = index;
                      }
                    },
                    destinations: items
                        .map((e) => NavigationDestination(
                            icon: IconTheme(
                              data: IconThemeData(color: Colors.black),
                              child: Icon(e.icon),
                            ),
                            label: e.title))
                        .toList()),
              )),
        ));
  }
}
