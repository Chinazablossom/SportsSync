import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  ///   USER CREDENTIALS
  var loginEmail = TextEditingController();
  var loginPassword = TextEditingController();


  final revealPassword = false.obs;
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  /// LOADERS
  final isLoading = false.obs;

  Future<void> logUserIn() async {

    try{
      isLoading.value = true;
      if(!loginFormKey.currentState!.validate()){
        isLoading.value = false;
        return;
      }

      final authentication = AuthenticationRepository.instance;
      await authentication.loginSportsUserWithEmailAndPassword(loginEmail.text.trim(), loginPassword.text.trim());
      authentication.setScreen(authentication.sportSyncUser);
    }catch(e){
      isLoading.value = false;
      Get.snackbar("Opps..", e.toString());
    }


  }



}
