import 'package:auction_bd24/controller/controllers/mypost_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../themes/app_theme.dart';

class MyPostPage extends StatelessWidget {
  MyPostPage({super.key});
  final myPostController = Get.find<MyPostController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('My Post'),
      ),
      body: Obx(() {
        if (myPostController.myProductList.isNotEmpty) {
          return ListView.builder(
              itemCount: myPostController.myProductList.length,
              itemBuilder: (context, index) {
                final data = myPostController.myProductList[index];

                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(data.productImage),
                  ),
                  title: Text(data.productName),
                  subtitle: Text("${data.bidMinPrice}"),
                  trailing: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Edit Post',
                      style: AppTheme.appText.submiButton,
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
    );
  }
}


  // return Padding(
                //   padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                //   child: Container(
                //     // Styling
                //     height: MediaQuery.of(context).size.height / 5,
                //     width: MediaQuery.of(context).size.width / 1.8,
                //     decoration: BoxDecoration(
                //       color: AppTheme.appColor.productTileColor,
                //       boxShadow: [
                //         BoxShadow(
                //             color: AppTheme.appColor.productTileShadowColor!,
                //             spreadRadius: 1,
                //             blurRadius: 4,
                //             offset: Offset(1, 1))
                //       ],
                //       border: Border.all(
                //         color: AppTheme.appColor.productTileBorderColor!,
                //       ),
                //       borderRadius: BorderRadius.circular(20),
                //     ),

                //     // widget is here in the child

                //     child: Row(
                //       children: [
                //         Padding(
                //           padding: const EdgeInsets.all(8),
                //           child: Container(
                //             height: height / 5,
                //             width: width / 2.5,
                //             decoration: BoxDecoration(
                //                 borderRadius: BorderRadius.circular(20),
                //                 image: DecorationImage(
                //                   image: NetworkImage(data.productImage),
                //                 )),
                //           ),
                //         ),
                //         SizedBox(
                //           height: height / 5,
                //           width: width / 2.2,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text("Product Name: ${data.productName}"),
                //               Text("Bid Price: ${data.bidMinPrice}"),
                //               Text("End Date: ${data.bidDateTime}"),
                //             ],
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // );