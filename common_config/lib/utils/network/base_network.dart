import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:common_config/utils/application.dart';
import 'package:common_config/utils/firebase/firebase_util.dart';
import 'package:dio/dio.dart';

abstract class BaseNetwork {
  static String post = "post";
  static String get = "get";
  static String put = "put";
  static String delete = "delete";
  String type;

  String url;
  void Function(int, String) success;
  void Function(int, String) error;
  void Function(int, String) failure;

  bool isDebugable = false;
  HashMap<String, String> map;
  List<String> queryParam;
  List files;

  void setRequestDebug(bool isDebugable) {
    this.isDebugable = isDebugable;
  }

  bool _encoded = false;

  void setEncode(bool encoded) {
    _encoded = encoded;
  }

  void setHandler(void Function(int, String) success,
      void Function(int, String) failure, void Function(int, String) error) {
    this.success = success;
    this.failure = failure;
    this.error = error;
  }

  FutureOr successCallback(response) {
    print(response.body);
  }

  Future<void> getRequest(String url,
      [HashMap map, List<String> querry]) async {
    try {
      this.url = url;
      this.map = map;
      this.queryParam = querry;
      type = get;
    } catch (e) {
      print(e);
    }
  }

  Future<void> postRequest(String url, [HashMap<String, String> map]) async {
    this.url = url;
    this.map = map;
    type = post;
  }

  var header;

  Future<void> postRequestJSON(String url, [String jsonData]) async {
    this.url = url;
    this.jsonData = jsonData;
    type = post;
    header = "json";
  }

  Future<void> postWithMultipartRequest(String url, HashMap<String, String> map,
      {List files}) async {
    this.url = url;
    this.map = map;
    this.files = files;
    type = post;
  }

  Future<void> putRequestMultiPart(String url,
      [HashMap<String, String> map]) async {
    this.url = url;
    this.map = map;
    type = put;
  }

  Future<void> putRequest(String url, [HashMap<String, String> map]) async {
    this.url = url;
    this.map = map;
    type = put;
  }

  Future<void> deleteRequest(String url, [HashMap<String, String> map]) async {
    this.url = url;
    this.map = map;
    type = delete;
  }

  Future<Response> fetchGet(String s) {
    this.url = url;
    this.map = map;
    this.queryParam = queryParam;
    String paramQuerry = "";
    if (map != null) {
      for (String name in map.keys) {
        if (map[name] == null) {
          continue;
        } else {
          paramQuerry = paramQuerry + "&" + name + "=" + map[name];
        }
      }
    }
    if (paramQuerry != "") {
      paramQuerry = paramQuerry.substring(1);
    }
    String urlFinalUrl = url;
    if (queryParam != null) {
      urlFinalUrl = urlFinalUrl + "/" + queryParam.join("/");
    }
    if (map != null && paramQuerry != null) {
      urlFinalUrl = urlFinalUrl + "?" + paramQuerry;
    }
    //print(url);
    print("**************urlFinalUrl****************");
    if (!_encoded) {
      print(Uri.encodeFull(urlFinalUrl));

      return Dio().get(Uri.encodeFull(urlFinalUrl), queryParameters: {});
    } else {
      print(urlFinalUrl);
      return Dio().get(urlFinalUrl, queryParameters: {});
    }
  }

  var jsonData;

  Future<Response> fetchPost(String s) async {
    if (header.toString() == 'json') {
      var options2 = new Options(contentType: "application/json");
      return new Dio().post(s, data: jsonData, options: options2);
    } else {
      Map mapIng = Map<String, dynamic>();
      mapIng.addAll(map);
      if (files != null) {
        for (int a = 0; a < files.length; a++) {
          var file = files[a];
          mapIng[file["key"]] = await MultipartFile.fromFile(file["file_path"],
              filename: "file.png");
        }
      }
      var formData = FormData.fromMap(mapIng);
      return new Dio().post(s, data: formData);
    }
  }

  Future<Response> fetchPut(String s) {
    print("queryParameters:  map");
    var options2 =
        new Options(contentType: "application/x-www-form-urlencoded");
    return Dio().put(s, data: map, options: options2);
  }

