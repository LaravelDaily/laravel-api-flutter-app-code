import 'package:flutter/material.dart';
import 'package:laravel_api_flutter_app/Screens/Auth/Login.dart';
import 'package:laravel_api_flutter_app/Screens/Auth/Register.dart';
import 'package:laravel_api_flutter_app/screens/categories/categories_list.dart';
import 'package:laravel_api_flutter_app/screens/home.dart';
import 'package:laravel_api_flutter_app/providers/category_provider.dart';
import 'package:laravel_api_flutter_app/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AuthProvider(),
        child: Consumer<AuthProvider>(builder: (context, authProvider, child) {
          return MultiProvider(
              providers: [
                ChangeNotifierProvider<CategoryProvider>(
                    create: (context) => CategoryProvider(authProvider)),
              ],
              child: MaterialApp(title: 'Welcome to Flutter', routes: {
                '/': (context) {
                  final authProvider = Provider.of<AuthProvider>(context);
                  return authProvider.isAuthenticated ? Home() : Login();
                },
                '/login': (context) => Login(),
                '/register': (context) => Register(),
                '/home': (context) => Home(),
                '/categories': (context) => CategoriesList(),
              }));
        }));
  }
}
