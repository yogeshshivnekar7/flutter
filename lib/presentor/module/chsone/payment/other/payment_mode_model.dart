import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/onlinepaid/pay_method_presentor.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/yes_bank.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class PaymentModeModel {
  void getPaymentModeMember(
      onSuccessPaymentMode, onFailedPaymentMode, onErrorPaymentMode) {
    ChsoneStorage.getChsoneAccessInfo().then((access) {
      var accessToken = access["access_token"];
      print(accessToken);
      NetworkHandler networkHandler = new NetworkHandler((s) {
        var paymentModes = jsonDecode(s);
        Map paymentOptions = paymentModes["data"];
        print(paymentOptions);
        var modes = [];
        for (var a in paymentOptions.keys) {
          print(a);
          modes.add(a);
        }
        onSuccessPaymentMode(null, modes);
      }, (s) {
        onFailedPaymentMode();
      }, (s) {
        onErrorPaymentMode();
      });
      CHSONEAPIHandler.getPaymentModes(accessToken, networkHandler).excute();
    });
  }

  void getOnlinePaymentOption(
      String companyId, String unitId, PayMethodPageView payMethodPageView) {
    SsoStorage.getAccessToken().then((access) {
      SsoStorage.getUserProfile().then((profile) {
        HashMap tokenHash = new HashMap<String, String>();
        tokenHash["access_token"] = access;
        tokenHash["session_token"] = profile["session_token"];
        tokenHash["username"] = profile["username"];
        NetworkHandler networkHandler = new NetworkHandler((s) {
          var paymentModes = jsonDecode(s);
          Map paymentOptions = paymentModes["data"];
          //List<List> mainObj = getPaymentMathod("V1",paymentOptions);
          List<List> mainObj = getPaymentMathodV2("V2", paymentOptions);
          payMethodPageView.onSuccessPaymentMode(mainObj[0], mainObj[1]);
        }, (s) {
          print(s);
          payMethodPageView
              .onFailedPaymentMode(AppUtils.errorDecoder(jsonDecode(s)));
        }, (s) {
          print(s);
          payMethodPageView.onErrorPaymentMode(s);
        });
        CHSONEAPIHandler.getOnlinePaymentModes(
            networkHandler, tokenHash, [companyId, unitId]).excute();
      });
    });
  }

  List<List> getPaymentMathod(String varsion,
      Map<dynamic, dynamic> paymentOptions) {
    print(paymentOptions);
    List modes = [];
    List paymentGateWays = [];
    var vpa = {};
    try {
      var gatewayKeysOprions = paymentOptions["gatewaysv1"];
      if (gatewayKeysOprions != null) {
        print(gatewayKeysOprions);
        var ysebank = gatewayKeysOprions;
        String ecollectKey = Environment()
            .getCurrentConfig()
            .ecollectKey;
        if (ysebank[ecollectKey] != null) {
          if (paymentOptions["vpa"] != null &&
              paymentOptions["vpa"].toString().trim() != "") {
            vpa = {
              "img": "images/ecollect.png",
              "name": "E-Collect",
              "selected": false,
              "key": "vpa",
              "value": paymentOptions["vpa"],
              "extra_data": paymentOptions["bank_details"]
            };
            modes.add(vpa);
            // paymentGateWays.add({"gateway":"ecollect"});
          }
        }
        if (ysebank["YESPG"] != null) {
          Map yesBankModes = ysebank["YESPG"];
          print(yesBankModes);
          for (var a in yesBankModes.keys) {
            print(a);
            modes.add(Yesbank.getMode(a, yesBankModes[a], vpa["value"]));
          }
          paymentGateWays.add({
            "img": "images/yes_bank.png",
            "name": "yesbank",
            "gateway": "yespg",
            "selected": false,
          });
        }
        if (ysebank["HDFCPG"] != null) {
          Map yesBankModes = ysebank["HDFCPG"];
          print(yesBankModes);
          for (var a in yesBankModes.keys) {
            print(a);
            modes.add(Yesbank.getMode(a, yesBankModes[a], vpa["value"]));
          }
          paymentGateWays.add({
            "img": "images/hdfc-bank.png",
            "name": "HDFC",
            "gateway": "hdfcpg",
            "selected": false,
          });
        }
        if (ysebank["MOBIKWIKPG"] != null) {
          Map yesBankModes = ysebank["MOBIKWIKPG"];
          print(yesBankModes);
          for (var a in yesBankModes.keys) {
            print(a);
            modes.add(Yesbank.getMode(a, yesBankModes[a], vpa["value"]));
          }
          paymentGateWays.add({
            "img": "images/mobikwik.jpg",
            "name": "MOBIKWIKPG",
            "gateway": "mobikwikpg",
            "selected": false,
          });
        }
      }
    } catch (e) {
      print(e);
    }
    var mainObj = [paymentGateWays, modes];
    return mainObj;
  }

  List<List> getPaymentMathodV2(String varsion,
      Map<dynamic, dynamic> paymentOptions) {
    print(paymentOptions);
    List modes = [];
    List paymentGateWays = [];
    var vpa = {};
    try {
      var gatewayKeysOprions = paymentOptions["gatewaysv1"];
      if (gatewayKeysOprions != null) {
        print(gatewayKeysOprions);
        var ysebank = gatewayKeysOprions;
        String ecollectKey = Environment()
            .getCurrentConfig()
            .ecollectKey;
        if (ysebank[ecollectKey] != null) {
          if (paymentOptions["vpa"] != null &&
              paymentOptions["vpa"].toString().trim() != "") {
            vpa = {
              "img": "images/ecollect.png",
              "name": "E-Collect",
              "selected": false,
              "key": "vpa",
              "value": paymentOptions["vpa"],
              "extra_data": paymentOptions["bank_details"]
            };
            modes.add(vpa);
            // paymentGateWays.add({"gateway":"ecollect"});
          }
        }
        if (ysebank["YESPG"] != null) {
          Map yesBankModes = ysebank["YESPG"];
          print(yesBankModes);
          for (var a in yesBankModes.keys) {
            print(a);
            modes.add(Yesbank.getMode(a, yesBankModes[a], vpa["value"]));
          }
          paymentGateWays.add({
            "img": "images/yes_bank.png",
            "name": "yesbank",
            "gateway": "yespg",
            "selected": false,
            "all_": modes,
          });
        }
        modes = [];
        if (ysebank["HDFCPG"] != null) {
          Map yesBankModes = ysebank["HDFCPG"];
          for (var a in yesBankModes.keys) {
            print(a);
            modes.add(Yesbank.getMode(a, yesBankModes[a], vpa["value"]));
          }
          paymentGateWays.add({
            "img": "images/hdfc-bank.png",
            "name": "HDFC",
            "gateway": "hdfcpg",
            "selected": false,
            "all_": modes
          });
        }


        Map mobikwikMode = getMobikwikPg(ysebank);

        if (mobikwikMode != null) {
          modes = [];
//          Map yesBankModes = ysebank["MOBIKWIKPG"];
          print(mobikwikMode);
          for (var a in mobikwikMode.keys) {
            print(a);
            modes.add(Yesbank.getMode(a, mobikwikMode[a], vpa["value"]));
          }
          paymentGateWays.add({
            "img": "images/mobikwik.png",
            "name": "MOBIKWIK",
            "gateway": "mobikwikpg",
            "selected": false,
            "all_": modes
          });
        }
        /*if (ysebank["MOBIKWIKPG"] != null) {

        }*/
      }
    } catch (e) {
      print(e);
    }
    var mainObj = [paymentGateWays, modes];
    return mainObj;
  }

  void getPaymentCalculation(IPaymentCalculation calculation, amount, mode,
      gateWay) {
    SsoStorage.getUserProfile().then((profile) {
      HashMap hashMap = new HashMap<String, String>();
      hashMap["session_token"] = profile["session_token"];
      hashMap["username"] = profile["username"];
      List<String> query = [amount, mode, gateWay];
      NetworkHandler handler = new NetworkHandler((success) {
        calculation.onSuccessCalculation(jsonDecode(success)["data"]);
      }, (failure) {
        calculation
            .onSuccessCalculation(AppUtils.errorDecoder(jsonDecode(failure)));
      }, (error) {
        calculation.onSuccessCalculation(error);
      });
      CHSONEAPIHandler.getPGAmount(handler, hashMap, query).excute();
    });
  }

  Map getMobikwikPg(Map ysebank) {
//    ysebank["srvmobikwikpg"]="asdsda";
    for (String a in ysebank.keys) {
//      print("pgpgpgpgp ------------ $a");
      if (a.toLowerCase().contains("MOBIKWIKPG".toLowerCase())) {
        print("pgpgpgpgp asndinsidn------------ $a");
        return ysebank[a];
      }
    }
    return null;
  }

}

abstract class IPaymentCalculation {
  void onSuccessCalculation(var calculation);

  void onFailedCalculation();

  void onErrorCalculation();
}

abstract class IPaymentModeModel {
  void onSuccessPaymentMode(List paymentGateWays, List<dynamic> modes);

  void onFailedPaymentMode(String failed);

  void onErrorPaymentMode(String failed);
}
