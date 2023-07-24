import 'package:cloud_firestore/cloud_firestore.dart';

class BidProduct {
  String productId;
  String userId;
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
      required this.productId,
      required this.userId});

  factory BidProduct.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    return BidProduct(
        productName: doc['productName'],
        productDescription: doc['productDescription'],
        bidMinPrice: double.tryParse(
            doc['productMinBidPrice'].replaceAll(RegExp(r'[^\d.]'), ''))!,
        bidDateTime: doc['bidExpiryDate'],
        productImage: doc['productImage'],
        productId: doc.id,
        userId: doc['userId'] ?? '');
  }
}
