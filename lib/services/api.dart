import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:laravel_api_flutter_app/models/category.dart';

class ApiService {
  late String token;

  ApiService(String token) {
    this.token = token;
  }

  final String baseUrl = 'https://78ac-78-58-236-130.ngrok-free.app';

  Future<List<Category>> fetchCategories() async {
    final http.Response response = await http
        .get(Uri.parse('$baseUrl/api/categories'), headers: <String, String>{
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    final Map<String, dynamic> data = json.decode(response.body);

    if (!data.containsKey('data') || data['data'] is! List) {
      throw Exception('Failed to load categories');
    }

    List categories = data['data'];

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future addCategory(String name) async {
    String url = '$baseUrl/api/categories';
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'name': name,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create category');
    }

    final Map<String, dynamic> data = json.decode(response.body);
    return Category.fromJson(data['data']);
  }

  Future saveCategory(Category category) async {
    String url = '$baseUrl/api/categories/${category.id}';
    final http.Response response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, String>{
        'name': category.name,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update category');
    }

    final Map<String, dynamic> data = json.decode(response.body);
    return Category.fromJson(data['data']);
  }

  Future<void> deleteCategory(id) async {
    String url = '$baseUrl/api/categories/$id';
    final http.Response response = await http.delete(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode != 204) {
      throw Exception('Failed to delete category');
    }
  }

  Future<String> register(String name, String email, String password,
      String password_confirm, String device_name) async {
    String url = '$baseUrl/api/auth/register';
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
        'password_confirmation': password_confirm,
        'device_name': device_name,
      }),
    );

    if (response.statusCode == 422) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic> errors = data['errors'];
      String message = '';
      errors.forEach((key, value) {
        value.forEach((error) {
          message += '$error\n';
        });
      });

      throw Exception(message);
    }

    return response.body;
  }

  Future<String> login(
      String email, String password, String device_name) async {
    String url = '$baseUrl/api/auth/login';
    final http.Response response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'device_name': device_name,
      }),
    );

    if (response.statusCode == 422) {
      final Map<String, dynamic> data = json.decode(response.body);
      final Map<String, dynamic> errors = data['errors'];
      String message = '';
      errors.forEach((key, value) {
        value.forEach((error) {
          message += '$error\n';
        });
      });

      throw Exception(message);
    }

    return response.body;
  }
}
