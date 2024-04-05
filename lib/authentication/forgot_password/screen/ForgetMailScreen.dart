

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/controllers/mail_verification_controllers.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';

import '../../../../widgets/LargeButton.dart';
import '../../controllers/login_controller.dart';
import 'OTP_Screen.dart';

class ForgetMailScreen extends StatefulWidget{
  const ForgetMailScreen({super.key});

  @override
  State<ForgetMailScreen> createState() => _ForgetMailScreenState();
}

class _ForgetMailScreenState extends State<ForgetMailScreen> {

  final logInController = Get.put(LoginController());
  final _resetEmailTextController = TextEditingController();


  @override
  void dispose() {
    _resetEmailTextController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

   return Scaffold(
     backgroundColor: const Color(0xffc5cbce),
     body: SafeArea(
       child: Padding(
         padding: const EdgeInsets.all(18),
         child: SingleChildScrollView(
           child: Form(
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const SizedBox(height: 180,),
                 const Text("Forgot Password",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold)),
                 const Text("Enter the email a verification link will be sent to",style: TextStyle(fontSize: 15),textAlign: TextAlign.center ),
                 const SizedBox(height: 50,),
                 Form(child: Column(
                   children: [


                     //   ENTER E-MAIL TXT FIELD
                     TextFormField(
                       controller: _resetEmailTextController,
                       decoration: InputDecoration(
                         enabledBorder: const OutlineInputBorder(
                           borderSide: BorderSide(color: Colors.white),
                         ),
                         focusedBorder: const OutlineInputBorder(
                             borderSide: BorderSide(color: Colors.black)),
                         hintText: "Enter your email",
                         filled: true,
                         fillColor: Colors.grey.shade300,
                       ),keyboardType: TextInputType.emailAddress,
                       validator: (value) {
                         if (value == null || value.trim().isEmpty || !value.contains("@")) {
                           return "Enter a valid email";
                         }
                         return null;
                       },
                       onSaved: (value) {
                       // _userPassword = value!;
                       },
                     ),

                     const SizedBox(height: 30,),





                     //    NEXT BTN
                     LargeButton(label: "Send link",onTap: () {
                       var email = _resetEmailTextController.toString();
                     //  Get.to(() => OTPScreen()
                       FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                       print("this is email $email");
                     },

                     ),

                   ],
                 ))



               ],
             ),
           ),
         ),
       ),
     ),
   );


  }
}

