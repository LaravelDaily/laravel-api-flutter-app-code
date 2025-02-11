class Category {
  int _id;
  String _name;

  int get id => _id;

  set id(int id) => _id = id;

  String get name => _name;

  set name(String name) => _name = name;

  Category({required int id, required String name})
      : _id = id,
        _name = name;

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(id: json['id'], name: json['name']);
  }
}