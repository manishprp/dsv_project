import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:universal_html/html.dart' as html;
import '../../domain/model/user.dart';

class StoreRetrieve {
  StoreRetrieve._();

  static const String _userKey = "User";

  /// Store user object as JSON string
  static Future<void> store(User user) async {
    var jsonStr = jsonEncode(user.toJson());
    if (kIsWeb) {
      html.window.localStorage[_userKey] = jsonStr;
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_userKey, jsonStr);
    }
  }

  /// Retrieve user object from JSON string
  static Future<User?> retrieveUser() async {
    String? storedUser;
    if (kIsWeb) {
      storedUser = html.window.localStorage[_userKey];
    } else {
      final prefs = await SharedPreferences.getInstance();
      storedUser = prefs.getString(_userKey);
    }
    if (storedUser != null) {
      var decodedJsorStr = jsonDecode(storedUser);
      return User.fromJson(decodedJsorStr);
    }
    return null;
  }

  /// Clear user
  static Future<void> clearUser() async {
    if (kIsWeb) {
      html.window.localStorage.remove(_userKey);
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_userKey);
    }
  }
}
