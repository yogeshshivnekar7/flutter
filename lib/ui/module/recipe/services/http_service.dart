import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/module/recipe/models/category.dart';
import 'package:sso_futurescape/ui/module/recipe/models/comment.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/models/user.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import '../models/cuisine.dart';

class HttpService {
  // Host URL (Replace it with your host)
  static String URL = Environment().getCurrentConfig().recipeUrl.toString();

  // API URL (The file performing CRUD operations)
  static String API = URL + '/api/api.php';

  //
  // Images paths in the server
  static var RECIPE_IMAGES_PATH = URL + '/upload/recipe/';
  static var CATEGORY_IMAGES_PATH = URL + '/upload/category/';
  static var CUISINE_IMAGES_PATH = URL + '/upload/cuisine/';
  static var USER_IMAGES_PATH = /*URL +*/ ""; // 'https://auth-vezaone.s3.ap-south-1.amazonaws.com/users/';

  ///upload/user

  // User map actions
  static const _REGISTER_USER = 'REGISTER_USER';
  static const _LOGIN_USER = 'LOGIN_USER';
  static const _ADD_USER_FOLLOW = 'ADD_USER_FOLLOW';
  static const _ADD_USER_RATE = 'ADD_USER_RATE';
  static const _ADD_USER_COMMENT = 'ADD_USER_COMMENT';
  static const _GET_USER_INFO = 'GET_USER_INFO';
  static const _GET_USER_RATE = 'GET_USER_RATE';
  static const _GET_USER_RECIPES_COUNT = 'GET_USER_RECIPES_COUNT';
  static const _GET_COUNT_FOLLOWERS = 'GET_COUNT_FOLLOWERS';
  static const _GET_COUNT_FOLLOWING = 'GET_COUNT_FOLLOWING';
  static const _GET_USER_FOLLOWERS = 'GET_USER_FOLLOWERS';
  static const _GET_USER_FOLLOWING = 'GET_USER_FOLLOWING';
  static const _UPDATE_USER_INFO = 'UPDATE_USER_INFO';
  static const _UPDATE_USER_RECIPE = 'UPDATE_USER_RECIPE';
  static const _DELETE_USER_IMAGE = 'DELETE_USER_IMAGE';
  static const _DELETE_USER_COMMENT = 'DELETE_USER_COMMENT';
  static const _DELETE_USER_RECIPE = 'DELETE_USER_RECIPE';
  static const _RESET_PASSWORD = 'RESET_PASSWORD';
  static const _CHANGE_PASSWORD = 'CHANGE_PASSWORD';
  static const _CHECK_IF_USER_IS_FOLLOWING = 'CHECK_IF_USER_IS_FOLLOWING';

  // Categories and Cuisine map actions
  static const _GET_ALL_CATEGORIES = 'GET_ALL_CATEGORIES';
  static const _GET_ALL_CUISINE = 'GET_ALL_CUISINE';

  // Recipe map actions
  static const _ADD_RECIPE = 'ADD_RECIPE';
  static const _GET_ALL_RECIPES = 'GET_ALL_RECIPES';
  static const _GET_RECENT_RECIPES = 'GET_RECENT_RECIPES';
  static const _GET_RECENT_BY_RECIPE_ID = 'GET_RECIPE_BY_RECIPE_ID';
  static const _GET_MOST_COLLECTED = 'GET_MOST_COLLECTED';
  static const _GET_RECIPE_BY_USER = 'GET_RECIPE_BY_USER';
  static const _GET_RECIPE_BY_CATEGORY = 'GET_RECIPE_BY_CATEGORY';
  static const _GET_RECIPE_BY_CUISINE = 'GET_RECIPE_BY_CUISINE';
  static const _GET_RECIPE_RATE = 'GET_RECIPE_RATE';
  static const _GET_RECIPE_COMMENTS = 'GET_RECIPE_COMMENTS';
  static const _GET_RECIPE_LIKES = 'GET_RECIPE_LIKES';
  static const _UPDATE_RECIPE_VIEWS = 'UPDATE_RECIPE_VIEWS';
  static const _UPDATE_RECIPE_LIKES = 'UPDATE_RECIPE_LIKES';

  // Privacy policy map action
  static const _GET_PRIVACY_POLICY = 'GET_PRIVACY_POLICY';

  // Device token map action
  static const _SET_DEVICE_TOKEN = 'SET_DEVICE_TOKEN';

