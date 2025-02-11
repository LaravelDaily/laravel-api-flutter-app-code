import 'package:flutter/material.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  CategoriesListState createState() => CategoriesListState();
}

class CategoriesListState extends State<CategoriesList> {
  final List<String> categories = [
    'Electronics',
    'Fashion',
    'Home & Garden',
    'Sporting Goods'
  ];

  int clicked = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Categories clicked $clicked times'),
        ),
        body: Container(
            color: Theme
                .of(context)
                .primaryColor,
            child: Center(
                child: ListView.builder(
                    itemCount: categories.length,
                    // Must be the length of the list
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        title: Text(
                          categories[index],
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () => setState(() => clicked++)
                      );
                    }))));
  }
}
