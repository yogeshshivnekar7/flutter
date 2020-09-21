import 'dart:collection';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_module.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class OnlineOrderPresenter {
  OnlineOrderView view;

  OnlineOrderModel model;

  OnlineOrderPresenter(OnlineOrderView param0) {
    this.view = param0;
    model = new OnlineOrderModel();
  }

  void getCompanyApi(String compId,
      {String callingType = "defalt_company_api"}) {
    HashMap<String, String> hashMap = new HashMap();
    hashMap["api_key"] = Environment().getCurrentConfig().ssoApiKey;
    hashMap["fields"] = "units";
    model.getCompanyApi(view.success, view.error, view.failure, compId, hashMap,
        callingType: callingType);
  }

  void getCompanyDetail(String compId,
      {String callingType = "defalt_company_api",
      String latitude,
      String longitude}) {
    HashMap<String, String> hashMap = new HashMap();
    hashMap["api_key"] = Environment().getCurrentConfig().ssoApiKey;
    hashMap["fields"] = "details";
    if (latitude != null && longitude != null) {
      hashMap["latitude"] = latitude;
      hashMap["longitude"] = longitude;
    }
    model.getCompanyApi(view.success, view.error, view.failure, compId, hashMap,
        callingType: callingType);
  }

  void getStoreTiming(var details, String callingType) {
    String url = details["api_end_point"];
    HashMap<String, String> hashMap = new HashMap();
    hashMap["api_key"] = details["web_api_key"];

    model.getStoreTiming(
        view.success, view.error, view.failure, url, hashMap, callingType);
  }

  void getDeliveryRange(String callingType) {
    SsoStorage.getCompanyApi("MONEY").then((details) {
      String url = details["api_end_point"];
      HashMap<String, String> hashMap = new HashMap();
      hashMap["api_key"] = details["web_api_key"];

      model.getStoreTiming(
          view.success, view.error, view.failure, url, hashMap, callingType);
    });
  }

  void orderContinue(
      List items, var userProfie, var address, String callingType) {
    SsoStorage.getCompanyApi("MONEY").then((apiDatta) {
      print("money Api ------------- $apiDatta");
      HashMap<String, String> hashMap =
      preparePostData(apiDatta, items, userProfie, address);
      print("prepared data-------------- $hashMap");
      String url = apiDatta["api_end_point"];
      model.postOrder(
          view.success, view.error, view.failure, url, hashMap, callingType);
    });
  }

  HashMap<String, String> preparePostData(apiDatta, List items, userProfie,
      address) {
    HashMap<String, String> hashMap = new HashMap();

    hashMap["api_key"] = apiDatta["web_api_key"];
    hashMap["session_token"] = userProfie['session_token'];
    hashMap["username"] = userProfie["username"];
    hashMap["customer_name"] = AppUtils.getFullName(userProfie);
    hashMap["auth_id"] = userProfie["user_id"].toString();
    hashMap["customer_contact_number"] = userProfie["mobile"];
    hashMap["delivery_type"] = "delivery";
    hashMap["delivery_status"] = "pending";
    hashMap["status"] = "requested";
    hashMap["delivery_address"] = address["address"];
    hashMap["delivery_country"] = address["country"];
    hashMap["delivery_state"] = address["state"];
    hashMap["delivery_city"] = address["city"];
    if (address["landmark"] != null &&
        address["landmark"]
            .toString()
            .length > 0) {
      hashMap["delivery_landmark"] = address["landmark"];
    }
//      hashMap["delivery_landmark"]=address["landmark"]==null ||address["landmark"].toString().length>0?address["locality"]:address["landmark"];
    hashMap["delivery_postal_code"] = address["zipcode"];
//      hashMap["delivery_date"]="";
//      hashMap["delivery_charges"]="";
    hashMap["send_mail"] = "yes";
//      hashMap["payment_mode"]="";
    hashMap["latitude"] = address["latitude"];
    hashMap["longitude"] = address["longitude"];
//      hashMap["slot_start_time"]="";
//      hashMap["slot_end_time"]="";
    for (int i = 0; i < items.length; i++) {
      String itemKey = "items[" + i.toString() + "][item]";
      String itemPrice = "items[" + i.toString() + "][price]";
      String itemQuantity = "items[" + i.toString() + "][quantity]";
      hashMap[itemKey] = items[i]["item"];
      hashMap[itemQuantity] = items[i]["quantity"].toString();
      hashMap[itemPrice] = "1";
    }
    return hashMap;
  }

  void getOrderSummary(var userProfile, String orderId, String callingType) {
    SsoStorage.getCompanyApi("MONEY").then((apiDatta) {
      print("money Api ------------- $apiDatta");
      HashMap<String, String> hashMap = new HashMap();
      hashMap["api_key"] = apiDatta["web_api_key"];
      hashMap["session_token"] = userProfile["session_token"];
      hashMap["username"] = userProfile["username"];
      hashMap["fields"] = userProfile["track_payments"];
      String url = apiDatta["api_end_point"];

      model.getOrderSummary(
          view.success,
          view.error,
          view.failure,
          orderId,
          url,
          hashMap,
          callingType);
    });
  }

  void getOldOrder(var userProfile, String callingType, String page) {
    SsoStorage.getCompanyApi("MONEY").then((apiDatta) {
      print("money Api ------------- $apiDatta");
      HashMap<String, String> hashMap = new HashMap();
      hashMap["api_key"] = apiDatta["web_api_key"];
      hashMap["session_token"] = userProfile["session_token"];
      hashMap["username"] = userProfile["username"];
      hashMap["per_page"] = "10";
      hashMap["order_by"] = "id,desc";
      hashMap["page"] = page;
      String url = apiDatta["api_end_point"];

      model.getOldOrder(
          view.success, view.error, view.failure, url, hashMap, callingType);
    });
  }

  void getAllOrders(var userProfile, String callingType, String page,
      {String companyId = null}) {
    HashMap<String, String> hashMap = new HashMap();
//    hashMap["api_key"] = apiDatta["web_api_key"];
//    hashMap["session_token"] = userProfile["session_token"];
//    hashMap["customer_contact_number"] = userProfile["username"];//"919833598235";//
    hashMap["per_page"] = "10";
//    hashMap["order_by"] = "id,desc";
    hashMap["page"] = page;
    if (companyId != null) {
      hashMap["company_id"] = companyId;
    }
    hashMap["auth_id"] = userProfile["user_id"].toString();
//    String url = apiDatta["api_end_point"];

    model.getAllOrders(
        view.success, view.error, view.failure, hashMap, callingType);
  }

  void getAllCartOrders(var userProfile, String callingType,
      {String page, String companyId = null}) {
    HashMap<String, String> hashMap = new HashMap();
//    hashMap["api_key"] = apiDatta["web_api_key"];
//    hashMap["session_token"] = userProfile["session_token"];
//    hashMap["customer_contact_number"] = userProfile["username"];//"919833598235";//
    //  hashMap["per_page"] = "10";
//    hashMap["order_by"] = "id,desc";
    //  hashMap["page"] = page;
    if (companyId != null) {
      hashMap["company_id"] = companyId;
    }
    // hashMap["auth_id"] = userProfile["user_id"].toString();
//    String url = apiDatta["api_end_point"];

    model.getAllCartOrders(view.success, view.error, view.failure, hashMap,
        callingType, userProfile["user_id"].toString());
  }

  void cancelledOrder(String orderId,
      userProfile,
      String callingType,) {
    SsoStorage.getCompanyApi("MONEY").then((apiDatta) {
      print("money Api ------------- $apiDatta");
      HashMap<String, String> hashMap = new HashMap();
      hashMap["api_key"] = apiDatta["web_api_key"];
      hashMap["status"] = "cancelled";
      hashMap["delivery_status"] = "pending";
      hashMap["session_token"] = userProfile["session_token"];
      hashMap["username"] = userProfile["username"];
      hashMap["customer_name"] = AppUtils.getFullName(userProfile);
      hashMap["auth_id"] = userProfile["user_id"].toString();
      hashMap["customer_contact_number"] = userProfile["mobile"];
//      hashMap["per_page"] = "10";
//      hashMap["order_by"] = "id,desc";
//      hashMap["page"] = page;
      String url = apiDatta["api_end_point"];

      model.orderUpdate(
          view.success,
          view.error,
          view.failure,
          url,
          orderId,
          hashMap,
          callingType);
    });
  }

  void placeOrder(userProfile, String orderId, orderDetails,
      String callinType) {
    SsoStorage.getCompanyApi("MONEY").then((apiDatta) {
      HashMap<String, String> hashMap = preparOrderData(
          apiDatta, orderDetails["reviewed_order"], userProfile);
      String url = apiDatta["api_end_point"];
      model.orderUpdate(
          view.success,
          view.error,
          view.failure,
          url,
          orderId,
          hashMap,
          callinType);
    });
  }
  void postNumberMasking(String to,String from,String company_id,String tag,String callingType){
      SsoStorage.getUserProfile().then((value)  {
      HashMap<String, String> hashMap = new HashMap();
    hashMap["from"]=from;
    hashMap["to"]=to;
    hashMap["company_id"]=company_id;
    hashMap["app_id"]=Environment.config.getOneAppId;
    hashMap["user_id"]=value["user_id"].toString();
    hashMap["tags"]=tag;
          model.postNumberMasking(
        view.success,
        view.failure,
        view.error,
        callingType,
        hashMap,        
      );
      print("values passing with postnumbermasking:..............."+value.toString());
      });

  }
  HashMap<String, String> preparOrderData(apiDatta, List items, userProfie) {
    HashMap<String, String> hashMap = new HashMap();

    hashMap["api_key"] = apiDatta["web_api_key"];
    hashMap["session_token"] = userProfie['session_token'];
    hashMap["username"] = userProfie["username"];
    hashMap["customer_name"] = AppUtils.getFullName(userProfie);
    hashMap["auth_id"] = userProfie["user_id"].toString();
    hashMap["customer_contact_number"] = userProfie["mobile"];
    hashMap["delivery_type"] = "delivery";
    hashMap["delivery_status"] = "pending";
    hashMap["status"] = "unconfirmed";
//    hashMap["delivery_address"] = address["address"];
//    hashMap["delivery_country"] = address["country"];
//    hashMap["delivery_state"] = address["state"];
//    hashMap["delivery_city"] = address["city"];
//    if (address["landmark"] != null &&
//        address["landmark"]
//            .toString()
//            .length > 0) {
//      hashMap["delivery_landmark"] = address["landmark"];
//    }
//
//    hashMap["delivery_postal_code"] = address["zipcode"];
//    hashMap["send_mail"] = "yes";
//
//    hashMap["latitude"] = address["latitude"];
//    hashMap["longitude"] = address["longitude"];
    for (int i = 0; i < items.length; i++) {
      String itemKey = "items[" + i.toString() + "][item]";
      String itemPrice = "items[" + i.toString() + "][price]";
      String itemQuantity = "items[" + i.toString() + "][quantity]";
      if (items[i]["isavailable"] && !items[i]["cancelled"]) {
        hashMap[itemKey] = items[i]["name"];
        hashMap[itemQuantity] = items[i]["qty"].toString();
        hashMap[itemPrice] = items[i]["amount"].toString();
      }
    }
    return hashMap;
  }

  void deleteItem(item, callingType, userProfile) {
    String orderId = item["order_id"];

    SsoStorage.getCompanyApi("MONEY").then((apiDatta) {
      HashMap<String, String> hashMap = new HashMap();
//      String itemId =item["id"];
      hashMap["items[0]"] = item["id"];
      hashMap["id"] = orderId;
      hashMap["api_key"] = apiDatta["web_api_key"];
      String url = apiDatta["api_end_point"];

      hashMap["session_token"] = userProfile['session_token'];
      hashMap["username"] = userProfile["username"];
      hashMap["auth_id"] = userProfile["user_id"].toString();
      model.orderUpdate(
          view.success,
          view.error,
          view.failure,
          url,
          orderId,
          hashMap,
          callingType,
          delete: true);
    });
  }

  void cancelOrder(order_id, callingType, userProfile) {
    String orderId = order_id;
    SsoStorage.getCompanyApi("MONEY").then((apiDatta) {
      HashMap<String, String> hashMap = new HashMap();
//      String itemId =item["id"];
      hashMap["order_id"] = orderId;
      hashMap["api_key"] = apiDatta["web_api_key"];
      String url = apiDatta["api_end_point"] + /*apiDatta["api_version"]*/'/v1';
      hashMap["session_token"] = userProfile['session_token'];
      hashMap["username"] = userProfile["username"];
      hashMap["auth_id"] = userProfile["user_id"].toString();
      hashMap["status"] = "cancelled".toString();
      hashMap["source"] = "oneapp".toString();
      model.cancelOrder(
          view.success, view.error, view.failure, url, hashMap, callingType);
    });
  }

  void getOrderDetails(orderData, String callingType) {
    String companyId = orderData["company_id"].toString();
    String orderNo = orderData["order_no"].toString();
    model.getOrderDetails(view.success, view.error, view.failure, companyId,
        orderNo, callingType);
  }
}
