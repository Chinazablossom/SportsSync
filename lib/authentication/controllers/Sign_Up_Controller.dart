
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/model/user_model.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';
import 'package:sports_sync/repository/user_repo/user_repository.dart';

import '../sign_up/screens/Sign_Up_phone_verification_OTP.dart';

class SignUpController extends GetxController{
  static SignUpController get instance => Get.find();


  /// VARIABLES
  final userRepo =  Get.put(UserRepository());

  //   USER CREDENTIALS
  var signUpUserName = TextEditingController() ;
  var signUpEmail = TextEditingController();
  var signUpPhoneNumber = TextEditingController();
  var signUpPassword = TextEditingController();

  //  THIS SIGN USERS UP
  void signUserUp(String email,String password){
    AuthenticationRepository.instance.signUpSportsUserWithEmailAndPassword(email, password);
  }


  //  THIS LOGS USER IN
  void logUserIn(String email,String password){
    AuthenticationRepository.instance.loginSportsUserWithEmailAndPassword(email, password);
  }


 //   PHONE NUMBER AUTHENTICATION
  void phoneAuthentication(String phoneNumber){
    AuthenticationRepository.instance.phoneNumberAuthentication(phoneNumber);
  }


  /// GET PHONE NUMBER FROM USER AND PASS IT TO AUTH REPO FOR FIREBASE AUTHENTICATION
  Future<void> createUser(UserModel user) async {
    await userRepo.createUser(user);
    phoneAuthentication(user.userPhoneNumber);
    Get.to(() => const SignUpPhoneVerificationOTP());
  }






}