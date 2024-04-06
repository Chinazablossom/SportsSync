import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sports_sync/authentication/authorization_screen.dart';
import 'package:sports_sync/authentication/sign_up/screens/Sign_up_verification_email_screen.dart';
import 'package:sports_sync/repository/exceptions/authenticator_log_in_exceptions.dart';
import 'package:sports_sync/repository/exceptions/authenticator_sign_up_exceptions.dart';

import '../../home/home.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  ///     VARIABLES
  final _firebase = FirebaseAuth.instance;

  late final Rx<User?> _sportsSyncUser;
  var verificationId = "".obs;

  ///   GETTERS
  User? get sportSyncUser => _sportsSyncUser.value;

  String get getSportUserId => sportSyncUser?.uid ?? "";

  String get getSportUserEmail => sportSyncUser?.email ?? "";

  @override
  void onReady() {
    _sportsSyncUser = Rx<User?>(_firebase.currentUser);
    _sportsSyncUser.bindStream(_firebase.userChanges());

    //  setScreen(_sportsSyncUser.value);
  }

  ///  SETTING INITIAL SCREEN
  setScreen(User? user) {
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const Home());
      } else {
        Get.offAll(() => SignUpVerificationEmailScreen(email: user.email));
      }
    } else {
      Get.offAll(() => const AuthorizationScreen());
    }

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










  /* --------------------- SIGN-UP & LOGIN EMAIL WITH EMAIL & PASSWORD ----------------*/

  ///  [ E-MAIL AUTHENTICATION ] ->  SIGN UP LOGIC & EXCEPTIONS HANDLING
  Future<void> signUpSportsUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await _firebase.createUserWithEmailAndPassword(
          email: email, password: password);
      _sportsSyncUser.value != null
          ? Get.offAll(() => SignUpVerificationEmailScreen(
                email: email ?? " ",
              ))
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
      StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const Home();
            }
            return const AuthorizationScreen();
          });
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
    try {
      await _firebase.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      final exception = SignUpWithEmailAndPasswordFailure.code(e.code);
      Get.snackbar("Authentication Error",
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

  ///   LOGGING USER OUT
  Future<void> logOutUser() async {
    try {
      await _firebase.signOut();
      Get.offAll(() => const AuthorizationScreen());
    } catch (_) {
      Get.snackbar("Error", "An error Occured Check your connection");
    }
  }
}
