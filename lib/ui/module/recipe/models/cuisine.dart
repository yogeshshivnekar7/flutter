class Cuisine {
  final String id;
  final String name;
  final String image;

  Cuisine({this.id, this.name, this.image});

  factory Cuisine.fromJson(Map<String, dynamic> json) {
    return Cuisine(
      id: json['cuisine_id'] as String,
      name: json['cuisine_name'] as String,
      image: json['cuisine_image'] as String,
    );
  }
}
