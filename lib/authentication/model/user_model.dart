import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  const UserModel(
      {this.userId,
      required this.userName,
      required this.userEmail,
      required this.userPhoneNumber,
      required this.userPassword});

  final String? userId;
  final String userName;
  final String userEmail;
  final String userPhoneNumber;
  final String userPassword;

  /// THIS MAPS USER'S INFORMATION TO JSON
  mapUserInfoToJson() {
    return {
      "User Name": userName,
      "Email": userEmail,
      "Phone": userPhoneNumber,
      "Password": userPassword,
    };
  }

  /// MAP FETCHED DATA FROM FIRE BASE TO USER

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String,dynamic>> document) {
    final data = document.data()!;

    return UserModel(
        userId: document.id,
        userName: data["User Name"],
        userEmail: data["Email"],
        userPhoneNumber: data["Phone"],
        userPassword: data["Password"]);
  }
}
