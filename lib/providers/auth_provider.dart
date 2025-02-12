import 'package:flutter/material.dart';
import 'package:laravel_api_flutter_app/services/api.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuthenticated = false;
  ApiService apiService = ApiService();

  AuthProvider();

  Future<String> register(String name, String email, String password,
      String password_confirmation, String device_name) async {
    String token = await apiService.register(
        name, email, password, password_confirmation, device_name);
    isAuthenticated = true;
    notifyListeners();

    return token;
  }

  Future<String> login(
      String email, String password, String device_name) async {
    String token = await apiService.login(email, password, device_name);
    isAuthenticated = true;
    notifyListeners();

    return token;
  }
}
