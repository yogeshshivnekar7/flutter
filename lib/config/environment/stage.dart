import 'package:common_config/utils/firebase/firebase_util.dart';

import 'config.dart';

class Stage extends Config {
  Stage() {
    FirebaseDatabaseUtils.environment = "Stage";
  }

  @override
  get build_variant => 'stage';

  @override
  get url => "chsone.in";

  @override
  // TODO: implement getOneAppId
  get getOneAppId => "21";

  @override
  // TODO: implement getOneAppId
  get hrmsAppId => "24"; //21 change to 24

  @override
  get chsoneApiUrl => "https://stgsociety.chsone.in/";

  @override
  get chsoneClientId => "chsoneapp";

  @override
  get chsoneClientSecret => "chsoneapp";

  @override
  get ssoApiKey =>
      "c649585bf79fa8906e5fa84ef26bd52e8f329c725be45bb5ccd274119115dff4";

  @override
  get ssoAuthUrl => "https://stgauthapi.chsone.in/api/v2/";

  @override
  get ssoClientId => "testid";

  @override
  get ssoClientSecret => "testsecret";

  @override
  get chsoneResidentUrl => "https://stgsociety.chsone.in/residentapi/v2/";

  @override
  get vizlogAppUrl => "https://stggateapi.cubeone.biz/api/v1/";

  @override
  get vizlogAppId => "5";

  @override
  get chsoneAppId => "2";

  @override
  get restoApiUrl => "http://stgcrmapi.vezaone.com/api/v1/";

  @override
  get crm_api_key =>
      "663cb188786be06a0bfd5f2897b17689682afe672f47555a2f1f617c8ccaca69";

  @override
  get tiffin_image_logo => 'https://s3.ap-south-1.amazonaws.com/cubeoneapp.com';

  /*@override
  get tiffin_image_logo =>
      'http://s3-ap-southeast-1.amazonaws.com/fdc01.fooddialer.in';*/

  @override
  get chsoneWebUrl => "https://stg.chsone.in/";

  @override
  get vizlogClientId => "web_client_1094";

  @override
  get vizlogClientSecret => "YIpK875z";

  @override
  get vezaPlugInUrl => "http://stgdemo.vezaone.com/";

  @override
  setUpVersions() {
    return {"android": 1.0, "ios": 1.0, "web": 1.0};
  }

  @override
  // TODO: implement vezaGroceryPlugInUrl
  get vezaGroceryPlugInUrl => "https://stgretail.vezaone.com/";

  @override
  get chsoneRequestUrl =>
      "http://stgsociety.chsone.in/marketplaces/v1/oneapp-request-demo";

  @override
  // TODO: implement hrmsClientId
  get hrmsClientId => null;

  @override
  // TODO: implement hrmsClientSecret
  get hrmsClientSecret => null;

  @override
  get name => "stage";

  @override
  // TODO: implement account_url
  get account_url => 'https://stgaccount.cubeoneapp.com/login';

  @override
  get nodeUrl => "https://stgvisitapi.cubeone.biz/";

  @override
  // TODO: implement ecollectKey
  get ecollectKey => "YESEC";

  @override
  get subscriptionPlugInUrl => "http://stgsubscription.vezaone.com/";

  @override
  // TODO: implement notificationUrl
  get notificationUrl => "http://stgnotifications.vezaone.com/";

  @override
  // TODO: implement pyna_wine_company_Id
  get pyna_wine_company_Id => "2990";

  @override
  // TODO: implement recipeUrl
  get recipeUrl => "https://stgrecipe.vezaone.com";

  @override
  get serverApiKey =>
      "da5b43e3f5098dd3877cdf81bfef0b7446cbc80f1cb42d13c7df13d1bae40c4c";

  @override
  get moneyUrl => "https://stgmoneyapi.vezaone.com/api/v1/";

  @override
  get meetingBaseUrl => "https://stgmeet.cubeonebiz.com/api/v1/";

  @override
  get meetingClientSecret => "itbaY9o8";

  @override
  get meetingClientId => "web_client";

  @override
  get meetingDomain => "stgmeet.cubeonebiz.com";

  @override
  get meetingAppId => 25;



  @override
  // TODO: implement iplUrl
  get iplUrl => "https://stgquiz.cubeonebiz.com/api/v1/";
}
