import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sports_sync/authentication/model/user_model.dart';
import 'package:sports_sync/home/controller/profile_controller.dart';
import 'package:sports_sync/repository/auth_repo/authentication_repository.dart';
import 'package:sports_sync/widgets/LargeButton.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xffc5cbce),
      body: SafeArea(
        child: SingleChildScrollView(
          child:

              /// FUTURE BUILDER TO LOAD CLOUD DATA
              FutureBuilder(
            future: controller.getUserDate(),
            builder: (context, snapShot) {
              if (snapShot.connectionState == ConnectionState.done) {
                if (snapShot.hasData) {
                  UserModel user = snapShot.data as UserModel;

                  /// CONTROLLERS
                  final userName = TextEditingController(text: user.userName);
                  final userEmail = TextEditingController(text: user.userEmail);
                  final userPhone =
                      TextEditingController(text: user.userPhoneNumber);
                  final userPassword =
                      TextEditingController(text: user.userPassword);

                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Settings",
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),

                              ///  UPDATE PHOTO
                              const Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 90,
                                ),
                              ),
                              const SizedBox(height: 30),

                              ///   UPDATE USERNAME
                              TextFormField(
                                controller: userName,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  prefixIcon:
                                      const Icon(Icons.person_2_outlined),
                                  label: const Text("User Name"),
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Field cannot be empty";
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),

                              const SizedBox(height: 20),

                              ///    UPDATE EMAIL
                              TextFormField(
                                controller: userEmail,
                                initialValue: user.userEmail,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  label: const Text("E-mail"),
                                  prefixIcon: const Icon(Icons.mail),
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains("@")) {
                                    return "Invalid email address";
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),

                              const SizedBox(height: 20),

                              //   UPDATE PASSWORD
                              TextFormField(
                                controller: userPassword,
                                initialValue: user.userPassword,
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  label: const Text("Password"),
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  prefixIcon:
                                      const Icon(Icons.fingerprint_rounded),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      value.length < 4) {
                                    return "Password must be at least 4 characters long";
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20),

                              LargeButton(
                                  label: "Save Details",
                                  onTap: () async {
                                    ///   SAVE USER'S NEW INFORMATION
                                    final userNewData = UserModel(
                                      userName: userName.text.trim(),
                                      userEmail: userEmail.text.trim(),
                                      userPhoneNumber: userPhone.text.trim(),
                                      userPassword: userPassword.text.trim(),
                                    );

                                    await controller
                                        .updateUserInfo(userNewData);
                                  }),

                              const SizedBox(height: 40),

                              ///  LOGOUT BTN
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      AuthenticationRepository.instance
                                          .logOutUser();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Log out",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Icon(
                                              Icons.exit_to_app_rounded,
                                              color: Colors.white,
                                            )
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapShot.hasError) {
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Settings",
                                style: TextStyle(
                                  fontSize: 36,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),

                              ///  UPDATE PHOTO
                              const Center(
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  radius: 90,
                                ),
                              ),

                              const SizedBox(height: 30),

                              ///   UPDATE USERNAME
                              TextFormField(
                                initialValue: "null",
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  prefixIcon:
                                      const Icon(Icons.person_2_outlined),
                                  label: const Text("User Name"),
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                validator: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return "Field cannot be empty";
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),

                              const SizedBox(height: 20),

                              ///    UPDATE EMAIL
                              TextFormField(
                                initialValue: "null",
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  label: const Text("E-mail"),
                                  prefixIcon: const Icon(Icons.mail),
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      !value.contains("@")) {
                                    return "Invalid email address";
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),

                              const SizedBox(height: 20),

                              //   UPDATE PASSWORD
                              TextFormField(
                                initialValue: "null",
                                decoration: InputDecoration(
                                  enabledBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  label: const Text("Password"),
                                  filled: true,
                                  fillColor: Colors.grey.shade300,
                                  prefixIcon:
                                      const Icon(Icons.fingerprint_rounded),
                                ),
                                keyboardType: TextInputType.emailAddress,
                                autocorrect: false,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null ||
                                      value.trim().isEmpty ||
                                      value.length < 4) {
                                    return "Password must be at least 4 characters long";
                                  }
                                  return null;
                                },
                              ),

                              const SizedBox(height: 20),

                              LargeButton(label: "Save Details", onTap: () {}),

                              const SizedBox(height: 40),

                              ///  LOGOUT BTN
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      AuthenticationRepository.instance
                                          .logOutUser();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              "Log out",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                            SizedBox(width: 15),
                                            Icon(
                                              Icons.exit_to_app_rounded,
                                              color: Colors.white,
                                            )
                                          ]),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
          ),
        ),
      ),
    );
  }
}
