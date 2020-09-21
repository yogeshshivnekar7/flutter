import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class ProfileModel {
  ProfileModelResponse profileModelResponse;

  ProfileModel(this.profileModelResponse);

  getUserProfile() {
    var currentConfig = Environment().getCurrentConfig();

    void success(String response) {
      var profileResponseJson = json.decode(response);
      var profile = profileResponseJson["data"];
      SsoStorage.setUserProfile(profile);
      UserUtils.pushUserData(profile);
      profileModelResponse.onSuccess(response);
      print("response - " + response);
    }

    void error(String error) {
      profileModelResponse.onError(error);
      print("error" + error);
    }

    void failure(String failure) {
      print("failure" + failure);
      profileModelResponse.onFailure(failure);
    }

    NetworkHandler handler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});

    SsoStorage.getToken().then((token) {
      var tokensss;
      //if (token != null) {
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      /* } else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      print(tokensss);
      HashMap<String, String> param = new HashMap();
      param["access_token"] = tokensss;
      Network network = SSOAPIHandler.getUserProfile(handler, param);
      network.excute();
    }).catchError((e) {
      print(e);
    });
  }

  getUserProfileProgress() {
    var currentConfig = Environment().getCurrentConfig();

    void success(String response) {
      /*   var profileResponseJson = json.decode(response);
      var profile = profileResponseJson["data"];
      SsoStorage.setUserProfile(profile);
      profileModelResponse.onSuccess(response);
      UserUtils.pushUserData(profile);
      print("response - " + response);*/
      print(response);
      profileModelResponse.onProfileProgress(response);
    }

    void error(String error) {
      profileModelResponse.onError(error);
      print("error" + error);
    }

    void failure(String failure) {
      print("failure" + failure);
      profileModelResponse.onFailure(failure);
    }

    NetworkHandler handler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});

    SsoStorage.getToken().then((token) {
      var tokensss;
      /* if (token != null) {*/
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      /* } else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      print(tokensss);
      HashMap<String, String> param = new HashMap();
      param["access_token"] = tokensss;
      Network network = SSOAPIHandler.getUserProfileProgres(handler, param);
      network.excute();
    }).catchError((e) {
      print(e);
    });
  }

  updateUserProfile(HashMap<String, String> finalParam) {
    void success(String response) {
      print("response - " + response);
      profileModelResponse.onSuccess(response);

      //print("s - " + jsonDecode(response));
    }

    void error(String error) {
      print("error" + error);
      profileModelResponse.onError(error);
    }

    void failure(String failure) {
      print("failure" + failure);
      profileModelResponse.onFailure(failure);
    }

    print("handlerhandlerhandler");
    NetworkHandler handler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});

    SsoStorage.getToken().then((token) {
      var tokensss;
      /*   if (token != null) {*/
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      /* } else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      print(tokensss);
      finalParam["access_token"] = tokensss;
      Network network = SSOAPIHandler.updateUserProfile(handler, finalParam);
      network.excute();
      print("excute");
    }).catchError((e) {
      print(e);
    });
  }

  verifyMobile(String accessToken) {
    var currentConfig = Environment().getCurrentConfig();

    void success(String response) {
      profileModelResponse.onSuccess(response);
      print("response - " + response);
      //print("s - " + jsonDecode(response));
    }

    void error(String error) {
      profileModelResponse.onError(error);
      print("error" + error);
    }

    void failure(String failure) {
      print("failure" + failure);
      profileModelResponse.onFailure(failure);
    }

    NetworkHandler handler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});

    SsoStorage.getToken().then((token) {
      var tokensss;
      /* if (token != null) {*/
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      /* } else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      print(tokensss);
      HashMap<String, String> param = new HashMap();
      param["access_token"] = tokensss;
      Network network = SSOAPIHandler.verifyMobile(handler, param);
      network.excute();
      print("excute");
    }).catchError((e) {
      print(e);
    });
  }

  verifyEmail(String email) {
    var currentConfig = Environment().getCurrentConfig();

    void success(String response) {
      profileModelResponse.onSuccess(response);
      print("response - " + response);
      //print("s - " + jsonDecode(response));
    }

    void error(String error) {
      profileModelResponse.onError(error);
      print("error" + error);
    }

    void failure(String failure) {
      profileModelResponse.onFailure(failure);
      print("failure" + failure);
    }

    NetworkHandler handler = new NetworkHandler(
            (response) {
          success(response);
        },
            (response) {
          failure(response);
        },
            (response) {
          error(response);
        });

    SsoStorage.getToken().then((token) {
      var tokensss;
      /*if (token != null) {*/
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      /* } else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      print(tokensss);
      HashMap<String, String> param = new HashMap();
      param["access_token"] = tokensss;
      param["email"] = email;
      Network network = SSOAPIHandler.verifyEmail(handler, param);
      network.excute();
      print("excute");
    }).catchError((e) {
      print(e);
    });
  }

  void updateProfileImage(File image) {
    void success(String response) {
      print("response - " + response);
      profileModelResponse.onSuccess(response);

      //print("s - " + jsonDecode(response));
    }

    void error(String error) {
      print("error" + error);
      profileModelResponse.onError(error);
    }

    void failure(String failure) {
      print("failure" + failure);
      profileModelResponse.onFailure(failure);
    }

    print("handlerhandlerhandler");
/*    NetworkHandler handler = new NetworkHandler(
        (response) => {success(response)},
        (response) => {failure(response)},
        (response) => {error(response)});*/

    SsoStorage.getToken().then((token) async {
      var tokensss;
      if (token != null) {
        var access = jsonDecode(token);
        tokensss = access["access_token"];
        print(tokensss);
        var formData = FormData.fromMap({
          "access_token": tokensss,
          "image":
          await MultipartFile.fromFile(image.path, filename: "image.jpg"),
        });
        Dio dio = new Dio();
        /*http://authapi.chsone.in/api/v2/users/35/avatars*/
        Response response = await dio.post(
            Environment()
                .getCurrentConfig()
                .ssoAuthUrl + "users/avatars",
            data: formData);
        print(response.data);
        if (response.statusCode == 200) {
          success(response.data.toString());
        } else {
          failure(response.data.toString());
        }
      } else {
        error("Access Token not available");
      }

      print("excute");
    }).catchError((e) {
      print(e);
      print("excute");
    });
  }

  void deleteUserAddress(String address_tag) {
    HashMap<String, String> map = new HashMap();
    void success(String response) {
      print("response - " + response);
      profileModelResponse.onSuccess(response);

      //print("s - " + jsonDecode(response));
    }

    void error(String error) {
      print("error" + error);
      profileModelResponse.onError(error);
    }

    void failure(String failure) {
      print("failure" + failure);
      profileModelResponse.onFailure(failure);
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
      Network network = SSOAPIHandler.deleteUserAddress(handler, map);
      network.excute();
      print("excute");
    }).catchError((e) {
      print(e);
    });
  }

  void addNewAddress(param) {
    var currentConfig = Environment().getCurrentConfig();

    void success(String response) {
      profileModelResponse.onSuccess(response);
      print("response - " + response);
      //print("s - " + jsonDecode(response));
    }

    void error(String error) {
      profileModelResponse.onError(error);
      print("error" + error);
    }

    void failure(String failure) {
      profileModelResponse.onFailure(failure);
      print("failure" + failure);
    }

    NetworkHandler handler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});

    SsoStorage.getToken().then((token) {
      var tokensss;
      /* if (token != null) {*/
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      /* } else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      print(tokensss);
      // HashMap<String, String> param = new HashMap();
      param["access_token"] = tokensss;
      //param["address"] = address["address"];
      /*param["landmark"] = address["landmark"];
      param["locality"] = address["locality"];
      param["zipcode"] = address["zipcode"];
      param["city"] = address["city"];
      param["state"] = address["state"];
      param["country"] = address["country"];*/
      Network network = SSOAPIHandler.addNewUserAddress(handler, param);
      network.excute();
      print("excute");
    }).catchError((e) {
      print(e);
    });
  }

  void getCountry() {
    void success(String response) {
      print("response - " + response);
      profileModelResponse.onSuccess(response);

      //print("s - " + jsonDecode(response));
    }

    void error(String error) {
      print("error" + error);
      profileModelResponse.onError(error);
    }

    void failure(String failure) {
      print("failure" + failure);
      profileModelResponse.onFailure(failure);
    }

    //print("handlerhandlerhandler");
    NetworkHandler handler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});

    SsoStorage.getToken().then((token) {
      var tokensss;
      /*if (token != null) {*/
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      /* } else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      print(tokensss);
      HashMap<String, String> finalParam = new HashMap();
      //finalParam["access_token"] = tokensss;
      Network network = SSOAPIHandler.getCountries(handler, finalParam);
      network.excute();
      print("excute");
    }).catchError((e) {
      print(e);
    });
  }

  void getStates(String country_id) {
    void success(String response) {
      print("response - " + response);
      profileModelResponse.onSuccess(response);

      //print("s - " + jsonDecode(response));
    }

    void error(String error) {
      print("error" + error);
      profileModelResponse.onError(error);
    }

    void failure(String failure) {
      print("failure" + failure);
      profileModelResponse.onFailure(failure);
    }

    //print("handlerhandlerhandler");
    NetworkHandler handler = new NetworkHandler(
            (response) => {success(response)},
            (response) => {failure(response)},
            (response) => {error(response)});

    SsoStorage.getToken().then((token) {
      var tokensss;
      /* if (token != null) {*/
        var access = jsonDecode(token);
        tokensss = access["access_token"];
      /* } else {
        tokensss = "z1XEVq4W3690UlNqQKbWtz1gf95yBWgQ8AIlmLrc";
      }*/
      print(tokensss);
      HashMap<String, String> finalParam = new HashMap();
      //finalParam["access_token"] = tokensss;
      Network network =
      SSOAPIHandler.getStatesWrtCountry(handler, finalParam, country_id);
      network.excute();
      print("excute");
    }).catchError((e) {
      print(e);
    });
  }

}

abstract class ProfileModelResponse {
  void onSuccess(String success);

  void onProfileProgress(String success);

  void onFailure(String failure);

  void onError(String error);
}


/*
class ProfileModelResponse {
}*/
