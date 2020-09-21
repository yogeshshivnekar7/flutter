import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/searchresults/searchresult_model.dart';
import 'package:sso_futurescape/presentor/module/searchresults/searchresult_view.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';

class SearchResultPresenter {
  SearchResultView view;

  SearchResultModel model;

  SearchResultPresenter(SearchResultView param0) {
    this.view = param0;
    model = new SearchResultModel();
  }

  void getSearchResults(
      searchText, BusinessAppMode businessAppMode, Map address,
      {page}) {
    print("in presenter");
    SearchResultModel model = new SearchResultModel();
    model.getSearchResults(searchText, businessAppMode, address, view,
        page: page);
  }

  void addProductToCart({cartProducts, userProfile, moneyApiData, company_id}) {
    print(moneyApiData);
    if (userProfile != null) {
      HashMap<String, String> hashMap = new HashMap();
      // String url = moneyApiData["api_end_point"] + '/v1/';
      // hashMap["api_key"] = moneyApiData["web_api_key"];
      String moneyUrl = Environment().getCurrentConfig().moneyUrl;

      hashMap["api_key"] = Environment().getCurrentConfig().serverApiKey;
      hashMap["session_token"] = userProfile['session_token'];
      // hashMap["username"] = userProfile["username"];
      hashMap["user_id"] = userProfile["user_id"].toString();
      hashMap["company_id"] = company_id.toString();

      hashMap["value"] = cartProducts == null ? null : jsonEncode(cartProducts);

      model.addProductToCart(view: view, hashMap: hashMap, url: moneyUrl);
    }
  }
// void getCompanyApi(String compId,product,
//     {String callingType = "defalt_company_api"}) {
//   HashMap<String, String> hashMap = new HashMap();
//   hashMap["api_key"] = Environment().getCurrentConfig().ssoApiKey;
//   hashMap["fields"] = "units";
//   model.getCompanyApi((success){view.companyDataSuccess(success,product);}, view.error, view.failure, compId, hashMap,
//       callingType: callingType);
// }
}
