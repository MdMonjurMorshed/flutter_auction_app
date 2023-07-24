import 'package:auction_bd24/controller/controllers/bidPlaced_fetchController.dart';
import 'package:auction_bd24/controller/controllers/login_controller.dart';
import 'package:auction_bd24/controller/controllers/product_fetch_controller.dart';
import 'package:auction_bd24/views/auction_page.dart';
import 'package:auction_bd24/views/myPost_page.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/controllers/mypost_controller.dart';
import '../../controller/controllers/productForm_controller.dart';
import '../../themes/app_theme.dart';
import '../custom_widgets/bid_product_form.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});
  final loginController = Get.find<LoginController>();
  final datetimeController = Get.find<ProductFormController>();
  final productFetchController = Get.find<ProductFetchController>();
  final mypostController = Get.find<MyPostController>();
  final bidPlacedController = Get.find<BidPlacedFetchController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Auction Gellary'),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: GestureDetector(
            onTap: () {
              loginController.googleSignout();
            },
            child: Icon(Icons.logout),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return ProductForm();
                    });
              },
              child: Icon(Icons.add),
            ),
          ),
        ],
      ),
      body: Obx(() {
        if (productFetchController.productList.isNotEmpty) {
          return ListView.builder(
              itemCount: productFetchController.productList.length,
              itemBuilder: (context, index) {
                final data = productFetchController.productList[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          GetPageRoute(
                              page: () => AuctionPage(
                                    id: data.productId,
                                    uId: data.userId,
                                    price: data.bidMinPrice,
                                    name: data.productName,
                                    description: data.productDescription,
                                    image: data.productImage,
                                    endDate: data.bidDateTime,
                                  )));
                    },
                    child: Container(
                      // Styling
                      height: MediaQuery.of(context).size.height / 5,
                      width: MediaQuery.of(context).size.width / 1.8,
                      decoration: BoxDecoration(
                        color: AppTheme.appColor.productTileColor,
                        boxShadow: [
                          BoxShadow(
                              color: AppTheme.appColor.productTileShadowColor!,
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(1, 1))
                        ],
                        border: Border.all(
                          color: AppTheme.appColor.productTileBorderColor!,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),

                      // widget is here in the child

                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              height: height / 5,
                              width: width / 2.5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  image: DecorationImage(
                                    image: NetworkImage(data.productImage),
                                  )),
                            ),
                          ),
                          SizedBox(
                            height: height / 5,
                            width: width / 2.2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Product Name: ${data.productName}"),
                                Text("Bid Price: ${data.bidMinPrice}"),
                                Text("End Date: ${data.bidDateTime}"),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        } else {
          return Center(
            child: Text('No data is available'),
          );
        }
      }),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            mypostController.fetchMyPost();
            Navigator.push(
                context,
                GetPageRoute(
                    page: () => MyPostPage(),
                    transition: Transition.fadeIn,
                    transitionDuration: Duration(milliseconds: 500)));
          },
          label: Text('My Post')),
    );
  }
}
