import 'package:common_config/utils/firebase/firebase_util.dart';

import 'config.dart';

class Test extends Config {
  Test() {
    FirebaseDatabaseUtils.environment = "Test";
  }

  @override
  get build_variant => 'test';

  @override
  get url => "chsone.in";

  @override
  get getOneAppId => "26";

  @override
  get chsoneApiUrl => "https://testsociety.chsone.in/";

  @override
  get chsoneClientId => "chsoneapp";

  @override
  get chsoneClientSecret => "chsoneapp";

  @override
  get ssoAuthUrl => "http://testauthapi.chsone.in/api/v2/";

  @override
  get ssoClientId => "testid";

  @override
  get ssoClientSecret => "testsecret";

  @override
  get chsoneResidentUrl => "https://testsociety.chsone.in/residentapi/v2/";

  @override
  get vizlogAppUrl => "http://testcloudapi.vizitorlog.com/api/v1/";

  @override
  get vizlogAppId => 5;

  @override
  get hrmsAppId => null;

  @override
  get chsoneAppId => 2;

  @override
  get restoApiUrl => "http://testcrmapi.vezaone.com/api/v1/";

  @override
  get crm_api_key =>
      "663cb188786be06a0bfd5f2897b17689682afe672f47555a2f1f617c8ccaca69";

  @override
  get tiffin_image_logo =>
      'http://s3-ap-southeast-1.amazonaws.com/fdc01.fooddialer.in';

  @override
  get chsoneWebUrl => "https://test.chsone.in/";

  @override
  get vizlogClientId => "web_client_1094";

  @override
  get vizlogClientSecret => "YIpK875z";

  @override
  get vezaPlugInUrl => "http://testorder.vezaone.com/";

  @override
  setUpVersions() {
    return {"android": 1.0, "ios": 1.0, "web": 1.0};
  }

  @override
  get chsoneRequestUrl =>
      "http://testsociety.chsone.in/marketplaces/v1/oneapp-request-demo";

  @override
  // TODO: implement hrmsClientId
  get hrmsClientId => null;

  @override
  // TODO: implement vezaGroceryPlugInUrl
  get vezaGroceryPlugInUrl => "http://testretail.vezaone.com/";

  @override
  // TODO: implement hrmsClientSecret
  get hrmsClientSecret => null;

  @override
  // TODO: implement ecollectKey
  get ecollectKey => throw UnimplementedError();

  @override
  get name => "test";

  @override
  // TODO: implement account_url
  get account_url => 'https://testaccount.vezaone.com/login';

  @override
  get nodeUrl => "http://stgrealtime.vizitorlog.com/";

  @override
  // TODO: implement ssoApiKey
  String get ssoApiKey =>
      "c649585bf79fa8906e5fa84ef26bd52e8f329c725be45bb5ccd274119115dff4";

  /*testsubscription.vezaone.com*/
  @override
  // TODO: implement subscriptionPlugInUrl
  get subscriptionPlugInUrl => "http://testsubscription.vezaone.com/";

  @override
  // TODO: implement notificationUrl
  get notificationUrl => null;

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
  get meetingBaseUrl => "https://testmeet.cubeonebiz.com/api/v1/";

  /*TODO - Add client secret*/
  @override
  get meetingClientSecret => "";

  /*TODO - Add client id*/
  @override
  get meetingClientId => "";

  @override
  get meetingDomain => "testmeet.cubeonebiz.com";

  /*TODO - Add App Id*/
  @override
  get meetingAppId => -1;

  @override
  // TODO: implement iplUrl
  get iplUrl => "https://testquiz.cubeonebiz.com/api/v1";
}
