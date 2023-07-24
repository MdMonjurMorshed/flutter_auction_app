import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuctionPageController extends GetxController {
  final bidTextController = TextEditingController();
  DateTime dateTime = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxBool bidProductBool = false.obs;
  RxBool editBid = false.obs;
  RxString idOfProduct = ''.obs;
  RxString idOfUser = ''.obs;

  void errorFunction() {
    Get.snackbar('Error', 'Opps! you can not set bid for your own product');
  }

  void timesUpFunction() {
    Get.snackbar('Error', 'Opps!times up! to set the ');
  }

  void placeBidFunction(price, productid) {
    try {
      final productPrice = double.parse(price);
      final user = FirebaseAuth.instance.currentUser!;
      final Map<String, dynamic> data = {
        'productId': productid,
        'bidPrice': productPrice,
        'userId': user.uid,
        'userEmail': user.email,
        'userName': user.displayName ?? '',
      };
      firestore.collection('bidPlaced').doc(user.uid).set(data);
      editBid.value = true;
      idOfProduct.value = productid;

      bidTextController.clear();
    } catch (e) {
      if (e is FormatException) {
        bidProductBool.value = true;
      }
    }
  }

  void editBidFunction(price) {
    try {
      final productPrice = double.parse(price);
      final user = FirebaseAuth.instance.currentUser!;
      firestore
          .collection('bidPlaced')
          .doc(user.uid)
          .update({"bidPrice": productPrice});
      bidTextController.clear();
    } catch (e) {
      if (e is FormatException) {
        bidProductBool.value = true;
      }
    }
  }
}
