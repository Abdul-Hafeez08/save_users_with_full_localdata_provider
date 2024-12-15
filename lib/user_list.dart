import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataProvider extends ChangeNotifier {
  List<Map<String, String>> _userList = [];

  List<Map<String, String>> get userList => _userList;

  //adding user to list
  Future<void> addUser(
    String name,
    String size1,
    String size2,
    String size3,
    String size4,
    String size5,
    String size6,
    String size7,
    String size8,
  ) async {
    _userList.add({
      'name': name,
      'size1': size1,
      'size2': size2,
      'size3': size3,
      'size4': size4,
      'size5': size5,
      'size6': size6,
      'size7': size7,
      'size8': size8,
    });

    notifyListeners();
    await saveToLocalStorage();
  }

  //now here we are saving data in local storage
  Future<void> saveToLocalStorage() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String jsonString = jsonEncode(_userList);
    await preferences.setString('userList', jsonString);
  }

  //load data from local storage
  Future<void> loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? jsonString = preferences.getString('userList');

    if (jsonString != null) {
      List<dynamic> decodedList = jsonDecode(jsonString);
      _userList = decodedList.map((item) {
        return {
          'name': item['name'] as String,
          'size1': item['size1'] as String,
          'size2': item['size2'] as String,
          'size3': item['size3'] as String,
          'size4': item['size4'] as String,
          'size5': item['size5'] as String,
          'size6': item['size6'] as String,
          'size7': item['size7'] as String,
          'size8': item['size8'] as String,
        };
      }).toList();
    }
    notifyListeners();
  }

  // Deleting a user from the list and local storage
  Future<void> deleteUser(int index) async {
    _userList.removeAt(index);
    await saveToLocalStorage();
    notifyListeners();
  }

  void importData(List<Map<String, String>> newData) {
    _userList.clear();
    _userList.addAll(newData);
    notifyListeners();
  }
}
