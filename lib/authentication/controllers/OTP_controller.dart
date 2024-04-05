
import 'package:get/get.dart';
import 'package:sports_sync/authentication/sign_up/screens/Getting_Started_Screen.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';

class OTPController extends GetxController{
  static OTPController get instance => Get.find();

  void verifyOTP(String otp) async {
    var isVerified = await AuthenticationRepository.instance.verifyOTP(otp);


   isVerified ? Get.offAll(const GettingStartedScreen()) : Get.snackbar("Incorrect OTP", "The OTP you entererd is incorrect");
    //isVerified ? Get.snackbar("Worked", "it Worked") : Get.snackbar("not work", "Not Wrk!1");

  }

}