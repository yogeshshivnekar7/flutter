import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';

class RestaurantModel {
  RestaurantModelResponse _modelResponse;

  void getRestaurant(onRestaurantFound, onError, onFailure,
      {String search,
        String lat,
        String long,
        String industry_type,
        bool isLastRequest,
        String page = "1",
        String per_page = "10",
        bool isPaginationRequired = false}) {
    NetworkHandler a = new NetworkHandler((s) {
      onRestaurantFound(jsonDecode(s.toString()), isLastRequest: isLastRequest);
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      print(e);
      onError(e);
    });
    HashMap<String, String> hashMap = HashMap();
    hashMap["api_key"] = Environment()
        .getCurrentConfig()
        .ssoApiKey;
    /* String sBusiness_category = "";
    if (business_category != null && !business_category.isEmpty) {
      sBusiness_category += ",business_category:$business_category";
    }*/
    /* if (industry_type == null || industry_type.isEmpty) {
      industry_type = 'food';
    }*/
    if (isPaginationRequired) {
      hashMap["page"] = page.toString();
      hashMap["per_page"] = per_page.toString();
    }
    if (lat != null) {
      hashMap["latitude"] = lat;
      hashMap["longitude"] = long;
    }
    /* if (distace == null) {
        distace = "20";
      }
      hashMap["distance"] = distace;*/
    if (industry_type == 'tiffin' || industry_type == "resto") {
      hashMap["filter"] = "type:company," +
          "industry_type:food,discovery_enabled:yes,status:active" /*+ sBusiness_category */ +
          "&fields=details";
    } else if (industry_type == 'wines') {
      hashMap["filter"] = "type:company," +
          "industry_type:retail,discovery_enabled:yes,status:active,business_category:wine shop" /*+ sBusiness_category */ +
          "&fields=details";
    } else {
      hashMap["filter"] = "type:company," +
          "industry_type:retail,discovery_enabled:yes,status:active" /*+ sBusiness_category */ +
          "&fields=details";
    }
    if (search != null && !search.isEmpty) {
      hashMap["search"] = search;
    }
    print(pragma);
    Network network = SSOAPIHandler.getRestaurant(a, hashMap, industry_type);
    network.excute();
  }

  void getTiffin(onRestaurantFound, onError, onFailure,
      {String search,
        String business_category,
        String industry_type,
        String lat,
        String long,
        String distace = "20",
        isLastRequest}) {
    NetworkHandler a = new NetworkHandler((s) {
      onRestaurantFound(jsonDecode(s.toString()), isLastRequest: isLastRequest);
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.getTiffin(
      a,
      search: search,
      business_category: business_category,
      industry_type: industry_type,
      lat: lat,
      long: long,
      distace: distace,
    );
    network.excute();
  }

  void getGrocery(onRestaurantFound, onError, onFailure, HashMap hashMap,
      {String lat, String long, String distace = "20", isLastRequest}) {
    NetworkHandler a = new NetworkHandler((s) {
      onRestaurantFound(jsonDecode(s.toString()), isLastRequest: isLastRequest);
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.getGrocery(hashMap, a,
        lat: lat, long: long, distace: distace);
    network.excute();
  }

  void getRestaurantURL(onRestaurantURLFound, onError, onFailure,
      String company_id,
      {String company_name}) {
    NetworkHandler a = new NetworkHandler((s) {
      onRestaurantURLFound(jsonDecode(s.toString()),
          company_name: company_name);
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = SSOAPIHandler.getRestaurantURL(a, company_id);
    network.excute();
  }

  void getRetaurantDetails(int restaurantId,
      RestaurantModelResponse modelResponse) {
    /*void success(String response) {
      print("response - " + response);
      modelResponse.onSuccess(response);
    }

    void error(String error) {
      print("error" + error);
      modelResponse.onError(error);
    }

    void failure(String failure) {
      print("failure" + failure);
      modelResponse.onError(failure);
    }

    NetworkHandler handler = new NetworkHandler(
            (response) =>
        {
          success(response)
        },
            (response) =>
        {
          failure(response)
        },
            (response) =>
        {
          error(response)
        });

    SsoStorage.getToken().then((token) {
      var tokensss;
      if (token != null) {
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      } else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }
      print(tokensss);
      HashMap<String, String> params = new HashMap();
      params["access_token"] = tokensss;
      Network network = SSOAPIHandler.getStatesWrtCountry(
          handler, params, country_id);
      network.excute();
      print("excute");
    }).catchError((e) {
      print(e);
    });*/
  }

/*void searchRestaurant(
      String search, onRestaurantFound, onError, onFailure, clearList) {
    if (search.length < 3) {
      clearList();
      return;
    }
    HashMap<String, String> hashMap = new HashMap();
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["search"] = search;
    Logger.log("api - " + currentConfig.ssoApiKey + "  search -" + search);

    NetworkHandler a = new NetworkHandler((s) {
//      print(s.runtimeType.toString());

      //var jsonDecode2 = jsonDecode(s);
//      Logger.log("JSON_------------------ "+jsonDecode2);
      onRestaurantFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(jsonDecode(e));
    });
    Network network = SSOAPIHandler.getSearchSocieties(a, hashMap);
    network.excute();
  }*/
}

abstract class RestaurantModelResponse {
  void onSuccess(String success);

  void onLoadingStart();

  void onFailure(String failure);

  void onError(String error);
}
