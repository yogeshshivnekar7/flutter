/*abstract class PayAlreadyMethodView extends IPaymentModeModel {}

class PayAlreadyMethodPresentor {
  PayAlreadyMethodView alreadyMethodView;

  PayAlreadyMethodPresentor(PayAlreadyMethodView alreadyMethodView) {
    this.alreadyMethodView = alreadyMethodView;
  }

  void getPaymentMethodsForMember() {
    PaymentModeModel model = new PaymentModeModel();
    model.getPaymentModeMember(
        alreadyMethodView.onSuccessPaymentMode,
        alreadyMethodView.onFailedPaymentMode,
        alreadyMethodView.onErrorPaymentMode);
  }
}

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
        onSuccessPaymentMode(modes);
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
          print(paymentOptions);
          List modes = [];
          var vpa = {};
          if (paymentOptions["vpa"] != null &&
              paymentOptions["vpa"].toString().trim() != "") {
            vpa = {
              "img": "images/ecollect.png",
              "name": "E-Collect",
              "selected": false,
              "key": "vap",
              "value": paymentOptions["vpa"]
            };
            modes.add(vpa);
          }
          try {
            if (paymentOptions["gateways"] != null) {
              print(paymentOptions["gateways"]);
              var ysebank = paymentOptions["gateways"];
              if (ysebank["YESPG"] != null) {
                Map yesBankModes = ysebank["YESPG"];
                print(yesBankModes);
                for (var a in yesBankModes.keys) {
                  print(a);
                  modes.add(Yesbank.getMode(a, yesBankModes[a], vpa["value"]));
                }
              }
            }
          } catch (e) {
            print(e);
          }

          payMethodPageView.onSuccessPaymentMode(modes);
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

  void getPaymentCalculation(IPaymentCalculation calculation, amount, mode) {
    SsoStorage.getUserProfile().then((profile) {
      HashMap hashMap = new HashMap<String, String>();
      hashMap["session_token"] = profile["session_token"];
      hashMap["username"] = profile["username"];
      List<String> query = [amount, mode];
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
}

abstract class IPaymentCalculation {
  void onSuccessCalculation(var calculation);

  void onFailedCalculation();

  void onErrorCalculation();
}

class Yesbank {
  static getMode(String a, var yesBankMod, String vpa) {
    switch (a) {
      case "CC":
        return {
          "img": "images/credit-card.png",
          "name": "Credit Card",
          "selected": false,
          "chsone_key": "CC",
          "key": "cc",
          "rate": yesBankMod["rate"],
          "vpa": vpa
        };
        break;
      case "DB":
        return {
          "img": "images/debit-card.png",
          "name": "Debit Card",
          "selected": false,
          "chsone_key": "DB",
          "key": "db",
          "rate": yesBankMod["rate"],
          "vpa": vpa
        };
        break;
      case "NB":
        return {
          "img": "images/netbanking.png",
          "name": "NetBanking",
          "selected": false,
          "chsone_key": "NB",
          "key": "nb",
          "rate": yesBankMod["rate"],
          "vpa": vpa
        };
        break;
    }
  }
}

abstract class IPaymentModeModel {
  void onSuccessPaymentMode(List modes);

  void onFailedPaymentMode(String failed);

  void onErrorPaymentMode(String failed);
}*/
