import 'package:common_config/utils/firebase/firebase_util.dart';

import 'config.dart';

class Production extends Config {

  Production() {
    FirebaseDatabaseUtils.environment = "Live";
  }

  @override
  get build_variant => 'production';

  @override
  get url => "chsone.in";

  @override
  get chsoneApiUrl => "https://api.chsone.in/";

  @override
  get chsoneClientId => "Epm9rkpUrbSSByBD";

  @override
  get chsoneClientSecret => "Nk68pdu6kLFHTAAH";

  @override
  get ssoApiKey =>
      "5b2f4b31f524b6603d81dbcaabd8121078d00f1614a294c3207e39951f7054c8";

  @override
  get ssoAuthUrl => "http://authapi.chsone.in/api/v2/";

  @override
  get ssoClientId => "web_client";

  @override
  get ssoClientSecret => "ZMsRmR2vXH5Q2one";

  @override
  get chsoneResidentUrl => "https://api.chsone.in/residentapi/v2/";

  @override
  get vizlogAppUrl => "http://gateapi.cubeone.biz/api/v1/";

  @override
  get chsoneAppId => "2";

  @override
  get hrmsAppId => "16";

  @override
  get vizlogAppId => "5";

  @override
  get restoApiUrl => "http://crmapi.vezaone.com/api/v1/";

  @override
  get vizlogClientId => "vizlog_android";

  @override
  get vizlogClientSecret => "giT16P1p3U";

  @override
  get chsoneWebUrl => "https://chsone.in/";

  @override
  get crm_api_key =>
      "5c57fdbef9c432e61e0d1950f19db0c4d35eb6983236b17ebd82ab2578cc794e";

  /*@override
  get tiffin_image_logo =>
      'http://s3-ap-southeast-1.amazonaws.com/fdc01.fooddialer.in';*/
  @override
  get tiffin_image_logo => 'https://s3.ap-south-1.amazonaws.com/cubeoneapp.com';

  @override
  get vezaPlugInUrl => "http://demo.vezaone.com/";

  @override
  setUpVersions() {
    return {"android": 1.0, "ios": 1.0, "web": 1.0};
  }

  @override
  // TODO: implement getOneAppId
  get getOneAppId => "15";

  /* @override
  get vezaPlugInUrl => throw UnimplementedError();*/

  @override
  // TODO: implement chsoneRequestUrl
  get chsoneRequestUrl =>
      "http://society.cubeonebiz.com/marketplaces/v1/oneapp-request-demo";

  //https://

  @override
  // TODO: implement hrmsClientId
  get hrmsClientId => 'web_client_1';

  @override
  // TODO: implement hrmsClientSecret
  get hrmsClientSecret => 'Z7s4AIXv';

  @override
  // TODO: implement vezaGroceryPlugInUrl
  get vezaGroceryPlugInUrl => "https://retail.vezaone.com/";

  @override
  get name => "production";

  @override
  // TODO: implement account_url
  get account_url => 'https://account.cubeoneapp.com/login';

  @override
  get nodeUrl => "https://visitapi.cubeone.biz/";

  @override
  // TODO: implement ecollectKey
  get ecollectKey => "srvybecollect";


  @override
  get subscriptionPlugInUrl => "https://subscription.vezaone.com/";

  @override
  // TODO: implement notificationUrl
  get notificationUrl => "http://notifications.vezaone.com/";

  @override
  // TODO: implement pyna_wine_company_Id
  get pyna_wine_company_Id => "3824";

  @override
  // TODO: implement recipeUrl
  get recipeUrl => "https://recipe.vezaone.com";

  @override
  get serverApiKey =>
      "f22bddda7e359f62dd908f79e6ea210a4c7a364b3a820108456fdb44842ad099";

  @override
  get moneyUrl => "https://moneyapi.vezaone.com/api/v1/";

  @override
  get meetingBaseUrl => "https://meet.cubeonebiz.com/api/v1/";

  @override
  get meetingClientSecret => "MlJBFR8Ko9";

  @override
  get meetingClientId => "meeting_web";

  @override
  get meetingDomain => "meet.cubeonebiz.com";

  @override
  // TODO: implement iplUrl
  get iplUrl => "https://quiz.cubeonebiz.com/api/v1/";

  @override
  get meetingAppId => 17;
}
