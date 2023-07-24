import 'package:get/get.dart';

class BottombarController extends GetxController {
  RxInt currentIndex = 0.obs;
  RxBool selectedIconColor = false.obs;

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
