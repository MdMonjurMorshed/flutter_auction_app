import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/bidproduct_model.dart';

class ProductFetchController extends GetxController {
  FirebaseFirestore store = FirebaseFirestore.instance;
  RxList<BidProduct> productList = <BidProduct>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  void fetchData() {
    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> collectionData =
          store.collection('bidProduct').snapshots();
      collectionData.listen((querySnapshot) {
        productList.value = querySnapshot.docs
            .map((doc) => BidProduct.fromDocument(doc))
            .toList();
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
