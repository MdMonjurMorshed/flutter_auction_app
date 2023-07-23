import 'package:cloud_firestore/cloud_firestore.dart';

class BidProduct {
  String productId;
  String productName;
  String productDescription;
  double bidMinPrice;
  String bidDateTime;
  String productImage;
  BidProduct(
      {required this.productName,
      required this.productDescription,
      required this.bidMinPrice,
      required this.bidDateTime,
      required this.productImage,
      required this.productId});

  factory BidProduct.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return BidProduct(
        productName: doc['productName'],
        productDescription: doc['productDescription'],
        bidMinPrice: double.parse(doc['productMinBidPrice']),
        bidDateTime: doc['bidExpiryDate'],
        productImage: doc['productImage'],
        productId: doc.id);
  }
}
