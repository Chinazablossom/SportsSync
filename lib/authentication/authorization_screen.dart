import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/model/user_model.dart';
import 'package:sports_sync/authentication/sign_up/screens/Sign_Up_phone_verification_OTP.dart';
import 'package:sports_sync/authentication/sign_up/screens/Sign_up_verification_email_screen.dart';
import 'package:sports_sync/authentication/controllers/login_controller.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';

import 'controllers/Sign_Up_Controller.dart';
import 'forgot_password/screen/ForgetPasswordMoalScreen.dart';

class AuthorizationScreen extends StatefulWidget {
  const AuthorizationScreen({super.key,});

  //required this.onImageSelected});

  // final void Function(File pickedImg) onImageSelected;


  @override
  State<AuthorizationScreen> createState() => _AuthorizationScreenState();
}


class _AuthorizationScreenState extends State<AuthorizationScreen> {
  final signUpController = Get.put(SignUpController());
  final logInController = Get.put(LoginController());

  var _isLogin = true;
  final _formKey = GlobalKey<FormState>();

  //USER DETAILS
  var _userName = "";
  var _userEmail = "";
  var _userPhoneNumber = "";
  var _userPassword = "";
  File? _selectedImg;

  Future<void> _submitLoginDetails() async {
    final isValid = _isLogin ? LoginController.instance.loginFormKey.currentState!.validate() : _formKey.currentState!.validate();

    if (!isValid) {
      return;
    }

    _isLogin ? LoginController.instance.loginFormKey.currentState!.save() : _formKey
        .currentState!.save();

    //  try {


    //    ON LOGIN SCREEN
    if (_isLogin) {
      //SignUpAndLoginController.instance.logUserIn(_userEmail, _userPassword);
      LoginController.instance.logUserIn();
      // final userCrdentials = _firebase.signInWithEmailAndPassword(email: , password: _userPassword);
      // Navigator.removeRoute(context, MaterialPageRoute(builder: (context) => const AuthorizationScreen(),));

      print(
          "_userName = $_userName \n_userEmail = $_userEmail \n_userPhoneNumber = $_userPhoneNumber \n_userPassword = $_userPassword \n"
              "sname ${signUpController
              .signUpUserName} \nsemail ${signUpController
              .signUpEmail}\nsnum ${signUpController
              .signUpPhoneNumber}\n spassword ${signUpController
              .signUpPassword}"
        //  "lname ${logInController.userNameLogin} \nlemail ${logInController.emailLogin}\nlnum ${logInController.phoneNumberLogin}\n lpassword ${logInController.passwordLogin}"
      );


    } else {
    /// ON SIGN UP SCREEN



      /// SIGN NEW USER UP
       SignUpController.instance.signUserUp(signUpController.signUpEmail.text.trim(), signUpController.signUpPassword.text.trim());
       //await _firebase.createUserWithEmailAndPassword(email: _userEmail, password: _userPassword);

       /// VERIFY NEW USER EMAIL
       // add functionality


       /// VERIFY NEW USER PHONE NUMBER
      //SignUpController.instance.phoneAuthentication(signUpController.signUpPhoneNumber.text.trim());
      // CircularProgressIndicator();


/*
        AuthenticationRepository.getOtp(errorFun: (){
          Get.snackbar("did not work sadly", "OTP NOT SENT");
        }, phoneNumber: signUpController.phoneNumberSignUp.text.trim(),
            next: (){
              Get.snackbar("OTP SENT", "OTP SENT SUCCESSSSSS");
              //Get.to(() =>  const SignUpPhoneVerificationOTP());//SignUpVerificationEmailScreen()
            });*/

      ///   CREATE USER WITH THE INFORMATION PROVIDED
      final user = UserModel(
          userName: signUpController.signUpUserName.text.trim(),
          userEmail: signUpController.signUpEmail.text.trim(),
          userPhoneNumber: signUpController.signUpPhoneNumber.text.trim(),
          userPassword: signUpController.signUpPassword.text.trim());

      SignUpController.instance.createUser(user);







      // To DELETE
      print(
          "_userName = $_userName \n_userEmail = $_userEmail \n_userPhoneNumber = $_userPhoneNumber \n_userPassword = $_userPassword \n"
              "sname ${signUpController
              .signUpUserName} \nsemail ${signUpController
              .signUpEmail}\nsnum ${signUpController
              .signUpPhoneNumber}\n spassword ${signUpController
              .signUpPassword}"
        //"lname ${logInController.userNameLogin} \nlemail ${logInController.emailLogin}\nlnum ${logInController.phoneNumberLogin}\n lpassword ${logInController.passwordLogin}"



      );
    }


    /*} on FirebaseAuthException catch (error) {
      if (error.code == "email-already-in-use") {
        // ERROR MSG
      }

      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error.message ?? "Authentication error")));
    }*/


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Form(

              /// WHEN IN LOGIN SCREEN WE USE IT'S KEY
              key: _isLogin ? LoginController().loginFormKey : _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _isLogin
                      ? const SizedBox(
                    height: 200,
                  )
                      : const SizedBox(
                    height: 150,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _isLogin ? "Login" : "Sign Up",
                              style: const TextStyle(
                                  fontSize: 36,
                                  color: Color(0xff090808),
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Text(
                              _isLogin
                                  ? "Dont have an account?  "
                                  : "I already have an account  ",
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                          ]),

                      //  LOGIN TXT BTN || SIGN UP TXT BTN
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              _isLogin = !_isLogin;
                            });
                          },
                          child: Text(
                            _isLogin ? "Sign Up" : "Log In",
                            style: const TextStyle(
                                color: Color(0xff58117c),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),


                  ///    SIGN UP USERNAME || NULL
                  _isLogin ? const SizedBox(height: 0,) : TextFormField(
                    controller: signUpController.signUpUserName,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      label: const Text("User Name"),
                      prefixIcon: const Icon(
                        Icons.person_2_outlined, color: Colors.black,),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // signUpController.userNameSignUp = value!;
                      _userName = value!;
                    },
                  ),

                  _isLogin ? const SizedBox(height: 0,) : const SizedBox(
                    height: 20,),


                  /// LOGIN E-MAIL TXT FIELD || SIGN UP EMAIL TXT FIELD

                  _isLogin

                  ///  LOGIN EMAIL
                      ? TextFormField(
                    controller: logInController.loginEmail,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      label: const Text("E-mail"),
                      prefixIcon: const Icon(Icons.mail, color: Colors.black,),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty || !value.contains("@")) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      //  logInController.emailLogin = value!;
                      _userEmail = value!;
                    },
                  )


                  ///   SIGN UP EMAIL TXT FIELD
                      : TextFormField(
                    controller: signUpController.signUpEmail,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      label: const Text("E-mail"),
                      prefixIcon: const Icon(Icons.mail, color: Colors.black,),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textCapitalization: TextCapitalization.none,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null ||
                          value
                              .trim()
                              .isEmpty ||
                          !value.contains("@")) {
                        return "Please enter a valid email address";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // signUpController.emailSignUp = value!;
                      _userEmail = value!;
                    },
                  ),

                  const SizedBox(
                    height: 20,
                  ),


                  ///  LOGIN PASSWORD TXT FIELD || SIGN UP PHONE NUMBER TXT FIELD
                  _isLogin

                  ///    LOGIN PASSWORD
                      ? TextFormField(
                    controller: logInController.loginPassword,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      label: const Text("Password"),
                      prefixIcon: const Icon(
                        Icons.fingerprint_rounded, color: Colors.black,),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .length < 6) {
                        return "Password must be at least 6 charcters long";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // logInController.passwordLogin = value!;
                      _userPassword = value!;
                    },
                  )


                  ///  SIGN UP PHONE NUMBER
                      : TextFormField(
                    controller: signUpController.signUpPhoneNumber,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: const Icon(
                        Icons.phone_android_outlined, color: Colors.black,),
                      prefixText: "+234",
                      prefixStyle: const TextStyle(
                          color: Colors.black, fontSize: 16),
                      label: const Text("Phone Number"),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value
                          .trim()
                          .isEmpty || value.length != 10) {
                        return "Invalid Phone number";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // signUpController.phoneNumberSignUp = value!;
                      _userPhoneNumber = value!;
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),


                  //  LOGIN FORGOT PASSWORD BTN ||  SIGN UP PASSWORD TXT FIELD
                  _isLogin
                  //   LOGIN FORGOT PASSWORD BTN
                      ? Row(
                    mainAxisAlignment: _isLogin
                        ? MainAxisAlignment.end
                        : MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          ForgetPasswordScreen.buildShowModalBottomSheet(
                              context);
                        },
                        child: _isLogin
                            ? const Text(
                          "Forgot password?",
                          style: TextStyle(
                              color: Color(0xff6e12ab),
                              fontWeight: FontWeight.w600),
                        )
                            : const SizedBox(
                          height: 0,
                        ),
                      ),
                    ],
                  )
                      : const SizedBox(
                    height: 12,
                  ),
                  _isLogin
                      ? const SizedBox(
                    height: 0,
                  )


                  //   SIGN-UP PASSWORD TXT FIELD
                      : TextFormField(
                    controller: signUpController.signUpPassword,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: const Icon(
                        Icons.fingerprint_rounded, color: Colors.black,),
                      label: const Text("Password"),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null ||
                          value
                              .trim()
                              .isEmpty ||
                          value
                              .trim()
                              .length < 4) {
                        return "Password must be at least 4 charcters long";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      // signUpController.passwordSignUp = value!;
                      _userPassword = value!;
                    },
                  ),

                  const SizedBox(
                    height: 30,
                  ),


                  //  LOG IN BTN  || SIGN UP BTN
                  GestureDetector(
                    onTap: _submitLoginDetails,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          _isLogin ? "Log In" : "Sign Up",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
