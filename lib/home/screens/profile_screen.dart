import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/model/user_model.dart';
import 'package:sports_sync/home/controller/profile_controller.dart';
import 'package:sports_sync/widgets/value_fileds.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});


  @override
  Widget build(BuildContext context) {

    final controller = Get.put(ProfileController());


    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(16),
              child: FutureBuilder(
                future: controller.getUserDate(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {

                      UserModel userData = snapshot.data as UserModel;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //    HEADER TXT
                          const Text(
                            "User Profile",
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 40),

                          // USER PROFILE IMAGE
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 30),

                          Form(
                            child: Column(
                              children: [


                                //    USER-NAME TXT FIELD
                                TextFormField(
                                  initialValue: userData.userEmail,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)),
                                     label: const Text("User Name"),
                                    prefixIcon: const Icon(Icons.person_2_outlined, color: Colors.black,),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                  ),


                                ),

                                const SizedBox(height: 20),

                                //    USER-EMAIL TXT FIELD
                                TextFormField(
                                  initialValue: userData.userEmail,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)),
                                    label: const Text("E-mail"),
                                    prefixIcon: const Icon(Icons.mail, color: Colors.black,),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                  ),


                                ),
                                const SizedBox(height: 20),


                                //    USER PHONE-NUMBER TXT FIELD
                                TextFormField(
                                  initialValue: userData.userPhoneNumber,
                                  decoration: InputDecoration(
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide(color: Colors.black)),
                                    label: const Text("Phone Number"),
                                    prefixIcon: const Icon(Icons.phone_android_outlined, color: Colors.black,),
                                    filled: true,
                                    fillColor: Colors.grey.shade300,
                                  ),


                                ),

                                const SizedBox(height: 40),

                                const Text(
                                  "Interests",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),

                                //  LIST OF INTERESTS

                               const SingleChildScrollView(
                                 scrollDirection: Axis.horizontal,
                                 child: Row(children: [

                                 ]),
                               )

                              ],
                            ),
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else {
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },

              )),
        ),
      ),
    );
  }
}
