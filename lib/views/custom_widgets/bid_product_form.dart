import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controllers/productForm_controller.dart';
import '../../themes/app_theme.dart';

class ProductForm extends StatelessWidget {
  ProductForm({super.key});
  final productFormController = Get.find<ProductFormController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return AlertDialog(
      content: SizedBox(
        height: height / 3,
        child: Center(
          child: SingleChildScrollView(
              child: Obx(
            () => Column(
              children: [
                // textfield for product name
                TextFormField(
                  // styling
                  cursorColor: AppTheme.appColor.cussorColor,
                  decoration: InputDecoration(
                      errorText: productFormController.productName.value
                          ? 'product name should not be '
                          : null,
                      label: Text(
                        'Product Name',
                        style: AppTheme.appText.labelText,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: AppTheme.appColor.focusBorderColor!)),
                      focusColor: AppTheme.appColor.focusBorderColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.shopping_bag),
                      prefixIconColor: AppTheme.appColor.signupPrefixIconColor,
                      contentPadding: EdgeInsets.symmetric(vertical: 5)),

                  //controlling

                  controller: productFormController.productNameController,
                  onChanged: (value) {
                    productFormController.productName.value = false;
                  },
                ),

                SizedBox(
                  height: height / 100,
                ),

                //textfield for product description

                TextFormField(
                  // styling
                  cursorColor: AppTheme.appColor.cussorColor,
                  decoration: InputDecoration(
                      errorText: productFormController.productDes.value
                          ? 'product description is a required field '
                          : null,
                      label: Text(
                        'Description',
                        style: AppTheme.appText.labelText,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: AppTheme.appColor.focusBorderColor!)),
                      focusColor: AppTheme.appColor.focusBorderColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.text_fields_sharp),
                      prefixIconColor: AppTheme.appColor.signupPrefixIconColor,
                      contentPadding: EdgeInsets.symmetric(vertical: 5)),

                  //controlling

                  controller: productFormController.descriptionController,
                  onChanged: (value) {
                    productFormController.productDes.value = false;
                  },
                ),

                SizedBox(
                  height: height / 100,
                ),

                // textfield for minimum bid price

                TextFormField(
                  // styling
                  cursorColor: AppTheme.appColor.cussorColor,
                  decoration: InputDecoration(
                      errorText: productFormController.bidMinPrice.value
                          ? 'bid price can not be empty'
                          : null,
                      label: Text(
                        'Starting Bid price',
                        style: AppTheme.appText.labelText,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: AppTheme.appColor.focusBorderColor!)),
                      focusColor: AppTheme.appColor.focusBorderColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.price_change_rounded),
                      prefixIconColor: AppTheme.appColor.signupPrefixIconColor,
                      contentPadding: EdgeInsets.symmetric(vertical: 5)),

                  //controlling

                  controller: productFormController.bidMinPriceController,
                  onChanged: (value) {
                    productFormController.bidMinPrice.value = false;
                  },
                ),

                SizedBox(
                  height: height / 100,
                ),

                // textfield for Image picker

                TextFormField(
                  // styling
                  cursorColor: AppTheme.appColor.cussorColor,
                  decoration: InputDecoration(
                      errorText: productFormController.imagePicker.value
                          ? 'need to choose an image '
                          : null,
                      label: Text(
                        'Image',
                        style: AppTheme.appText.labelText,
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: AppTheme.appColor.focusBorderColor!)),
                      focusColor: AppTheme.appColor.focusBorderColor,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(10)),
                      prefixIcon: Icon(Icons.camera_alt_outlined),
                      prefixIconColor: AppTheme.appColor.signupPrefixIconColor,
                      contentPadding: EdgeInsets.symmetric(vertical: 5)),

                  //controlling

                  controller: productFormController.imagePickerController,
                  onChanged: (value) {
                    productFormController.imagePicker.value = false;
                  },
                  onTap: () async {
                    await productFormController.pickProductImage(context);
                    // productFormController.imagePickerController.text =
                    //     productFormController.imageUrl.value;
                  },
                ),

                SizedBox(
                  height: height / 100,
                ),

                //textfield for date picker

                TextFormField(
                    // styling
                    cursorColor: AppTheme.appColor.cussorColor,
                    decoration: InputDecoration(
                        errorText: productFormController.datepick.value
                            ? 'date is a required property '
                            : null,
                        label: Text(
                          'Date And Time',
                          style: AppTheme.appText.labelText,
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: AppTheme.appColor.focusBorderColor!)),
                        focusColor: AppTheme.appColor.focusBorderColor,
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        prefixIcon: Icon(Icons.calendar_month),
                        prefixIconColor:
                            AppTheme.appColor.signupPrefixIconColor,
                        contentPadding: EdgeInsets.symmetric(vertical: 5)),

                    //controlling

                    controller: productFormController.dateController,
                    onChanged: (value) {
                      productFormController.datepick.value = false;
                    },
                    onTap: () async {
                      await productFormController.setDatePicker(context);
                    })
              ],
            ),
          )),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Get.back();
            productFormController.clearFunction();
          },
          child: Text(
            'Cancel',
            style: AppTheme.appText.cancelButton,
          ),
        ),
        TextButton(
          onPressed: () {
            productFormController.checkFunction();
          },
          child: Text(
            'Submit',
            style: AppTheme.appText.submiButton,
          ),
        ),
      ],
    );
  }
}
