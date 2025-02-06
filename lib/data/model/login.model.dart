// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

class LoginModel {
  String? loginToken;
  bool? isSuccess;
  String? errorOnFailure;
  String? firstName;
  String? userRole;
  String? userId;
  bool? isAdmin;

  LoginModel({
    this.loginToken,
    this.isSuccess,
    this.errorOnFailure,
    this.firstName,
    this.userRole,
    this.userId,
    this.isAdmin,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        loginToken: json["loginToken"],
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        firstName: json["firstName"],
        userRole: json["userRole"],
        userId: json["userID"],
        isAdmin: json["isAdmin"],
      );
}
