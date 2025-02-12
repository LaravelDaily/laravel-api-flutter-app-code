import 'package:flutter/material.dart';
import 'package:laravel_api_flutter_app/models/category.dart';
import 'package:laravel_api_flutter_app/widgets/category_edit.dart';
import 'package:laravel_api_flutter_app/providers/category_provider.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  CategoriesListState createState() => CategoriesListState();
}

class CategoriesListState extends State<CategoriesList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, provider, child) {
        List<Category> categories = provider.categories;

        return Scaffold(
          appBar: AppBar(
            title: Text('Categories List'),
          ),
          body: ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              Category category = categories[index];
              return ListTile(
                title: Text(category.name),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return CategoryEdit(
                                category, provider.updateCategory);
                          },
                        );
                      },
                      icon: Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text('Delete Category'),
                                content: Text(
                                    'Are you sure you want to delete this category?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      provider.deleteCategory(category);
                                      Navigator.pop(context);
                                    },
                                    child: Text('Delete'),
                                  ),
                                ],
                              );
                            });
                      },
                      icon: Icon(Icons.delete),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
