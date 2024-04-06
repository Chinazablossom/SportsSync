
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/sign_up/screens/Sign_Up_phone_verification_OTP.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';

import '../../home/home.dart';
import '../authorization_screen.dart';
import '../sign_up/screens/Sign_up_verification_email_screen.dart';

class MailVerificationController extends GetxController{
  late Timer _timer;

  final isLoading = false.obs;

  @override
  void onInit(){
    sendEmailVerificationLink();
    setTimerForRedirection();
    super.onInit();

  }

  /// SENDS AND RESENDS EMAIL VERIFICATION LINKS
  void sendEmailVerificationLink() async {
    try{
      await AuthenticationRepository.instance.sendEmailVerificationLink();
    }catch(e){
      Get.snackbar("Opps..", e.toString(),snackPosition: SnackPosition.BOTTOM );
    }

  }


  /// A TIMER TO CHECK IF VERIFICATION PROCESS COMPLETED THEN REDIRECT
  void setTimerForRedirection() async {

     _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
            FirebaseAuth.instance.currentUser?.reload();
            final user = FirebaseAuth.instance.currentUser;

            if(user?.emailVerified ?? false){
              timer.cancel();
              Get.to(() => const SignUpPhoneVerificationOTP());
            }

    });

  }


  /// MANUALLY CHECKING IF VERIFICATION LINK COMPLETED
  void manualVerificationLinkChecker() async  {
    isLoading.value = true;
    FirebaseAuth.instance.currentUser?.reload();

    final user = FirebaseAuth.instance.currentUser;

    if(user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const Home());
      } else {
        Get.offAll(() => SignUpVerificationEmailScreen(email: user.email));
      }
    }else{
      Get.snackbar("Oh no..", "Your E-mail has not been verified");
    }

  }





}