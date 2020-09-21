class Category {
  final String id;
  final String name;
  final String image;

  Category({this.id, this.name, this.image});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['category_id'] as String,
        name: json['category_name'] as String,
        image: json['category_image'] as String);
  }
}
