import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/authorization_screen.dart';
import 'package:sports_sync/authentication/sign_up/screens/Sign_up_verification_email_screen.dart';
import 'package:sports_sync/repository/exceptions/authenticator_log_in_exceptions.dart';
import 'package:sports_sync/repository/exceptions/authenticator_sign_up_exceptions.dart';

import '../../home/home.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();


  ///     VARIABLES
  final _firebase = FirebaseAuth.instance;
  static final _firebasee = FirebaseAuth.instance; /// DELETE**************************
  late final Rx<User?> _sportsSyncUser;
  var verificationId = "".obs;

  static String veriId = ""; /// DELETE ****

  ///   GETTERS
  User? get sportSyncUser => _sportsSyncUser.value ;
  String get getSportUserId => sportSyncUser?.uid ?? "" ;
  String get getSportUserEmail => sportSyncUser?.email  ?? "";



  @override
  void onReady() {
    _sportsSyncUser = Rx<User?>(_firebase.currentUser);
    _sportsSyncUser.bindStream(_firebase.userChanges());

   // ever(_sportsSyncUser, (callback) => _setScreen);
    setScreen(_sportsSyncUser.value);
  }

  ///  SETTING INITIAL SCREEN
  setScreen(User? user) {
    user == null
        ? Get.offAll(() => const AuthorizationScreen())
        : user.emailVerified
        ? Get.offAll(() => const Home())
        : const SignUpVerificationEmailScreen();
  }



/* -----------------    PHONE NUMBER AUTHENTICATION ----------*/

  ///  [ PHONE-AUTHENTICATION ]  FOR SIGNING IN
  void phoneNumberAuthentication(String phoneNumber) async {
    await _firebase.verifyPhoneNumber(
      phoneNumber: "+234$phoneNumber",
      verificationCompleted: (phoneAuthCredential) async {
        await _firebase.signInWithCredential(phoneAuthCredential);
      },
      verificationFailed: (error) {
        if (error.code == "invalid-phone-number") {
          Get.snackbar("Error", "The phone number you provided is not valid");
        } else {
          Get.snackbar("Error", "Something went wrong. Try again.");
        }
      },
      codeSent: (verificationId, forceResendingToken) async {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        this.verificationId.value = verificationId;
      },
    );
  }

///  [ OTP VERIFICATION LOGIC ]
  Future<bool> verifyOTP(String otp) async {
    var credentials = await _firebase.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));

    return credentials.user != null ? true : false;
  }



///////////////////////////////////
  //  FUNCTION TO GET OTP     DELETE***********
  static Future getOtp(
      {required Function errorFun,
      required String phoneNumber,
      required Function next}) async {
    await _firebasee
        .verifyPhoneNumber(
      phoneNumber: "+234$phoneNumber",
      timeout: const Duration(seconds: 30),
      verificationCompleted: (phoneAuthCredential) async {
        //  await _firebase.signInWithCredential(phoneAuthCredential);
        return;
      },
      verificationFailed: (error) {
        return;
      },
      codeSent: (verificationId, forceResendingToken) async {
        veriId = verificationId;
        next();
      },
      codeAutoRetrievalTimeout: (verificationId) async {
        return;
      },
    )
        .onError((error, stackTrace) {
      errorFun();
    });
  }

  static Future loginWithOtp({required String otp}) async {
    final credentials =
        PhoneAuthProvider.credential(verificationId: veriId, smsCode: otp);

    try {
      final user = await _firebasee.signInWithCredential(credentials);

      if (user.user != null) {
        Get.snackbar("good", "Success");
      } else {
        Get.snackbar("bad", "error in otp login");
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("exception", e.message!);
    } catch (_) {
      Get.snackbar("title", _.toString());
    }
  }
////////////////////////////////







  /* --------------------- SIGN-UP & LOGIN EMAIL WITH EMAIL & PASSWORD ----------------*/

  ///  [ E-MAIL AUTHENTICATION ] ->  SIGN UP LOGIC & EXCEPTIONS HANDLING
  Future<void> signUpSportsUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);
      _sportsSyncUser.value != null
          ? Get.offAll(() => const SignUpVerificationEmailScreen())
          : Get.to(() => const AuthorizationScreen());
    } on FirebaseAuthException catch (e) {
      final exception = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar('Authentication Error',
          e.message ?? 'An error occurred during authentication',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
      throw exception;
    } catch (_) {
      const exception = SignUpWithEmailAndPasswordFailure();

      Get.snackbar('Authentication Error', exception.errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);

      throw exception;
    }
  }

  ///  [ E-MAIL AUTHENTICATION ] ->  LOGIN LOGIC & EXCEPTIONS HANDLING
  Future<void> loginSportsUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebase.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      final exception = LogInFailure.code(e.code);

      Get.snackbar('Authentication Error',
          e.message ?? 'An error occurred during authentication',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);

      throw exception;
    } catch (_) {
      const exception = LogInFailure();
      Get.snackbar('Authentication Error', exception.errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
      throw exception;
    }
  }



  /// [ E-MAIL VERIFICATION ] ->  VERIFICATION
  Future<void> sendEmailVerificationLink() async {
    try{
     await _firebase.currentUser?.sendEmailVerification();
    }on FirebaseAuthException catch(e){
      final exception = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar('Authentication Error',
          e.message ?? 'An error occurred during authentication',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);
      throw exception;

    }catch(_){
      const exception = SignUpWithEmailAndPasswordFailure();
      Get.snackbar('Authentication Error', exception.errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.white);

      throw exception;
    }

  }





  ///   LOGGING USER OUT
  Future<void> logOutSportsUserWithEmailAndPassword() async {
    try {
      await _firebase.signOut();
    } catch (_) {}
  }






}
