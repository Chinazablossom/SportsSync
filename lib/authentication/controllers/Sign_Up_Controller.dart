import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/model/user_model.dart';
import 'package:sports_sync/authentication/sign_up/screens/Sign_up_verification_email_screen.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';
import 'package:sports_sync/repository/user_repo/user_repository.dart';


class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  /// VARIABLES
  final userRepo = Get.put(UserRepository());

  // LOADER
  final isLoading = false.obs;


  //   USER CREDENTIALS
  var signUpUserName = TextEditingController();

  var signUpEmail = TextEditingController();
  var signUpPhoneNumber = TextEditingController();
  var signUpPassword = TextEditingController();

  //  THIS SIGN USERS UP
  void signUserUp(String email, String password) {
    AuthenticationRepository.instance
        .signUpSportsUserWithEmailAndPassword(email, password);
  }

  //  THIS LOGS USER IN
  void logUserIn(String email, String password) {
    AuthenticationRepository.instance
        .loginSportsUserWithEmailAndPassword(email, password);
  }

  //   PHONE NUMBER AUTHENTICATION
  void phoneAuthentication(String phoneNumber) {
    AuthenticationRepository.instance.phoneNumberAuthentication(phoneNumber);
  }

  /// GET PHONE NUMBER FROM USER AND PASS IT TO AUTH REPO FOR FIREBASE AUTHENTICATION
  Future<void> createUserPhone(UserModel user) async {
    await userRepo.createUser(user);
    phoneAuthentication(user.userPhoneNumber);
  }





  Future<void> createUserEmail() async {
    try {
      isLoading.value = true;

      final user = UserModel(
          userName: signUpUserName.text.trim(),
          userEmail: signUpEmail.text.trim(),
          userPhoneNumber: signUpPhoneNumber.text.trim(),
          userPassword: signUpPassword.text.trim());

      // Auth user first
      final auth = AuthenticationRepository.instance;
      await AuthenticationRepository.instance.signUpSportsUserWithEmailAndPassword(user.userEmail, user.userPassword);

      final userRepo = Get.put(UserRepository());
      await userRepo.createUser(user);

      Get.to(() =>  SignUpVerificationEmailScreen(email: user.userEmail));

      auth.setScreen(auth.sportSyncUser);
      createUserPhone(user);


    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);

    }
  }

























}
