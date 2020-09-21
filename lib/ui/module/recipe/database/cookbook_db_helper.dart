import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';

class CookBookDatabaseHelper {
  final String tableFavorites = "cookbookTable";

  final String columnId = "recipe_id";
  final String columnName = "recipe_name";
  final String columnImage = "recipe_image";
  final String columnDuration = "recipe_duration";
  final String columnServing = "recipe_serving";
  final String columnDifficulty = "recipe_difficulty";
  final String columnCuisine = "recipe_cuisine";
  final String columnCategories = "recipe_categories";
  final String columnIngredients = "recipe_ingredients";
  final String columnSteps = "recipe_steps";
  final String columnUserId = "user_id";
  final String columnUserImage = "image";
  final String columnFName = "fname";
  final String columnLName = "lname";
  final String columnDate = "date";

  // creating an instance
  static final CookBookDatabaseHelper _instance =
      new CookBookDatabaseHelper.internal();

  // constructor private
  CookBookDatabaseHelper.internal();

  // cashes the states of the database, if it is already initialized first no need to initialized it again
  factory CookBookDatabaseHelper() => _instance;

  // create db instance
  static Database _db;

  Future<Database> get db async {
    // if instance is created already return it
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var documentDirectory = await getDatabasesPath();
    String path = join(documentDirectory, "FoodRecipes.db");
    var ourDB = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDB;
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE $tableFavorites($columnId INTEGER PRIMARY KEY, $columnName TEXT, $columnImage TEXT, $columnDuration TEXT, $columnServing TEXT, $columnDifficulty TEXT, $columnCuisine TEXT, $columnCategories TEXT, $columnIngredients, $columnSteps TEXT, $columnUserId TEXT, $columnUserImage TEXT, $columnFName, $columnLName TEXT, $columnDate TEXT)");
  }

  //CRUD Operations - Create, Read, Update, Delete

  // Save a recipe in database
  Future<int> saveRecipe(Recipe recipe) async {
    var dbClient = await db;
    int result = await dbClient.insert(tableFavorites, recipe.toMap());
    return result;
  }

  // Get all saved recipes from database
  Future<List> getAllRecipes() async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $tableFavorites");
    return result;
  }

  // Get a Recipe by its id from database
  Future<Recipe> getRecipe(int recipeId) async {
    var dbClient = await db;
    var result = await dbClient
        .rawQuery("SELECT * FROM $tableFavorites WHERE $columnId = $recipeId");
    if (result.length == 0) return null;
    return new Recipe.fromMap(result.first);
  }

  // Delete a recipe from database
  Future<int> deleteRecipe(int recipeId) async {
    var dbClient = await db;
    return await dbClient
        .delete(tableFavorites, where: "$columnId = ?", whereArgs: [recipeId]);
  }

  // Update a recipe in database
  Future<int> updateRecipe(Recipe recipe) async {
    var dbClient = await db;
    return await dbClient
        .update(tableFavorites, recipe.toMap(), whereArgs: [recipe.id]);
  }

  // Closes the database when done, because it uses resources in background.
  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
