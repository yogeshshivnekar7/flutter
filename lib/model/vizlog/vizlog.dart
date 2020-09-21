import 'dart:collection';
import 'dart:convert';

import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/network/vizlog_api.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class VizLogModel {
  void getAllComplexUnits(
      Function unitSuccess, Function unitFailed, Function unitError) {
    HashMap<String, String> hashTable = new HashMap<String, String>();
    NetworkHandler networkHandler = new NetworkHandler((success) {
      var response = jsonDecode(success);
      var data = response["data"];
      if (data != null) {
        print("----------------------unit access---------------------");
//        print(data[0]);
        unitSuccess(unitVizlogPrepare(data));
      } else {
        unitSuccess(response);
      }
//      SsoStorage.setAllChsoneUnit(data);
    }, (failure) {
      unitFailed(failure);
    }, (error) {
      unitFailed(error);
    });

    SsoStorage.getUserProfile().then((value) {
      hashTable["session_token"] = value["session_token"];
      // hashTable["soc_id"] = "65";
      hashTable["username"] = value["username"];
      hashTable["user_id"] = value["user_id"].toString();
      Network network = SSOAPIHandler.getAllComplexVizlogUnits(
          networkHandler, hashTable, [value["user_id"].toString()]);
      network.excute();
    }).catchError((e) {
      print(e);
    });
  }

  List unitVizlogPrepare(units) {
//    var units = data["data"];
//    print("anviansdifniasnin");
    List complex = [];
    print(units);
    if (units != null) {
      for (var u in units) {
//        if(u["status"] == "accepted"){
        var com = {};
        Map complexData = u["complex"];
        com["name"] = complexData["complex_name"]
            .toString(); //u["unit_flat_number"].toString();
        com["soc_id"] = complexData["company_id"].toString().trim();

        com["building"] = u["building_name"].toString().trim();
        com["unit"] = u["unit_number"].toString().trim();
        com["unit_id"] = u["building_unit_id"].toString().trim();

        if (u.containsKey("member_id") && u["member_id"] != null) {
          com["member_id"] = u["member_id"].toString().trim();
        } else {
          com["member_id"] = null;
        }

        com["location"] = AppUtils.mergeAddressSSOVizlog(
            complexData); //           "Location is pending"; //u["unit_flat_number"].toString();
        com["active"] = u["status"] == "accepted" ? true : false;

//          SsoStorage.setDefaultVizlogUnit(com);
//          break;
//        }
        complex.add(com);
      }
      if (complex != null && complex.length > 0) {
        SsoStorage.setAllVizLogUnit(complex);
        return complex;
      } else {
        SsoStorage.setAllVizLogUnit(null);
        return null;
      }
    }
//    var com = {};
//    Map complexData = u["complex"];
//    com["name"] = complexData["complex_name"]
//        .toString(); //u["unit_flat_number"].toString();
//    com["soc_id"] = complexData["company_id"].toString();
//
//    com["building"] = u["building_name"].toString();
//    com["unit"] = u["unit_number"].toString();
//    com["unit_id"] = u["building_unit_id"].toString();
//    com["location"] = AppUtils.mergeAddressSSOVizlog(
//        complexData); //           "Location is pending"; //u["unit_flat_number"].toString();
//    com["active"] = u["status"] == "accepted" ? true : false;
//    SsoStorage.setDefaultVizlogUnit(com);
  }

  void doLogin(HashMap<String, String> hashMap, onSuccess, onError, onFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = VizlogApiHandler.vizLogin(a, hashMap);
    network.excute();
  }

  void getVizProfile(HashMap<String, String> hashMap, onSuccess, onError,
      onFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = VizlogApiHandler.getVizProfile(a, hashMap);
    network.excute();
  }

  void getVisitors(HashMap<String, String> hashMap, String unitId, onSuccess,
      onError, onFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = VizlogApiHandler.getVisitors(a, unitId, hashMap);
    network.excute();
  }

  void getGuests(HashMap<String, String> hashMap, String unitId, onSuccess,
      onError, onFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = VizlogApiHandler.getGuest(a, unitId, hashMap);
    network.excute();
  }

  void getStaff(HashMap<String, String> hashMap, String unitId, onSuccess,
      onError, onFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    Network network = VizlogApiHandler.getStaff(a, unitId, hashMap);
    network.excute();
  }

  void postVisitor(HashMap<String, String> hashMap, success, error, failure) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(userFalure);
    }, (e) {
      error(e);
    });
    Network network = VizlogApiHandler.postVisitor(a, hashMap);
    network.excute();
  }

  void postInviteGuest(HashMap<String, String> hashMap, success, error,
      failure) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()));
    }, (f) {
      print("failed------------------------------------$f");
      try {
        var userFalure = jsonDecode(f);
        failure(userFalure);
      } catch (e) {
        print(e);
      }
      //print("sssssssssssssssss");
    }, (e) {
      error(e);
    });
    Network network = VizlogApiHandler.postInviteGuest(a, hashMap);
    network.excute();
  }

  void putInviteGuest(HashMap<String, String> hashMap, success, error,
      failure) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(userFalure);
    }, (e) {
      error(e);
    });
    Network network = VizlogApiHandler.putInviteGuest(a, hashMap);
    network.excute();
  }

  void getGlobalVisitor(HashMap<String, String> hashMap, success, error,
      failure) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(userFalure);
    }, (e) {
      error(e);
    });
    Network network = VizlogApiHandler.getGlobalVisitor(a, hashMap);
    network.excute();
  }

  void getExpectedGuest(String unitId, HashMap<String, String> hashMap, success,
      error, failure) {
    NetworkHandler a = new NetworkHandler((s) {
      success(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      failure(userFalure);
    }, (e) {
      error(e);
    });
    Network network = VizlogApiHandler.getExpectedGuest(a, hashMap, unitId);
    network.excute();
  }

  void getBuilding(HashMap<String, String> hashMap, intercomSuccess,
      intercomError, intercomFailure) {
    NetworkHandler a = new NetworkHandler((s) {
      intercomSuccess(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      intercomFailure(userFalure);
    }, (e) {
      intercomError(e);
    });
    Network network = VizlogApiHandler.getBuilding(a, hashMap);
    network.excute();
  }
}
