import 'dart:collection';
import 'dart:io';

import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/utils/network/end_point.dart';

import 'api_handler.dart';

class CHSONEAPIHandler {
  static Network getNetworkRequest(NetworkHandler a) {
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest("http://localhost:35839/#/");
    return network;
  }

  static Network getLoginRequest(
      NetworkHandler a, HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    hashMap["api_key"] = currentConfig.ssoApiKey;
    hashMap["client_id"] = currentConfig.ssoClientId;
    hashMap["client_secret"] = currentConfig.ssoClientSecret;

    /*hashMap["username"] = userName;
    hashMap["password"] = password;*/
    /* print("params- " + hashMap.toString());*/
    Network network = new Network(a);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment().getCurrentConfig().ssoAuthUrl + Constant.USER_LOGIN,
        hashMap);
    return network;
  }

  static Network addRequestComplex(
      Map<String, String> hashMap, NetworkHandler networkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);

    network.setErrorReporting(true);
    network.setRequestDebug(true);
//    network.postRequest(currentConfig.chsoneApiUrl + Constant.REQUEST_COMPLEX, hashMap);
    network.postRequest(currentConfig.chsoneRequestUrl, hashMap);
    return network;
  }

  /*static Network getMemberDashboardDetails(HashMap<String, String> hashMap,
      NetworkHandler netwrkHandler) {*/
  static Network getPaymentModes(accessToken, NetworkHandler networkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    HashMap<String, String> hashMap = new HashMap();
    hashMap["token"] = accessToken;
    network.getRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/" + Constant.PAYMENTMODE,
        hashMap);
    return network;
  }

  /* static getPaymentMode(NetworkHandler handler,HashMap hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    hashMap["token"] = "ytkc3meO1Bz5VhL0SKJLVCKscs6Dcp4smjvWLwSw";
    network.postRequest(
        currentConfig.chsoneApiUrl + Constant.PAYMENTMODE, hashMap);
    return network;
  }*/

  static conformedPayment(NetworkHandler handler, HashMap hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    /* HashMap<String, String> hashMap=new HashMap();*/
    /*  hashMap["token"] = "";*/
    network.postRequest(
        currentConfig.chsoneApiUrl +
            "residentapi/v2/" +
            Constant.CONFORMEDPAYMENT,
        hashMap);
    return network;
  }

