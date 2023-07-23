import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductFormController extends GetxController {
  // text editing controllers
  final productNameController = TextEditingController();
  final descriptionController = TextEditingController();
  final bidMinPriceController = TextEditingController();
  final imagePickerController = TextEditingController();
  final dateController = TextEditingController();

// check bool value for error text
  RxBool productName = false.obs;
  RxBool productDes = false.obs;
  RxBool bidMinPrice = false.obs;
  RxBool imagePicker = false.obs;
  RxBool datepick = false.obs;

// variable for selected date from the date picker
  RxString selectedDatetime = ''.obs;
//variable for image url from the image picker
  final RxString imageUrl = ''.obs;

  // image picker instance
  final ImagePicker picker = ImagePicker();
  // firestorage instance
  Reference ref = FirebaseStorage.instance.ref();

  // firestore instance
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    ever(selectedDatetime, (value) {
      dateController.text = value;
      if (dateController.text.isNotEmpty) {
        datepick.value = false;
      }
    });

    ever(imageUrl, (newValue) {
      imagePickerController.text = newValue;
      if (imagePickerController.text.isNotEmpty) {
        imagePicker.value = false;
      }
    });
  }

  // code for Image picker

  Future<void> pickProductImage(BuildContext context) async {
    XFile? picked = await picker.pickImage(source: ImageSource.gallery);

    final uniqueNumber = DateTime.now().millisecondsSinceEpoch.toString();

    Reference imageDirectory = ref.child('productImage');
    Reference imageUploadTo = imageDirectory.child(uniqueNumber);
    try {
      await imageUploadTo.putFile(File(picked!.path));
      imageUrl.value = await imageUploadTo.getDownloadURL();

      print(imageUrl.value);
    } catch (e) {
      print(e);
    }
  }

  // code for date picker method

  Future<void> setDatePicker(BuildContext context) async {
    DateTime currentDate = DateTime.now();

    DateTime? datePicked = await showDatePicker(
        context: context,
        initialDate: currentDate,
        firstDate: DateTime(currentDate.year - 1),
        lastDate: DateTime(currentDate.year + 1));

    if (datePicked != null && datePicked != currentDate) {
      setTimePicker(context, datePicked);
    }
  }

  Future<void> setTimePicker(BuildContext context, DateTime picked) async {
    TimeOfDay currentTime = TimeOfDay.now();
    TimeOfDay? timePicked =
        await showTimePicker(context: context, initialTime: currentTime);
    if (timePicked != null) {
      DateTime dateTime = DateTime(picked.year, picked.month, picked.day,
          timePicked.hour, timePicked.minute);
      selectedDatetime.value = dateTime.toString();
    }
  }

  void checkFunction() {
    if (productNameController.text.isEmpty) {
      productName.value = true;
    }
    if (descriptionController.text.isEmpty) {
      productDes.value = true;
    }
    if (bidMinPriceController.text.isEmpty) {
      bidMinPrice.value = true;
    }
    if (imagePickerController.text.isEmpty) {
      imagePicker.value = true;
    } else {
      imagePicker.value = false;
    }
    if (dateController.value.text.isEmpty) {
      datepick.value = true;
    } else {
      datepick.value = false;
    }
    if (!productName.value &&
        !productDes.value &&
        !bidMinPrice.value &&
        !imagePicker.value &&
        !datepick.value) {
      saveFunction(
          productNameController.text,
          descriptionController.text,
          bidMinPriceController.text,
          imagePickerController.text,
          dateController.text);
      clearFunction();
      Get.back();
    }
  }

  void saveFunction(name, des, bidPrice, productImage, bidLastingDate) async {
    User? user = FirebaseAuth.instance.currentUser;
    Map<String, dynamic> data = {
      'userId': user!.uid,
      'productName': name,
      'productDescription': des,
      'productMinBidPrice': bidPrice,
      'productImage': productImage,
      'bidExpiryDate': bidLastingDate
    };

    try {
      final product = await fireStore.collection('bidProduct').add(data);
      if (product.id.isNotEmpty) {
        Get.snackbar('Success!', 'Product added successfully',
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.TOP);
    }
  }

  void clearFunction() {
    productNameController.clear();
    descriptionController.clear();
    bidMinPriceController.clear();
    imagePickerController.clear();
    dateController.clear();
  }
}
