enum Difficulty {
  Easy,
  Medium,
  Hard,
}

class Recipe {
  String id;
  String name;
  String image;
  String duration;
  String serving;
  String difficulty;
  String cuisine;
  String categories;
  String ingredients;
  String steps;
  String userId;
  String fname;
  String lname;
  String userimage;
  String date;
  String total;
  String count;

  Recipe(
      {this.id,
      this.name,
      this.image,
      this.duration,
      this.serving,
      this.difficulty,
      this.cuisine,
      this.categories,
      this.ingredients,
      this.steps,
      this.userId,
      this.lname,
      this.fname,
      this.userimage,
      this.date,
      this.total,
      this.count});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['recipe_id'].toString(),
      name: json['recipe_name'],
      image: json['recipe_image'],
      duration: json['recipe_duration'],
      serving: json['recipe_serving'],
      difficulty: json['recipe_difficulty'],
      cuisine: json['recipe_cuisine'],
      categories: json['recipe_categories'],
      ingredients: json['recipe_ingredients'],
      steps: json['recipe_steps'],
      userId: json['user_id'],
      fname: json['fname'],
      lname: json['lname'],
      userimage: json['image'],
      date: json['date'],
      total: json['total'],
      count: json['count'],
    );
  }

  String get recipeid => id;

  Map<String, dynamic> toJson() {
    return {
      'recipe_id': id,
      'recipe_name': name,
      'recipe_image': image,
      'recipe_duration': duration,
      'recipe_serving': serving,
      'recipe_difficulty': difficulty,
      'recipe_cuisine': cuisine,
      'recipe_categories': categories,
      'recipe_ingredients': ingredients,
      'recipe_steps': steps,
      'user_id': userId,
      'fname': fname,
      'lname': lname,
      'image': userimage,
      'date': date,
    };
  }

  Recipe.map(dynamic obj) {
    this.id = obj['recipe_id'];
    this.name = obj['recipe_name'];
    this.image = obj['recipe_image'];
    this.duration = obj['recipe_duration'];
    this.serving = obj['recipe_serving'];
    this.difficulty = obj['recipe_difficulty'];
    this.cuisine = obj['recipe_cuisine'];
    this.categories = obj['recipe_categories'];
    this.ingredients = obj['recipe_ingredients'];
    this.steps = obj['recipe_steps'];
    this.userId = obj['user_id'];
    this.fname = obj['fname'];
    this.lname = obj['lname'];
    this.userimage = obj['image'];
    this.date = obj['date'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["recipe_name"] = name;
    map["recipe_image"] = image;
    map["recipe_duration"] = duration;
    map["recipe_serving"] = serving;
    map["recipe_difficulty"] = difficulty;
    map["recipe_cuisine"] = cuisine;
    map["recipe_categories"] = categories;
    map["recipe_ingredients"] = ingredients;
    map["recipe_steps"] = steps;
    map["user_id"] = userId;
    map["fname"] = fname;
    map["lname"] = lname;
    map["image"] = userimage;
    map["date"] = date;
    if (id != null) {
      map["recipe_id"] = id;
    }
    return map;
  }

  Recipe.fromMap(Map<String, dynamic> map) {
    this.name = map["recipe_name"];
    this.image = map["recipe_image"];
    this.duration = map["recipe_duration"];
    this.serving = map["recipe_serving"];
    this.difficulty = map["recipe_difficulty"];
    this.cuisine = map["recipe_cuisine"];
    this.categories = map["recipe_categories"];
    this.ingredients = map["recipe_ingredients"];
    this.steps = map["recipe_steps"];
    this.userId = map["user_id"];
    this.fname = map["fname"];
    this.lname = map["lname"];
    this.userimage = map["image"];
    this.date = map["date"];
    this.id = map["recipe_id"].toString();
  }
}
