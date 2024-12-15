// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserDataProvider extends ChangeNotifier {
//   String _name = '';
//   String _phoneNumber = '';

//   String get name => _name;
//   String get phoneNumber => _phoneNumber;

//   //i have added below code for local storage
//   Future<void> setName(String newName) async {
//     _name = newName;
//     notifyListeners();
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     await preferences.setString('name', newName);
//   }

//   Future<void> setPhoneNumber(String newPhoneNumber) async {
//     _phoneNumber = newPhoneNumber;
//     notifyListeners();
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     await preferences.setString('phoneNumber', newPhoneNumber);
//   }

//   Future<void> loadData() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     _name = preferences.getString('name') ?? '';
//     _phoneNumber = preferences.getString('phoneNumber') ?? '';
//     notifyListeners();
//   }
// }
