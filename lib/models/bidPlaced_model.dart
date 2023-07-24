import 'package:cloud_firestore/cloud_firestore.dart';

class BidPlaced {
  double bidPrice;
  String productId;
  String userEmail;
  String userName;
  BidPlaced(
      {required this.bidPrice,
      required this.productId,
      required this.userEmail,
      required this.userName});

  factory BidPlaced.fromDocumnet(DocumentSnapshot<Map<String, dynamic>> doc) {
    return BidPlaced(
        bidPrice: doc['bidPrice'],
        productId: doc['productId'],
        userEmail: doc['userEmail'],
        userName: doc['userName']);
  }
}
