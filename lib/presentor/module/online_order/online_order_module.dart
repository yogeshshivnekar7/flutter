import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';

class OnlineOrderModel {
  void getCompanyApi(onSuccess, onError, onFailure, compId, HashMap hashMap,
      {callingType}) {
    NetworkHandler a = new NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    if (callingType.toString() == "company_details") {
      Network network = SSOAPIHandler.getCompanyDetail(a, compId, hashMap);
      network.excute();
    } else {
      Network network = SSOAPIHandler.getCompanyApi(a, compId, hashMap);
      network.excute();
    }
  }

  void getStoreTiming(success, error, failure, String url,
      HashMap<String, String> hashMap, String callingType) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network = SSOAPIHandler.getTiming(a, url, hashMap);
    network.excute();
  }

  void postOrder(success, error, failure, String url,
      HashMap<String, String> hashMap, callingType) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network = SSOAPIHandler.postOrder(a, url, hashMap);
    network.excute();
  }
  void postNumberMasking(success,failure,error,callingType,HashMap<String,String> dataFOrSend){
       String url= Environment.config.nodeUrl + "api/v1/exotel/intercom-call-log";
      NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network = SSOAPIHandler.postNumberMasking(dataFOrSend,a);
    network.excute();
  }
  void cancelOrder(success, error, failure, String url,
      HashMap<String, String> hashMap, callingType) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network = SSOAPIHandler.cancelOrder(a, url, hashMap);
    network.excute();
  }

  void getOrderSummary(success, error, failure, String orderId, String url,
      HashMap<String, String> hashMap, String callingType) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network = SSOAPIHandler.getOrderSummary(a, url, orderId, hashMap);
    network.excute();
  }

  void getOldOrder(success, error, failure, String url,
      HashMap<String, String> hashMap, String callingType) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network = SSOAPIHandler.getOldOrder(a, url, hashMap);
    network.excute();
  }

  void orderUpdate(success, error, failure, String url, String orderId,
      HashMap<String, String> hashMap, String callingType,
      {bool delete = false}) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network =
    SSOAPIHandler.orderUpdate(a, url, orderId, hashMap, deleteItem: delete);
    network.excute();
  }

  void delete(success, error, failure, String url, String orderId,
      String itemId, HashMap<String, String> hashMap, callingType) {}

  String errorDecoder(userFalure) {
    return AppUtils.errorDecoder(userFalure);
  }

  void getAllOrders(success, error, failure, HashMap<String, String> hashMap,
      String callingType) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network = SSOAPIHandler.getAllOrders(a, hashMap);
    network.excute();
  }

  void getAllCartOrders(success, error, failure,
      HashMap<String, String> hashMap, String callingType, String user_id,
      {String company_id}) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network =
        SSOAPIHandler.getAllCartOrders(a, user_id, company_id, hashMap);
    network.excute();
  }

  void getOrderDetails(success, error, failure, String companyId,
      String orderNo, String callingType) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network = SSOAPIHandler.getOrderDetails(a, companyId, orderNo);
    network.excute();
  }
//
//  void placeOrder( success,  error,  failure, String url, String orderId, HashMap<String, String> hashMap, String callingType) {
//    NetworkHandler a = new NetworkHandler((s) {
//      success(jsonDecode(s.toString()), callingType: callingType);
//    }, (f) {
//      var userFalure = jsonDecode(f);
//      failure(userFalure, callingType: callingType);
//    }, (e) {
//      error(e, callingType: callingType);
//    });
//    Network network = SSOAPIHandler.placeOrder(
//        a, url,orderId, hashMap);
//    network.excute();
//  }
  void addProductToCart(
      {success, error, String url, failure, callingType, hashMap}) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()), callingType: callingType);
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(errorDecoder(userFalure), callingType: callingType);
    }, (e) {
      error(e, callingType: callingType);
    });
    Network network = SSOAPIHandler.addProductToCart(a, url, hashMap);
    network.excute();
  }
}
