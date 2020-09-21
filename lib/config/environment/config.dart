// only config part

//region

import 'package:common_config/utils/application.dart';

abstract class Config {
  get nodeUrl;

  get build_variant;

  get url;

  get account_url;

  get ssoClientSecret;

  get getOneAppId;

  get ssoClientId;

  get ssoAuthUrl;

  get chsoneClientId;

  get hrmsClientId;

  get chsoneClientSecret;

  get hrmsClientSecret;

  String get ssoApiKey;

  get chsoneApiUrl;

  get restoApiUrl;

  get chsoneResidentUrl;

  get vizlogAppUrl;

  get pyna_wine_company_Id;
  get vizlogAppId;

  get chsoneAppId;

  get hrmsAppId;

  get chsoneWebUrl;

  get vizlogClientId;

  get vizlogClientSecret;

  get vezaPlugInUrl;

  get vezaGroceryPlugInUrl;

  get chsoneRequestUrl;

  get tiffin_image_logo;

  get crm_api_key;

  get name;

  get ecollectKey;

  get subscriptionPlugInUrl;

  get notificationUrl;

  get recipeUrl;

  get serverApiKey;

  get moneyUrl;

  get iplUrl;

  get meetingBaseUrl;

  get meetingClientId;

  get meetingClientSecret;

  get meetingDomain;

  get meetingAppId;

  FsPlatforms geCurrentPlatForm() {
    print("-------------------------------cugeCurrentPlatFormig----");
    return FsPlatform.getPlatform();
  }

  @override
  double getCurrentVersion() {
    var a = setUpVersions();
    print("-------------------------------current config----$a");
    FsPlatforms plat = geCurrentPlatForm();
    print("-------------------------------current config----$plat");
    if (FsPlatforms.ANDROID == plat) {
      return a["android"];
    } else if (FsPlatforms.IOS == plat) {
      return a["ios"];
    } else {
      return a["web"];
    }
    return plat == FsPlatforms.ANDROID
        ? double.parse(a["android"])
        : plat == FsPlatforms.IOS
        ? double.parse(a["ios"])
        : double.parse(a["web"]);
//    print("----------version ---------------$v");
//    return v;
  }

  setUpVersions();


}
