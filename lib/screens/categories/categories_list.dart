import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Category {
  final int id;
  final String name;

  Category({required this.id, required this.name});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  CategoriesListState createState() => CategoriesListState();
}

class CategoriesListState extends State<CategoriesList> {
  Future<List<Category>>? futureCategories;
  final _formKey = GlobalKey<FormState>();
  late Category selectedCategory;
  final categoryNameController = TextEditingController();

  Future<List<Category>> fetchCategories() async {
    final http.Response response = await http.get(
        Uri.parse('https://78ac-78-58-236-130.ngrok-free.app/api/categories'));

    final Map<String, dynamic> data = json.decode(response.body);

    if (!data.containsKey('data') || data['data'] is! List) {
      throw Exception('Failed to load categories');
    }

    List categories = data['data'];

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future saveCategory() async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    String url =
        'https://78ac-78-58-236-130.ngrok-free.app/api/categories/${selectedCategory.id}';
    final http.Response response = await http.put(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': categoryNameController.text,
      }),
    );

    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    futureCategories = fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categories List'),
      ),
      body: FutureBuilder<List<Category>>(
          future: futureCategories,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Category category = snapshot.data![index];
                    return ListTile(
                      title: Text(category.name),
                      trailing: IconButton(
                          onPressed: () {
                            selectedCategory = category;
                            categoryNameController.text = category.name;
                            showModalBottomSheet(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: EdgeInsets.all(20),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: [
                                          Text('Edit Category'),
                                          TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Category Name',
                                            ),
                                            controller: categoryNameController,
                                            validator: (String? value) {
                                              if (value == null || value.isEmpty) {
                                                return 'Please enter category name';
                                              }
                                              return null;
                                            },
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(top: 20),
                                            child: ElevatedButton(
                                              onPressed: () {
                                                saveCategory();
                                              },
                                              child: Text('Update'),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          icon: Icon(Icons.edit)),
                    );
                  });
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return CircularProgressIndicator();
          }),
    );
  }
}
