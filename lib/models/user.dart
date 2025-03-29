import 'package:flutter/material.dart';
import 'package:karmakart/core/utils/utils.dart';

// Will have to implement management for profile pic
class UserModel {
  String userName;
  String email;
  List<String> socialLinks;
  List<ServiceTags> services;
  String userBio;
  Image profilePic;
  int userPrice;
  List<dynamic> testimonials;
  double rating;
  List<dynamic> projects;
  double balance; // karma points balance

  UserModel({
    this.userName = "New User",
    required this.email,
    this.socialLinks = const <String>[],
    this.services = const <ServiceTags>[],
    this.userBio = "I am new user",
    this.profilePic = const Image(image: AssetImage('assets/testpfp.jpg')),
    this.userPrice = 100,
    this.testimonials = const [],
    this.rating = 0.0,
    this.projects = const [],
    this.balance = 500.00,
  });

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "email": email,
      "socialLinks": socialLinks,
      "services": services,
      "userBio": userBio,
      "profilePic": profilePic,
      "userPrice": userPrice,
      "testimonials": testimonials,
      "rating": rating,
      "projects": projects,
      "balance": balance,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    UserModel user = UserModel(
      email: json["email"],
      userName: json["userName"],
      socialLinks: json["socialLinks"],
      services: json["services"],
      userBio: json["userBio"],
      userPrice: json["userPrice"],
      testimonials: json["testimonials"],
      rating: json["rating"],
      projects: json["projects"],
      balance: json["balance"],
    );
    return user;
  }
}
