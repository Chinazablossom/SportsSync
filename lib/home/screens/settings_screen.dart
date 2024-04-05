import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/controllers/Sign_Up_Controller.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';
import 'package:sports_sync/widgets/LargeButton.dart';

import '../../../widgets/edit_item.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreen();
}

class _SettingsScreen extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {

    final contoller = Get.put(SignUpController());

    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Settings",
                    style: TextStyle(
                      fontSize: 36,color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),



                  ///  UPDATE PHOTO
                 const EditItem(title: "Profile Pic",
                     widget: CircleAvatar(backgroundColor: Colors.black,radius: 90,) ),
                  const SizedBox(height: 30),






                  ///    UPDATE EMAIL
                  TextFormField(
                    controller: contoller.signUpEmail,
                      decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        label: const Text("E-mail"),prefixIcon: const Icon(Icons.mail),
                        filled: true,
                        fillColor: Colors.grey.shade300,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty || !value.contains("@") ) {
                          return "Invalid email address";
                        }
                        return null;
                      },
                      onSaved: (value) {

                      },
                    ),




                  const SizedBox(height: 20),


                   //   UPDATE USERNAME
                  TextFormField(
                    controller: contoller.signUpUserName,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),prefixIcon: const Icon(Icons.person_2_outlined),
                      label: const Text("User Name"),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty ) {
                        return "Field cannot be empty";
                      }
                      return null;
                    },
                    onSaved: (value) {

                    },
                  ),




                  const SizedBox(height: 20),


                   //   UPDATE PASSWORD
                  TextFormField(
                    controller: contoller.signUpPassword,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      label: const Text("Password"),
                      filled: true,
                      fillColor: Colors.grey.shade300,prefixIcon: const Icon(Icons.fingerprint_rounded),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty || value.length < 4) {
                        return "Password must be at least 4 characters long";
                      }
                      return null;
                    },
                    onSaved: (value) {

                    },
                  ),


                  const SizedBox(height: 20),

                  LargeButton(label: "Save Details", onTap: (){
                    /// save details
                  }),

                  const SizedBox(height: 40),


                 ///  LOGOUT BTN
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                         AuthenticationRepository.instance.logOutSportsUserWithEmailAndPassword();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Text("Log out",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                              SizedBox(width: 15),

                              Icon(Icons.exit_to_app_rounded,color: Colors.white,)
                            ]
                          ),
                        ),
                      ),
                    ],
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
