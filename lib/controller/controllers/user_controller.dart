import 'package:auction_bd24/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  FirebaseFirestore fireStore = FirebaseFirestore.instance;
  RxList<UserModel> userList = <UserModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchuser();
  }

  void fetchuser() {
    Stream<QuerySnapshot<Map<String, dynamic>>> userCollections =
        fireStore.collection('users').snapshots();
    userCollections.listen((querySnapshot) {
      userList.value =
          querySnapshot.docs.map((doc) => UserModel.fromDocument(doc)).toList();
    });
  }

  void changeButton(userid) {
    var user = userList.firstWhere((element) => element.id == userid);
    user.buttonClicked.value = true;
  }

  bool buttonCondition(userid) {
    var user = userList.firstWhere((element) => element.id == userid);
    return !user.buttonClicked.value;
  }
}
