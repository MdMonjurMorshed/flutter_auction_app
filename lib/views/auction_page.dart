import 'package:auction_bd24/controller/controllers/auctionPage_controller.dart';
import 'package:auction_bd24/controller/controllers/bidPlaced_fetchController.dart';
import 'package:auction_bd24/controller/controllers/user_controller.dart';
import 'package:auction_bd24/models/bidPlaced_model.dart';
import 'package:auction_bd24/themes/app_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuctionPage extends StatelessWidget {
  final String id;
  final String uId;
  final double price;
  final String name;
  final String description;
  final String image;
  final String endDate;
  AuctionPage(
      {super.key,
      required this.id,
      required this.uId,
      required this.price,
      required this.name,
      required this.description,
      required this.image,
      required this.endDate});
  final auctionPageController = Get.find<AuctionPageController>();
  final bidPlacedController = Get.find<BidPlacedFetchController>();
  final userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final user = FirebaseAuth.instance.currentUser!;
    DateTime nowDatetime = DateTime.now();
    auctionPageController.idOfUser.value = user.uid;
    List<BidPlaced> newList = bidPlacedController.bidPlacedList
        .where((doc) => doc.productId == id)
        .toList();

// Find the maximum bid price from the newList
    if (newList.isNotEmpty) {
      double maxBidPrice = newList
          .map((bid) => bid.bidPrice) // Extract the bid prices from the list
          .reduce((value, element) => value > element ? value : element);

      print('Maximum bid price: $maxBidPrice');
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Auction Page'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Winner details
            Padding(
                padding: EdgeInsets.all(0),
                child: Obx(() {
                  List<BidPlaced> anotherList = bidPlacedController
                      .bidPlacedList
                      .where((doc) => doc.productId == id)
                      .toList();
                  if (anotherList.isNotEmpty) {
                    double maxBidPrice = anotherList
                        .map((bid) => bid.bidPrice)
                        .reduce((value, element) =>
                            value > element ? value : element);
                    BidPlaced maxBidHolder = anotherList.firstWhere(
                        (element) => element.bidPrice == maxBidPrice);
                    return nowDatetime.isAfter(DateTime.parse(endDate)) &&
                            anotherList.isNotEmpty
                        ? SizedBox(
                            height: height / 4,
                            width: width,
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width / 1.3,
                                    height: height / 8,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: AssetImage(
                                            'assets/win/winning.jpg',
                                          ),
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  Container(
                                    width: width,
                                    child: maxBidHolder.userName != ''
                                        ? Center(
                                            child: Text(
                                              'Congratulations! ${maxBidHolder.userName}',
                                              style: AppTheme
                                                  .appText.winingGreeting,
                                            ),
                                          )
                                        : Center(
                                            child: Text(
                                              'Congratulations! ${maxBidHolder.userEmail}',
                                              style: AppTheme
                                                  .appText.winingGreeting,
                                            ),
                                          ),
                                  ),
                                  Text(
                                    'You have won this bid at: $maxBidPrice',
                                    style: AppTheme.appText.winingDetails,
                                  )
                                ],
                              ),
                            ),
                          )
                        : Text('');
                  }

                  return Text('');
                })),

            // container for image and details
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                color: Colors.purple[100],
                height: height / 3,
                width: width,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height / 4,
                        width: width,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // image container
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Container(
                                width: width / 2.5,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(image))),
                              ),
                            ),

                            // Data container
                            SizedBox(
                              width: width / 1.67,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // product name
                                    SizedBox(
                                      height: height / 20,
                                      child: Row(
                                        children: [
                                          Text(
                                            'Product Name:',
                                            style: AppTheme
                                                .appText.productLabelText,
                                          ),
                                          Expanded(child: Text(name))
                                        ],
                                      ),
                                    ),
                                    // product description
                                    SizedBox(
                                      height: height / 10,
                                      child: Row(
                                        children: [
                                          Text('Description:',
                                              style: AppTheme
                                                  .appText.productLabelText),
                                          Expanded(child: Text(description))
                                        ],
                                      ),
                                    ),

                                    // product minimum bid price
                                    SizedBox(
                                      height: height / 20,
                                      child: Row(
                                        children: [
                                          Text('Min Bid price:',
                                              style: AppTheme
                                                  .appText.productLabelText),
                                          Expanded(child: Text('$price'))
                                        ],
                                      ),
                                    ),
                                    // product bidding end time
                                    SizedBox(
                                      height: height / 20,
                                      child: Row(
                                        children: [
                                          Text('End Time:',
                                              style: AppTheme
                                                  .appText.productLabelText),
                                          Expanded(child: Text(endDate))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // place for  bid price

                      SizedBox(
                          height: height / 15,
                          width: width,
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // container for Bid field
                                Container(
                                  height: height / 20,
                                  width: width / 2,
                                  decoration: BoxDecoration(),
                                  child: TextFormField(
                                    //Styling

                                    textAlign: TextAlign.center,
                                    cursorColor: AppTheme.appColor.cussorColor,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        errorText: auctionPageController
                                                .bidProductBool.value
                                            ? 'please the price in double format'
                                            : null,
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),

                                    // controlling
                                    controller:
                                        auctionPageController.bidTextController,
                                    onChanged: (value) {
                                      final price = double.parse(value);
                                      if (price is double) {
                                        auctionPageController
                                            .bidProductBool.value = false;
                                      }
                                    },
                                  ),
                                ),
                                SizedBox(
                                  width: width / 10,
                                ),

                                //container for button
                                SizedBox(
                                  height: height / 10,
                                  width: width / 5,
                                  child: userController
                                          .buttonCondition(user.uid)
                                      ? GestureDetector(
                                          onTap: user.uid == uId
                                              ? auctionPageController
                                                  .errorFunction
                                              : auctionPageController.dateTime
                                                      .isAfter(DateTime.parse(
                                                          endDate))
                                                  ? auctionPageController
                                                      .timesUpFunction
                                                  : () {
                                                      auctionPageController
                                                          .placeBidFunction(
                                                              auctionPageController
                                                                  .bidTextController
                                                                  .text,
                                                              id);
                                                      userController
                                                          .changeButton(
                                                              user.uid);
                                                    },
                                          child: Container(
                                            height: height / 25,
                                            width: width / 5,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: Text(
                                              'place Bid',
                                              style: AppTheme
                                                  .appText.bidButtonText,
                                            )),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: nowDatetime.isAfter(
                                                  DateTime.parse(endDate))
                                              ? auctionPageController
                                                  .timesUpFunction
                                              : () {
                                                  auctionPageController
                                                      .editBidFunction(
                                                          auctionPageController
                                                              .bidTextController
                                                              .text);
                                                },
                                          child: Container(
                                            height: height / 25,
                                            width: width / 5,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                                child: Text(
                                              'Edit Bid',
                                              style: AppTheme
                                                  .appText.bidButtonText,
                                            )),
                                          ),
                                        ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ),

            // place for the table data

            //table header
            SizedBox(
              height: height / 10,
              width: width,
              child: Center(
                  child: Text(
                'People Who placed Their bids',
                style: AppTheme.appText.tableTitleText,
              )),
            ),
            Table(
              border:
                  TableBorder.all(color: AppTheme.appColor.tableBorderColor!),
              children: [
                TableRow(children: [
                  TableCell(
                      child: Center(
                          child: Text(
                    'User Name/Email',
                    style: AppTheme.appText.tableHeaderText,
                  ))),
                  TableCell(
                      child: Center(
                          child: Text('Bid Price',
                              style: AppTheme.appText.tableHeaderText))),
                ])
              ],
            ),

            // data is in the tablecell
            SizedBox(
                width: width,
                child: Obx(() {
                  //
                  List<BidPlaced> newList = bidPlacedController.bidPlacedList
                      .where((doc) => doc.productId == id)
                      .toList();
                  return Table(
                    border: TableBorder.all(
                        color: AppTheme.appColor.tableBorderColor!),
                    children: List.generate(
                        newList.length,
                        (index) => TableRow(children: [
                              TableCell(
                                  child: Center(
                                      child: newList[index].userName != ""
                                          ? Text(
                                              newList[index].userName,
                                              style: AppTheme
                                                  .appText.tableCellText,
                                            )
                                          : Text(newList[index].userEmail))),
                              TableCell(
                                  child: Center(
                                      child: Text('${newList[index].bidPrice}',
                                          style:
                                              AppTheme.appText.tableCellText)))
                            ])),
                  );
                }))
          ],
        ),
      ),
    );
  }
}





// nowDatetime.isAfter(DateTime.parse(endDate)) && 
//                   ? Container(
//                       height: height / 4,
//                       width: width,
//                       child: Center(
//                         child: Obx(() {
//                           
//                         }),
//                       ),
//                     )
//                   : null,