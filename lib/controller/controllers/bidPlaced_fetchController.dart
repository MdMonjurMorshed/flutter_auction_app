import 'package:auction_bd24/models/bidPlaced_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class BidPlacedFetchController extends GetxController {
  RxList<BidPlaced> bidPlacedList = <BidPlaced>[].obs;
  FirebaseFirestore fireStore = FirebaseFirestore.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchBidPlaced();
  }

  void fetchBidPlaced() {
    Stream<QuerySnapshot<Map<String, dynamic>>> bidPlacedCollections =
        fireStore.collection('bidPlaced').snapshots();

    bidPlacedCollections.listen((querySnapshot) {
      bidPlacedList.value =
          querySnapshot.docs.map((doc) => BidPlaced.fromDocumnet(doc)).toList();
    });
  }
}
