import 'package:flutter/material.dart';
import 'package:laravel_api_flutter_app/models/category.dart';

class CategoryEdit extends StatefulWidget {
  final Category category;
  final Function categoryCallback;

  const CategoryEdit(this.category, this.categoryCallback, {super.key});

  @override
  CategoryEditState createState() => CategoryEditState();
}

class CategoryEditState extends State<CategoryEdit> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final categoryNameController = TextEditingController();
  String errorMessage = '';

  Future saveCategory(context) async {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    widget.category.name = categoryNameController.text;

    await widget.categoryCallback(widget.category);

    Navigator.pop(context);
  }

  @override
  void initState() {
    categoryNameController.text = widget.category.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
              onChanged: (String value) {
                setState(() {
                  errorMessage = '';
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      saveCategory(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                      foregroundColor: Colors.white,
                    ),
                    child: Text('Update'),
                  ),
                ],
              ),
            ),
            Text(
              errorMessage,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
