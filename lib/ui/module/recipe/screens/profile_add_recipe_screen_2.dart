import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_add_screen.dart';

class ProfileAddRecipeScreen extends StatefulWidget {
  @override
  _ProfileAddRecipeScreenState createState() => _ProfileAddRecipeScreenState();
}

class _ProfileAddRecipeScreenState extends State<ProfileAddRecipeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          'ADD RECIPE',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      resizeToAvoidBottomPadding: false,
      body: AddRecipeScreen(
        comingFrom: "my profie",
      ),
    );
  }
}
