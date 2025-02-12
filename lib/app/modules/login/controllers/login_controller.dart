import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  Future<bool> isUserDataExists() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.containsKey('user_data'); // Returns true if key exists
  }

  Future<void> saveUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final user = {
      'user': 'username',
      'score': [
        {'score': 1, 'level': 1}
      ]
    };

    // Convert Map to JSON String
    String userJson = jsonEncode(user);

    // Save to SharedPreferences
    await prefs.setString('user_data', userJson);
  }

  var scoreSet = <Map<String, dynamic>>[];

  Future<void> getUserData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String? userJson = prefs.getString('user_data');
    if (userJson != null) {
      Map<String, dynamic> userData = jsonDecode(userJson);

      // Extract the list of scores
      List<dynamic> scores = userData['score'];

      // Assign it to scoreSet by casting it to List<Map<String, dynamic>>
      scoreSet = List<Map<String, dynamic>>.from(scores);

      debugPrint(scoreSet
          .toString()); // Output: [{score: 1, level: 1}, {score: 2, level: 2}]
    }
  }

  // Retrieve data
//   Map<String, dynamic>? userData = await controller.getUserData();
//   print(userData); // Output: {user: username, score: {score: 1, level: 1}}
}