/*  static conformedPayment(NetworkHandler handler, hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    */ /* HashMap<String, String> hashMap=new HashMap();*/ /*
    hashMap["token"] = "";
    network.postRequest(
        currentConfig.chsoneApiUrl + Constant.CONFORMEDPAYMENT, hashMap);
    return network;
  }*/
  static Network getMemberDashboardDetails(
      HashMap<String, String> hashMap, NetworkHandler netwrkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);

    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/dashboard/alldetail",
        hashMap); //todo add api endpoint
    return network;
  }

  static Network loginChsOne(
      HashMap<String, String> hashMap, NetworkHandler netwrkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    hashMap["client_id"] = currentConfig.chsoneClientId;
    hashMap["client_secret"] = currentConfig.chsoneClientSecret;
    print("Request Param " + hashMap.toString());
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/users/token", hashMap);
//    print(currentConfig.chsoneApiUrl + "residentapi/v2/users/token");
    return network;
  }

  ////https://api.chsone.in/residentapi/v2/banks/accounts?token=U2pdVWvQPRAYgeU6yPC38bbjaV8kW4SBAejol6um
  static Network getBankAccounts(
      String accessToken, NetworkHandler networkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    HashMap<String, String> hashMap = new HashMap();
    hashMap["token"] = accessToken;
    network.getRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/" + Constant.BANK_ACCOUNTS,
        hashMap);
    return network;
  }

  static getPaymentInit(
      NetworkHandler handler, HashMap<String, String> hashMap) {
    List files;
    if (hashMap["file"] != null) {
      files = [];
      files.add({"key": "attachment", "file_path": hashMap["file"]});
    }
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postWithMultipartRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/" + Constant.PAYMENT_INIT,
        hashMap,
        files: files);
    return network;
  }

  static Network getOnlinePaymentModes(NetworkHandler networkHandler,
      HashMap<String, String> tokenHash, List<String> query) {
    /* static Network getPaymentModes(accessToken, NetworkHandler networkHandler) {*/
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    HashMap<String, String> hashMap = tokenHash;
    /*  hashMap["token"] = accessToken;*/
    network.getRequest(
        currentConfig.chsoneWebUrl + "api/v1/" + "details", hashMap, query);
    return network;
  }

  static Network getPGAmount(NetworkHandler networkHandler,
      HashMap<String, String> tokenHash, List<String> query) {
    /* static Network getPaymentModes(accessToken, NetworkHandler networkHandler) {*/
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    /*   HashMap<String, String> hashMap = tokenHash;*/
    /*  hashMap["token"] = accessToken;*/
    network.getRequest(currentConfig.chsoneWebUrl + "api/v1/" + "get-pg-amount",
        tokenHash, query);
    return network;
  }

  /*payment_amount
paid_by
soc_id
unit_id
mode
source*/
  static Network initiateOnlinePayment(
      NetworkHandler networkHandler, HashMap<String, String> tokenHash) {
    /* static Network getPaymentModes(accessToken, NetworkHandler networkHandler) {*/
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    /*   HashMap<String, String> hashMap = tokenHash;*/
    /*  hashMap["token"] = accessToken;*/
    network.postRequest(
        currentConfig.chsoneWebUrl + "api/v1/" + "initiate-payment", tokenHash);
    return network;
  }

  static Network conformedOnlinePayment(
      NetworkHandler networkHandler, HashMap<String, String> tokenHash) {
    /* static Network getPaymentModes(accessToken, NetworkHandler networkHandler) {*/
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    /*   HashMap<String, String> hashMap = tokenHash;*/
    /*  hashMap["token"] = accessToken;*/
    network.postRequest(
        currentConfig.chsoneWebUrl + "api/v1/" + "confirm-payment", tokenHash);
    return network;
  }

  static void getPaymentCalculation(NetworkHandler handler) {}

  static Network getMaintainceDues(
      NetworkHandler networkHandler, HashMap<String, String> tokenHash) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    /*   HashMap<String, String> hashMap = tokenHash;*/
    /*  hashMap["token"] = accessToken;*/
    network.getRequest(
        currentConfig.chsoneResidentUrl + "maintenance/invoices", tokenHash);
    return network;
  }

  static getHelpTopic(
      HashMap<String, String> hashMap, NetworkHandler netwrkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    print("******** in helptopic Model ***********");
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(currentConfig.chsoneApiUrl + "residentapi/v2/helptopics",
        hashMap); //todo add api endpoint
    return network;
  }

  static Network addComplaint(HashMap<String, String> hashMap, File file,
      NetworkHandler netwrkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    /*   mapIng[file["key"]] =
        await MultipartFile.fromFile(file["path"], filename: "file.png");*/
    List files;
    if (file != null) {
      files = [];
      files.add({"key": "attachment", "file_path": file.path});
    }
    print(files);
    print(hashMap);
    network.postWithMultipartRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/issues", hashMap,
        files: files);

    return network;
  }

  static getComplaintList(NetworkHandler handler, hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(currentConfig.chsoneApiUrl + "residentapi/v2/issues",
        hashMap); //todo add api endpoint
    return network;
  }

  static getComplaintReplyList(
      NetworkHandler handler, HashMap<String, String> hashMap, complaintId) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        currentConfig.chsoneApiUrl +
            "residentapi/v2/issues/" +
            complaintId.toString(),
        hashMap); //todo add api endpoint
    return network;
  }

  static Network addComplaintReply(
      HashMap<String, String> hashMap, NetworkHandler netwrkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.putRequest(
        currentConfig.chsoneApiUrl +
            "residentapi/v2/issues/" +
            hashMap['issue_id'].toString() +
            "/reply",
        hashMap);

    print(network);
    return network;
  }

  static getNoticeList(
      NetworkHandler handler, HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(currentConfig.chsoneApiUrl + "residentapi/v2/notices",
        hashMap); //todo add api endpoint
    return network;
  }

  static getNoticeDetails(
      NetworkHandler handler, HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        currentConfig.chsoneApiUrl +
            "residentapi/v2/notices/" +
            hashMap['id'].toString(),
        hashMap); //todo add api endpoint
    return network;
  }

  static Network getIncedentalDues(
      NetworkHandler networkHandler, HashMap<String, String> tokenHash) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    /*   HashMap<String, String> hashMap = tokenHash;*/
    /*  hashMap["token"] = accessToken;*/
    network.getRequest(
        currentConfig.chsoneResidentUrl + "incident/invoices", tokenHash);
    return network;
  }

  static Network getSocietyDetails(NetworkHandler netwrkHandler, String token) {
    HashMap<String, String> hashMap = new HashMap<String, String>();
    hashMap["token"] = token;
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    network.setErrorReporting(true);

    network.setRequestDebug(true);
    network.getRequest(
        currentConfig.chsoneResidentUrl + "users/soc-details/", hashMap);
    return network;
  }

  static Network getProperties(NetworkHandler netwrkHandler, hashMap) {
    /*AppConstants.APP_URL + AppConstants.GET_MY_PROPERTIES_URL*/
    /* HashMap<String, String> hashMap = new HashMap<String, String>();
    hashMap["token"] = token;*/
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(currentConfig.chsoneResidentUrl + "properties", hashMap);
    return network;
  }

  static Network acceptMemberRequest(
      NetworkHandler netwrkHandler, HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/users/activateMember",
        hashMap);

    print(network);
    return network;
  }

  static Network rejectMemberRequest(
      NetworkHandler netwrkHandler, HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/users/removeMember",
        hashMap);

    print(network);
    return network;
  }

  static Network deactivateMember(
      NetworkHandler netwrkHandler, HashMap<String, String> hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/users/deleteMember",
        hashMap);

    print(network);
    return network;
  }

  static Network uploadPhoto(HashMap<String, String> hashMap, File file,
      NetworkHandler netwrkHandler) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(netwrkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    /*   mapIng[file["key"]] =
        await MultipartFile.fromFile(file["path"], filename: "file.png");*/

    List files;
    if (file != null) {
      files = [];
      files.add({"key": "image[0]", "file_path": file.path});
    }
    print(files);
    print(hashMap);
    network.postWithMultipartRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/photos", hashMap,
        files: files);

    return network;
  }

  static createAlbum(NetworkHandler handler, hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(currentConfig.chsoneApiUrl + "residentapi/v2/albums",
        hashMap); //todo add api endpoint
    return network;
  }

  static deleteAlbums(NetworkHandler handler, hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/albums/delete",
        hashMap); //todo add api endpoint
    return network;
  }

  static deletePhotos(NetworkHandler handler, hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        currentConfig.chsoneApiUrl + "residentapi/v2/photos/delete",
        hashMap); //todo add api endpoint
    return network;
  }

  static getAlbumList(NetworkHandler handler, hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(currentConfig.chsoneApiUrl + "residentapi/v2/albums",
        hashMap); //todo add api endpoint
    return network;
  }

  static getPhotoList(NetworkHandler handler, hashMap) {
    var currentConfig = Environment().getCurrentConfig();
    Network network = new Network(handler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        currentConfig.chsoneApiUrl +
            "residentapi/v2/albums/" +
            hashMap['album_id'] +
            "/photos",
        hashMap); //todo add api endpoint
    return network;
  }
}
