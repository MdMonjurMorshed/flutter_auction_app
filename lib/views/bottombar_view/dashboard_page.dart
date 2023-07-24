import 'package:auction_bd24/controller/controllers/bidPlaced_fetchController.dart';
import 'package:auction_bd24/controller/controllers/product_fetch_controller.dart';
import 'package:auction_bd24/models/bidproduct_model.dart';
import 'package:auction_bd24/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});
  final productFetchController = Get.find<ProductFetchController>();
  final bidPlacedFetchController = Get.find<BidPlacedFetchController>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    DateTime dateTime = DateTime.now();
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          List<BidProduct> bidProduct = productFetchController.productList
              .where((element) =>
                  dateTime.isBefore(DateTime.parse(element.bidDateTime)))
              .toList();
          List<BidProduct> completed = productFetchController.productList
              .where((element) =>
                  dateTime.isAfter(DateTime.parse(element.bidDateTime)))
              .toList();

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: SizedBox(
                  height: height / 4,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: height / 8,
                        width: width / 3.5,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppTheme.appColor.productTileShadowColor!,
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(0, 1))
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text('Running Bids'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text('${bidProduct.length}'),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height / 8,
                        width: width / 3.5,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppTheme.appColor.productTileShadowColor!,
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(0, 1))
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
                                child: Text('Completed Bids'),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text('${completed.length}'),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height / 8,
                        width: width / 3.5,
                        decoration: BoxDecoration(
                            border: Border.all(),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color:
                                      AppTheme.appColor.productTileShadowColor!,
                                  blurRadius: 1,
                                  spreadRadius: 1,
                                  offset: Offset(0, 1))
                            ],
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }),
      ),
    );
  }
}
