
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';

class MailVerificationController extends GetxController{
  late Timer _timer;

  @override
  void onInit(){
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

     _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
            FirebaseAuth.instance.currentUser?.reload();
            final user = FirebaseAuth.instance.currentUser;

            if(user!.emailVerified){
              timer.cancel();
              AuthenticationRepository.instance.setScreen(user);


            }
    });


  }



  /// FINISH SIGN UP METHODS
  /// FINISH FORGOT PASSWORD METHOD
  /// SET GTKY SCREEN
  /// GET VALUE AND WORK ON DELETE,UPLOAD


  /// MANUALLY CHECKING IF VERIFICATION LINK COMPLETED
  void manualVerificationLinkChecker() async  {

  }




}