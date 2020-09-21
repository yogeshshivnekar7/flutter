class Comment {
  final String id;
  final String userId;
  final String recipeId;
  final String comment;
  final String date;
  final String fName;
  final String lName;
  final String image;

  Comment(
      {this.id,
      this.userId,
      this.recipeId,
      this.comment,
      this.date,
      this.fName,
      this.lName,
      this.image});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      recipeId: json['recipe_id'] as String,
      comment: json['comment'] as String,
      date: json['date'] as String,
      fName: json['fname'] as String,
      lName: json['lname'] as String,
      image: json['image'] as String,
    );
  }
}
