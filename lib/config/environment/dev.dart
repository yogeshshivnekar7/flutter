import 'config.dart';

class Dev extends Config {
  @override
  get build_variant => 'dev';

  @override
  get url => "chsone.in";

  @override
  // TODO: implement chsoneApiUrl
  get chsoneApiUrl => null;

  @override
  // TODO: implement chsoneClientId
  get chsoneClientId => null;

  @override
  // TODO: implement chsoneClientSecret
  get chsoneClientSecret => null;

  @override
  // TODO: implement ssoApiKey
  get ssoApiKey => null;

  @override
  // TODO: implement ssoAuthUrl
  get ssoAuthUrl => null;

  @override
  // TODO: implement ssoClientId
  get ssoClientId => null;

  @override
  // TODO: implement ssoClientSecret
  get ssoClientSecret => null;

  @override
  // TODO: implement chsoneResidentUrl
  get chsoneResidentUrl => null;

  @override
  // TODO: implement vizlogAppUrl
  get vizlogAppUrl => null;

  @override
  // TODO: implement vizlog_app_id
  get vizlogAppId => null;

  @override
  // TODO: implement vizlog_app_id
  get hrmsAppId => null;

  @override
  get chsoneAppId => null;

  @override
  get restoApiUrl => null;

  @override
  get chsoneWebUrl => throw UnimplementedError();

  @override
  get vizlogClientId => null;

  @override
  get vizlogClientSecret => null;

  @override
  get tiffin_image_logo =>
      'http://s3-ap-southeast-1.amazonaws.com/fdc01.fooddialer.in';

  @override
  setUpVersions() {
    return {"android": 3, "ios": 3, "web": 1};
  }

  @override
  get vezaPlugInUrl => throw UnimplementedError();

  @override
  get chsoneRequestUrl => null;

  @override
  // TODO: implement crm_api_key
  get crm_api_key => null;

  @override
  // TODO: implement getOneAppId
  get getOneAppId => "2";

  @override
  // TODO: implement hrmsClientId
  get hrmsClientId => null;

  @override
  // TODO: implement hrmsClientSecret
  get hrmsClientSecret => null;

  @override
  // TODO: implement vezaGroceryPlugInUrl
  get vezaGroceryPlugInUrl => null;

  @override
  get name => "dev";

  @override
  // TODO: implement account_url
  get account_url => 'https://stgaccount.cubeoneapp.com/login';

  @override
  // TODO: implement ecollectKey
  get ecollectKey => throw UnimplementedError();

  @override
  // TODO: implement nodeUrl
  get nodeUrl => null;

  @override
  // TODO: implement subscriptionPlugInUrl
  get subscriptionPlugInUrl => throw UnimplementedError();

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
  // TODO: implement moneyUrl
  get moneyUrl => throw UnimplementedError();

  @override
  // TODO: implement serverApiKey
  get serverApiKey => throw UnimplementedError();

  @override
  // TODO: implement meetingBaseUrl
  get meetingBaseUrl => throw UnimplementedError();

  @override
  // TODO: implement meetingClientId
  get meetingClientId => throw UnimplementedError();

  @override
  // TODO: implement meetingClientSecret
  get meetingClientSecret => throw UnimplementedError();

  @override
  // TODO: implement meetingDomain
  get meetingDomain => throw UnimplementedError();

  @override
  // TODO: implement iplUrl
  get iplUrl => throw UnimplementedError();

  @override
  // TODO: implement meetingAppId
  get meetingAppId => throw UnimplementedError();
}
