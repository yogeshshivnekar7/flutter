import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/restaurant/restaurant_model.dart';
import 'package:sso_futurescape/presentor/module/restaurant/restaurant_view.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class RestaurantPresenter extends RestaurantModelResponse {
  RestaurantView _restaurantView;
  RestaurantModel _model;

  RestaurantPresenter(RestaurantView restaurantView) {
    _restaurantView = restaurantView;
    _model = new RestaurantModel();
  }

  void getRestaurant({String search,
    String business_category,
    String industry_type,
    String lat,
    String long,
    String distace,
    bool isLastRequest,
    bool isPaginationRequired = false, String page}) {
    print(business_category);
    _model.getRestaurant(_restaurantView.onRestaurantFound,
        _restaurantView.onError, _restaurantView.onFailure,
        search: search,
        lat: lat,
        long: long,
        isLastRequest: isLastRequest,
        industry_type: industry_type,
        isPaginationRequired: isPaginationRequired,
        page: page);
  }

  void getTiffin({String search,
    String business_category,
    String industry_type,
    String lat,
    String long,
    String distace = "5",
    bool isLastRequest}) {
    print(business_category);
    _model.getTiffin(_restaurantView.onRestaurantFound, _restaurantView.onError,
        _restaurantView.onFailure,
        search: search,
        business_category: business_category,
        industry_type: industry_type,
        long: long,
        lat: lat,
        distace: distace,
        isLastRequest: isLastRequest);
  }

  void getGrocery({String search,
    String business_category,
    String industry_type,
    String lat,
    String long,
    String distace = "5",
    bool isLastRequest}) {
    print(business_category);
    HashMap<String, String> hashMap = HashMap();
    hashMap["api_key"] = Environment()
        .getCurrentConfig()
        .ssoApiKey;
    String sBusiness_category = "";
    if (business_category != null && !business_category.isEmpty) {
      sBusiness_category += ",business_category:$business_category";
    }
    if (industry_type == null || industry_type.isEmpty) {
      industry_type = 'retail';
    }
    String filter = "type:company,";
    hashMap["filter"] = filter +
        "industry_type:$industry_type,discovery_enabled:yes,status:active" /*+ sBusiness_category*/ +
        "&fields=details";
    if (search != null && !search.isEmpty) {
      hashMap["search"] = search;
    }
    _model.getGrocery(_restaurantView.onRestaurantFound,
        _restaurantView.onError, _restaurantView.onFailure, hashMap,
        lat: lat, long: long, distace: distace, isLastRequest: isLastRequest);
  }

  void getRestaurantURL(String company_name, String company_id) {
    print("Tiffine company id$company_id");
    _model.getRestaurantURL(_restaurantView.onRestaurantURLFound,
        _restaurantView.onError, _restaurantView.onFailure, company_id,
        company_name: company_name);
  }

  void getRestaurantDetails(int restaurantId) {
    _model.getRetaurantDetails(restaurantId, this);
  }

  @override
  void onError(String error) {
    // TODO: implement onError
    _restaurantView.onError(error);
  }

  @override
  void onFailure(String failure) {
    // TODO: implement onFailure
    _restaurantView.onFailure(failure);
  }

  @override
  void onLoadingStart() {
    // TODO: implement onLoadingStart
  }

  @override
  void onSuccess(String success) {
    _restaurantView.onRestaurantFound(success);
    // TODO: implement onSuccess
  }

  void deleteAddress(tag) {
    AddressModel addressModel = new AddressModel();
    addressModel.deleteAddress(tag, _restaurantView.addressDeleted,
        _restaurantView.addressDeletionFailed);
  }
}

class AddressModel {
  void deleteAddress(String address_tag, successFun, failedFun) {
    HashMap<String, String> map = new HashMap();
    void success(String response) {
      print("response - " + response);
      successFun(jsonDecode(response));
    }

    void error(String error) {
      print("error" + error);
      failedFun(error);
    }

    void failure(String failure) {
      print("failure" + failure);
      failedFun(failure);
    }

    //print("handlerhandlerhandler");
    NetworkHandler handler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});

    SsoStorage.getToken().then((token) {
      var tokensss;
      /*  if (token != null) {*/
      var access = jsonDecode(token);
      tokensss = access["access_token"];
      /*} else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      print(tokensss);
      map["access_token"] = tokensss;
      map["address_tag"] = address_tag;
      map["_method"] = "delete";
      Network network = SSOAPIHandler.deleteUserAddress(handler, map);
      network.excute();
      print("excute");
    }).catchError((e) {
      print(e);
    });
  }
}
