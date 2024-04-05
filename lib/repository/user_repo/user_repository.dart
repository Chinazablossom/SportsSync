
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/model/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// STORES USER IN FIRESTORE
  createUser(UserModel user) async {
    await _db.collection("Users").add(user.mapUserInfoToJson()).whenComplete(
            () => Get.snackbar("Success", "Your account has been created.",
            snackPosition: SnackPosition.BOTTOM
            )
    ).catchError((error,stackTrace) {
      Get.snackbar("Error", "Something went wrong,try again",
          snackPosition: SnackPosition.BOTTOM
      );
    });


  }


  /// FETCH USER DETALIS

  Future<UserModel> getUserDetails(String email) async {
  final snapShot = await _db.collection("Users").where("Email",isEqualTo: email).get();
  final userData = snapShot.docs.map((e) => UserModel.fromSnapshot(e)).single;
  return userData;
  }



  ///  UPDATE USER RECORD

Future<void> updateUserRecord(UserModel) async {
    
}


}