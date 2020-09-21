import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/searchresults/searchresult_view.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';

class SearchResultModel {
  void getSearchResults(searchText, BusinessAppMode businessAppMode,
      Map address, SearchResultView view,
      {page}) {
    print("before calling api");
    NetworkHandler a = new NetworkHandler((s) {
      view.success(jsonDecode(s.toString())['data']);
    }, (f) {
      // var userFailure = jsonDecode(f);
      view.failure(f);
    }, (e) {
      view.error(e);
    });
    print(address);
    String industry_type;
    HashMap<String, String> hmap = new HashMap();
    if (businessAppMode == BusinessAppMode.RESTAURANT) {
      industry_type = "resto";
    } else if (businessAppMode == BusinessAppMode.TIFFIN) {
      industry_type = "tiffin";
    } else if (businessAppMode == BusinessAppMode.DAILY_ESSENTIALS) {
      industry_type = "retails";
    } else if (businessAppMode == BusinessAppMode.GROCERY) {
      industry_type = "retails";
    } else if (businessAppMode == BusinessAppMode.WINESHOP) {
      industry_type = "wines";
    }
    hmap["api_key"] = Environment().getCurrentConfig().ssoApiKey;
    hmap['search'] = searchText;
    hmap['search_ctx'] = 'product';
    hmap['business_mode'] = industry_type;
    if (industry_type == 'tiffin' || industry_type == "resto") {
      hmap["filter"] = "" +
          "industry_type:food,discovery_enabled:yes,status:active" /*+ sBusiness_category */ +
          "&fields=details";
    } else if (industry_type == 'wines') {
      hmap["filter"] = "" +
          "industry_type:retail,discovery_enabled:yes,status:active,business_category:wine shop" /*+ sBusiness_category */ +
          "&fields=details";
    } else {
      hmap["filter"] = "" +
          "industry_type:retail,discovery_enabled:yes,status:active" /*+ sBusiness_category */ +
          "&fields=details";
    }
    if (address != null) {
      hmap['latitude'] = address['latitude'];
      hmap['longitude'] = address['longitude'];
    }
    print(hmap);
    Network network = SSOAPIHandler.getSearchResults(a, hmap);
    network.excute();
  }

  void addProductToCart({
    String url,
    hashMap,
    SearchResultView view,
  }) {
    NetworkHandler a = new NetworkHandler((s) {
      print(jsonDecode(s.toString())['data']);
      view.addToCartSuccess(jsonDecode(s.toString())['data']);
    }, (f) {
      view.failure(f);
    }, (e) {
      view.error(e);
    });
    Network network = SSOAPIHandler.addProductToCart(a, url, hashMap);
    network.excute();
  }

  String errorDecoder(userFalure) {
    return AppUtils.errorDecoder(userFalure);
  }
// void getCompanyApi(onSuccess, onError, onFailure, compId, HashMap hashMap,
//     {callingType}) {
//   NetworkHandler a = new NetworkHandler((s) {
//     onSuccess(jsonDecode(s.toString()));
//   }, (f) {
//     var userFalure = jsonDecode(f);
//     onFailure(errorDecoder(userFalure), callingType: callingType);
//   }, (e) {
//     onError(e, callingType: callingType);
//   });
//   if (callingType.toString() == "company_details") {
//     Network network = SSOAPIHandler.getCompanyDetail(a, compId, hashMap);
//     network.excute();
//   } else {
//     Network network = SSOAPIHandler.getCompanyApi(a, compId, hashMap);
//     network.excute();
//   }
// }
}
