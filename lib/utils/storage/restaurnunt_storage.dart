import 'dart:convert';

import 'package:common_config/utils/storage/storage.dart';

class RestaurantStorage {
  static Future<bool> getRestaurantProductInfoStatus() async {
    var status = await LocalStorage.getStorage().getItem("restaurnat_intro");
    return Future.value(status == null
        ? false
        : status.toLowerCase() == 'false' ? false : true);
  }

  static void setRestaurantProductInfoStatus(bool status) {
    LocalStorage.getStorage().setItem("restaurnat_intro", status.toString());
  }
}

class TifinStorage {
  static Future<bool> getTifinProductInfoStatus() async {
    var status = await LocalStorage.getStorage().getItem("tifin_intro");
    return Future.value(status == null
        ? false
        : status.toLowerCase() == 'false' ? false : true);
  }

  static void setTifinProductInfoStatus(bool status) {
    LocalStorage.getStorage().setItem("tifin_intro", status.toString());
  }
}

class GroceryStorage {
  static Future<bool> getGroceryProductInfoStatus() async {
    var status = await LocalStorage.getStorage().getItem("grocery_intro");
    return Future.value(status == null
        ? false
        : status.toLowerCase() == 'false' ? false : true);
  }

  static void setGroceryProductInfoStatus(bool status) {
    LocalStorage.getStorage().setItem("grocery_intro", status.toString());
  }

  static void setGroceryCartProducts(cartList) {
    LocalStorage.getStorage().setItem("cartList", jsonEncode(cartList));
  }

  static Future<String> getGroceryCartProducts() async {
    var cartProducts = LocalStorage.getStorage().getItem("cartList");
    return Future.value(cartProducts == null ? [] : cartProducts);
  }
}

class RecipeStorage {
  static Future<bool> getGroceryProductInfoStatus() async {
    var status = await LocalStorage.getStorage().getItem("recipe_intro");
    return Future.value(status == null
        ? false
        : status.toLowerCase() == 'false' ? false : true);
  }

  static void setGroceryProductInfoStatus(bool status) {
    LocalStorage.getStorage().setItem("recipe_intro", status.toString());
  }
}
