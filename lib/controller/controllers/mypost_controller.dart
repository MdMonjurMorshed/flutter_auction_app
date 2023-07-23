import 'package:auction_bd24/models/bidproduct_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class MyPostController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;
  RxList<BidProduct> myProductList = <BidProduct>[].obs;

  void fetchMyPost() {
    User? user = _auth.currentUser;

    try {
      Stream<QuerySnapshot<Map<String, dynamic>>> myCollections = store
          .collection('bidProduct')
          .where('userId', isEqualTo: user!.uid)
          .snapshots();

      myCollections.listen((querySnapshot) {
        myProductList.value = querySnapshot.docs
            .map((doc) => BidProduct.fromDocument(doc))
            .toList();
      });
    } catch (e) {}
  }
}