  Future<void> excuteRequest() async {
    var startTime = DateTime
        .now()
        .millisecondsSinceEpoch;
    int statusCode = 0;
    String body;
    var responseHeaders;
    Response response;
    try {
      print(type);

      if (type == get) {
        response = await fetchGet(url);
      } else if (type == post) {
        response = await fetchPost(url);
      } else if (type == put) {
        response = await fetchPut(url);
      } else if (type == delete) {
        var options2 =
        new Options(contentType: "application/x-www-form-urlencoded");
        var dai = new Dio();

        response =
        await dai.delete(url, queryParameters: map, options: options2);

        /* var rq = Request('DELETE', Uri.parse(...));
        rq.bodyFields = {...};

        var response = await client.send(rq);*/

      }
      // await Future.delayed(Duration(seconds: 5));
      statusCode = response.statusCode;
      print(statusCode);
      print(response.data.toString());
      body = jsonEncode(response.data); // response.data.toString();
      responseHeaders = response.headers;
      if (statusCode == 200 ||
          statusCode == 203 ||
          statusCode == 202 ||
          statusCode == 201 ||
          statusCode == 204) {
        print("responseresponseresponseresponseresponse");
        success(statusCode, body);
      } else {
        failure(statusCode, body);
        reportError(statusCode, body, responseHeaders);
      }
    } on DioError catch (e) {
      response = e.response;
      if (response != null) {
        statusCode = response.statusCode;
        body = jsonEncode(response.data); // response.data.toString();
        responseHeaders = response.headers;
        if (statusCode == 200 ||
            statusCode == 203 ||
            statusCode == 202 ||
            statusCode == 201 ||
            statusCode == 204) {
          success(statusCode, body);
        } else {
          failure(statusCode, body);
          reportError(statusCode, body, responseHeaders);
        }
      } else {
        print(e);
        error(0, e.message);
      }
      /*reportError(0, body, responseHeaders);*/
    } on SocketException catch (e) {
      print(e);
      error(0, "No internet connection!");
      /*reportError(0, body, responseHeaders);*/
    } catch (e) {
      print("eeeeeeeeeeeeeeeeeeeeeeeeeeeee");
      print(e);
      print(e.runtimeType);
      print("ffffffffffffffffffffffffff");
      error(0, e.toString());
      reportError(0, body, responseHeaders);
    }
    var endTimeTime = DateTime
        .now()
        .millisecondsSinceEpoch;
    if (isDebugable) {
      try {
        var timeInterval = endTimeTime - startTime;
        Map<String, dynamic> printer = new Map();
        printer["Url"] = url;
        printer["Param"] = map;
        printer["query"] = queryParam;
        printer["https Code"] = statusCode;
        printer["responseTime"] = timeInterval;
        printer["Response"] = body;

        print(printer.toString());
      } catch (e) {
        print(e);
      }
    }
  }

  executeMutipartRequest(File image, String access_token) async {
    try {
      // uploadFile(image, access_token);
    } catch (e) {
      print(e);
      error(0, e.toString());
    }
  }

  reportError(int i, String response_body, var responseHeaders) {
    getUserProfile().then((profileData) async {
      if (profileData != null) {
        HashMap<String, String> errorMap = new HashMap();
        errorMap["company_id"] = "";
        errorMap["unit_id"] = "";
        errorMap["company_name"] = "";
        errorMap["activity"] = this.url;
        errorMap["severity"] = "high";
        errorMap["company_name"] = "";
        errorMap["user_name"] = profileData["username"];
        errorMap["endpoint"] = this.url;
        errorMap["request_method"] = type;
        if (responseHeaders != null) {
          errorMap["response_header"] = responseHeaders.toString();
        }
        errorMap["request_body"] = this.map.toString();
        errorMap["response_body"] = response_body;
        errorMap["exception_trace"] = response_body;
        errorMap["device"] = await getDeviceInfo();
        errorMap["app_name"] = getAppName();
        errorMap["platform"] = ApplicationUtil.getDeviceCode();
        executeErrorReport(errorMap);
      }
    });
  }

  String getErrorReportingUrl();

  Future<dynamic> getUserProfile();

  Future<dynamic> getDeviceInfo();

  void executeErrorReport(HashMap<String, String> errorMap) {
    reportViaRestAPi(errorMap);
    reportViaFireBase(errorMap);
  }

  Future reportViaRestAPi(HashMap<String, String> errorMap) async {
    int statusCode = 0;
    String body;
    String error_url = getErrorReportingUrl();
    try {
      Response response;
      response = await Dio().post(error_url, queryParameters: errorMap);
      /*  Response response;
      response = await http.post(error_url, body: errorMap);*/
      statusCode = response.statusCode;
      /* body = jsonEncode(response.data);
      body = response.body;
      if (statusCode == 200 ||
          statusCode == 203 ||
          statusCode == 202 ||
          statusCode == 201) {
        print("report error Success " + body.toString());
      } else {
        //print("report error failure " + body);
      }*/
    } catch (e) {
      print(e);
    }
  }

  String getAppName();

  waiting() async {
    await Future.delayed(Duration(seconds: 4));
    return Future.value(0);
  }

  void reportViaFireBase(HashMap<String, String> errorMap) {
    FirebaseDatabaseUtils.saveErrorLogData(errorMap);
  }

/*String getPlatform() {
    String platform;
    if (Platform.isAndroid != null && Platform.isAndroid) {}
    if (Platform.isIOS != null && Platform.isIOS) {}
    if (Platform.isAndroid != null && Platform.isAndroid) {}
  }*/
}