  // Register a new user in the database
  static Future<String> registerUser(String id, String fname, String lname,
      String email, String password, String image, String imagename) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _REGISTER_USER;
      map['id'] = id;
      map['fname'] = fname;
      map['lname'] = lname;
      map['email'] = email;
      map['password'] = password;
      if (image != null) {
        map['image'] = image;
      }
      map['name'] = imagename;
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<String, dynamic>();
        return parsed['message'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Login a user
  static Future<User> loginUser(
      BuildContext context, String email, String password) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _LOGIN_USER;
      map['email'] = email;
      map['password'] = password;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = await json.decode(response.body).cast<String, dynamic>();
        User user = User.fromJson(parsed['user']);
        return user;
      } else {
        return User();
      }
    } catch (e) {
      print(e);
      return User(); // return an empty list on exception/error
    }
  }

  // Get user information from the database
  static Future<User> getUserInfo(String id) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_USER_INFO;
      map['id'] = id;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<String, dynamic>();
        User user = User.fromJson(parsed['user']);
        return user;
      } else {
        return User();
      }
    } catch (e) {
      print(e);
      return User();
    }
  }

  // Get the privacy policy from the backend
  static Future<String> getPrivacyPolicy() async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_PRIVACY_POLICY;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<String, dynamic>();
        return parsed['privacy_policy'].toString();
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Get the rate average of a recipe from the database
  static Future<String> getRecipeRate(String recipeid) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_RECIPE_RATE;
      map['recipe_id'] = recipeid;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<String, dynamic>();
        return parsed['rate'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Get the number of likes of a recipe from the database
  static Future<int> getRecipeLikes(String recipeid) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_RECIPE_LIKES;
      map['recipe_id'] = recipeid;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<String, dynamic>();
        return parsed['likes'];
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return 0;
    }
  }

  // Get the rate a of user for a specific recipe
  static Future<String> getUserRateOfRecipe(
      String recipeid, String userid) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_USER_RATE;
      map['recipe_id'] = recipeid;
      //map['user_id'] = userid;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<String, dynamic>();
        return parsed['rate'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Get the number of user recipes
  static Future<int> getUserRecipesCount(String userid) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_USER_RECIPES_COUNT;
      map['user_id'] = userid;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<String, dynamic>();
        return parsed['count'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Update user information in the database
  static Future<String> updateUserInfo(String id, String fname, String lname,
      String image, String imagename) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _UPDATE_USER_INFO;
      map['id'] = id;
      map['fname'] = fname;
      map['lname'] = lname;
      map['image'] = image;
      map['name'] = imagename;
      final encoding = Encoding.getByName('utf-8');
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map, encoding: encoding);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        var data = json.decode(response.body);
        Fluttertoast.showToast(
            msg: data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM);
        return response.body;
      } else {
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        return "error";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Update user recipe in the database
  static Future<String> updateUserRecipe(
      String recipeId,
      String name,
      String serving,
      String duration,
      String difficulty,
      String category,
      String cuisine,
      String ingredients,
      String steps,
      String image,
      String imagename) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _UPDATE_USER_RECIPE;
      map['id'] = recipeId;
      map['name'] = name;
      map['serving'] = serving;
      map['duration'] = duration;
      map['difficulty'] = difficulty;
      map['category'] = category;
      print(cuisine);
      map['cuisine'] = cuisine;
      map['ingredients'] = ingredients;
      map['steps'] = steps;
      map['image'] = image;
      map['imagename'] = imagename;
      final encoding = Encoding.getByName('utf-8');
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map, encoding: encoding);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        var data = json.decode(response.body);
        /* Fluttertoast.showToast(
            msg: data['message'], toastLength: Toast.LENGTH_SHORT);*/
        return response.body;
      } else {
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        return "error";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Add user recipe to the database
  static Future<String> addRecipe(
      String userId,
      String name,
      String serving,
      String duration,
      String difficulty,
      String category,
      String cuisine,
      String ingredients,
      String steps,
      String image,
      String imagename) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map, idkey: "id");
      map['action'] = _ADD_RECIPE;
      //map['id'] = userId;
      map['name'] = name;
      map['serving'] = serving;
      map['duration'] = duration;
      map['difficulty'] = difficulty;
      map['category'] = category;
      print(cuisine);
      map['cuisine'] = cuisine;
      map['ingredients'] = ingredients;
      map['steps'] = steps;
      map['image'] = image;
      map['imagename'] = imagename;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);

      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        var data = json.decode(response.body);

        /* Fluttertoast.showToast(
            msg: data['message'], toastLength: Toast.LENGTH_SHORT);*/
        return response.body;
      } else {
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        return "error";
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Get all categories from the database
  static Future<List<Category>> getCategories() async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_ALL_CATEGORIES;
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");

      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Category> list =
        parsed.map<Category>((json) => Category.fromJson(json)).toList();
        return list;
      } else {
        return List<Category>();
      }
    } catch (e) {
      return List<Category>(); // return an empty list on exception/error
    }
  }

  // Get all cuisine from the database
  static Future<List<Cuisine>> getCuisine() async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_ALL_CUISINE;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Cuisine> list =
        parsed.map<Cuisine>((json) => Cuisine.fromJson(json)).toList();
        return list;
      } else {
        return List<Cuisine>();
      }
    } catch (e) {
      return List<Cuisine>();
    }
  }

  // Get all recipes from the database
  static Future<List<Recipe>> getAllRecipes() async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_ALL_RECIPES;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Recipe> list =
        parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
        return list;
      } else {
        return List<Recipe>();
      }
    } catch (e) {
      return List<Recipe>();
    }
  }

  // Get most collected recipes from the database
  static Future<List<Recipe>> getMostCollectedRecipes() async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_MOST_COLLECTED;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Recipe> list =
        parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
        return list;
      } else {
        return List<Recipe>();
      }
    } catch (e) {
      return List<Recipe>();
    }
  }

  // Get recent recipes from the database
  static Future<List<Recipe>> getRecentRecipes() async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map = await getSSOAuth(map);
      // map["user_id"] = "17b75be0-cb56-11ea-b054-5bc604dae451";
      map['action'] = _GET_RECENT_RECIPES;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Recipe> list =
        parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
        return list;
      } else {
        return List<Recipe>();
      }
    } catch (e) {
      return List<Recipe>();
    }
  }

  static Future<Map<String, dynamic>> getSSOAuth(Map<String, dynamic> map,
      {String idkey = 'user_id'}) async {
    var profile = await SsoStorage.getUserProfile();
    var user_name = profile['username'];
    var session_token = profile['session_token'];
    var user_id = profile['user_id'].toString();
    map['session_token'] = session_token;
    map["username"] = user_name;
    map[idkey] = user_id;
    return map;
    /*  SsoStorage.getUserProfile().then((profile) {
      //print(profile);

    });*/
  }

  // Get recent recipes from the database limited to 10
  static Future<List<Recipe>> getRecentRecipesWithLimit() async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_RECENT_RECIPES;
      map['limit'] = '10';
      map = await getSSOAuth(map);
      //map["user_id"] = "17b75be0-cb56-11ea-b054-5bc604dae451";
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Recipe> list =
        parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
        return list;
      } else {
        return List<Recipe>();
      }
    } catch (e) {
      print(e);
      return List<Recipe>();
    }
  }

  // Get all recipes of a category from the database
  static Future<List<Recipe>> getRecipeByCategory(String id) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_RECIPE_BY_CATEGORY;
      map['category_id'] = id;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Recipe> list =
        parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
        return list;
      } else {
        return List<Recipe>();
      }
    } catch (e) {
      return List<Recipe>();
    }
  }

  static Future<List<Recipe>> getRecipeByRecipeID(String id) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_ALL_RECIPES;
      map['recipe_id'] = id;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Recipe> list =
        parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
        return list;
      } else {
        return List<Recipe>();
      }
    } catch (e) {
      return List<Recipe>();
    }
  }

  // Get all recipes of a user from the database
  static Future<List<Recipe>> getRecipesByUser(String id) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_RECIPE_BY_USER;
      map['user_id'] = id;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Recipe> list =
        parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
        return list;
      } else {
        return List<Recipe>();
      }
    } catch (e) {
      return List<Recipe>();
    }
  }

  // Get all recipes of a cuisine from the database
  static Future<List<Recipe>> getRecipeByCuisine(String id) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_RECIPE_BY_CUISINE;
      map['cuisine_id'] = id;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Recipe> list =
        parsed.map<Recipe>((json) => Recipe.fromJson(json)).toList();
        return list;
      } else {
        return List<Recipe>();
      }
    } catch (e) {
      return List<Recipe>();
    }
  }

  // Add user follow to a recipe in the database
  static Future<bool> addUserFollow(String userId, String followerId) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _ADD_USER_FOLLOW;
      //map['user_id'] = userId;
      map['follower_id'] = followerId;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        var data = json.decode(response.body);
        return data['following'];
      } else {
        print("response.error");
        print(response.statusCode);
        var data = json.decode(response.body);
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  // Get user rate to a recipe in the database
  static Future<bool> addUserRate(
      String userId, double rate, String recipeId) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _ADD_USER_RATE;
      //map['user_id'] = userId;
      map['recipe_id'] = recipeId;
      map['rate'] = rate.toString();
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        var data = json.decode(response.body);
        return data['rated'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Get user following number from the database
  static Future<int> getNumberOfFollowing(String userId) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_COUNT_FOLLOWING;
      //map['user_id'] = userId;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        var data = json.decode(response.body);
        int count = data['count'];
        return count;
      } else {
        return 0;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Get user followers number from the database
  static Future<int> getNumberOfFollowers(String userId) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_COUNT_FOLLOWERS;
      //map['user_id'] = userId;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        var data = json.decode(response.body);
        int count = data['count'];
        return count;
      } else {
        return 0;
      }
    } catch (e) {
      return null;
    }
  }

  // Check if using is following another user
  static Future<bool> checkIfUserIsFollowing(
      String userId, String followerId) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _CHECK_IF_USER_IS_FOLLOWING;
      //map['user_id'] = userId;
      map['follower_id'] = followerId;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        var data = json.decode(response.body);
        return data['following'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Add device token to the database
  static Future<String> addDevice(String token) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _SET_DEVICE_TOKEN;
      map['token'] = token;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        return response.body;
      } else {
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        return "error";
      }
    } catch (e) {
      return null;
    }
  }

  // Get comments of a specific recipe from the database
  static Future<List<Comment>> getRecipeComments(String recipeid) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_RECIPE_COMMENTS;
      map['recipe_id'] = recipeid;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<Comment> list =
        parsed.map<Comment>((json) => Comment.fromJson(json)).toList();
        return list;
      } else {
        return List<Comment>();
      }
    } catch (e) {
      return List<Comment>();
    }
  }

  // Get user followers from the database
  static Future<List<User>> getUserFollowers(String userid) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_USER_FOLLOWERS;
      //map['user_id'] = userid;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<User> list =
        parsed.map<User>((json) => User.fromJson(json)).toList();
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>();
    }
  }

  // Get user following from the database
  static Future<List<User>> getUserFollowing(String userid) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _GET_USER_FOLLOWING;
      //map['user_id'] = userid;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http
          .post(API, body: map, headers: {"Accept": "application/json"});
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        List<User> list =
        parsed.map<User>((json) => User.fromJson(json)).toList();
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>();
    }
  }

  // Add recipe comment of a user in the database
  static Future<String> addRecipeComment(
      String userid, String recipeid, String comment) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _ADD_USER_COMMENT;
      map['id'] = userid;
      map['recipe_id'] = recipeid;
      map['comment'] = comment;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      print(map);
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        return response.body;
      } else {
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        return "error";
      }
    } catch (e) {
      return null;
    }
  }

  // Update recipe number of views in the database
  static Future<String> updateRecipeViews(String id) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _UPDATE_RECIPE_VIEWS;
      map['recipe_id'] = id;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        return response.body;
      } else {
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        return "error";
      }
    } catch (e) {
      return null;
    }
  }

  // Update recipe number of likes in the database
  static Future<String> updateRecipeLikes(String id, String operation) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _UPDATE_RECIPE_LIKES;
      map['recipe_id'] = id;
      map['operation'] = operation;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        return response.body;
      } else {
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        return "error";
      }
    } catch (e) {
      return null;
    }
  }

  // Delete user image from the database
  static Future<String> deleteUserImage(String id) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _DELETE_USER_IMAGE;
      map['id'] = id;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        return response.body;
      } else {
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        return "error";
      }
    } catch (e) {
      return null;
    }
  }

  // Delete recipe comment of a specific user from the database
  static Future<String> deleteUserComment(String id) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _DELETE_USER_COMMENT;
      map['comment_id'] = id;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        return response.body;
      } else {
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        return "error";
      }
    } catch (e) {
      return null;
    }
  }

  // Delete user recipe from the database
  static Future<String> deleteUserRecipe(String id) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _DELETE_USER_RECIPE;
      map['recipe_id'] = id;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        return response.body;
      } else {
        print("response error");
        print("reponse code : " + response.statusCode.toString());
        print("reponse error : " + response.body.toString());
        return "error";
      }
    } catch (e) {
      return null;
    }
  }

  // Reset user password in the database
  static Future<String> resetPassword(String email) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _RESET_PASSWORD;
      map['email'] = email;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        var data = json.decode(response.body);
        return data['message'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Change user password in the database
  static Future<String> changePassword(
      String userId, String oldPassword, newPassword) async {
    try {
      var map = Map<String, dynamic>();
      map = await getSSOAuth(map);
      map['action'] = _CHANGE_PASSWORD;
      //map['user_id'] = userId;
      map['oldPassword'] = oldPassword;
      map['newPassword'] = newPassword;
      print("API Call-----------------");
      print("API Name " + API);
      print("Parameter ");
      print(map);
      print("-----------------------End API");
      final response = await http.post(API, body: map);
      print("response");
      print(response);
      if (200 == response.statusCode) {
        print("response.body");
        print(response.body);
        var data = json.decode(response.body);
        return data['message'];
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }
}
