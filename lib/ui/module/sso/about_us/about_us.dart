import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';

class AboutUsScreenPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AboutUsState();
  }
}

class AboutUsState extends State<AboutUsScreenPage> {
  BuildContext context;
  String application_version;
  String app_environment;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getApplicationVersion();
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    Network.context = context;
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: FsBackButton(),
      ),
      resizeToAvoidBottomPadding: false,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'images/logo.png',
                  fit: BoxFit.contain,
                  height: 75.0,
                  width: 250.0,
                ),
                Text(
                  'Digital Community'.toLowerCase(),
                  style: TextStyle(
                      fontFamily: 'Gilroy-Regular',
                      letterSpacing: 1.0,
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.darkgrey),
                ),
                SizedBox(height: 8),
                app_environment == null || app_environment == 'production'
                    ? Container()
                    : Text(
                        'Environment-  ${AppUtils.capitalize(app_environment)}'
                            .toLowerCase(),
                        style: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            letterSpacing: 1.0,
                            fontSize: FSTextStyle.h7size,
                            color: FsColor.darkgrey),
                      ),
                Text(
                  'Version  $application_version'.toLowerCase(),
                  style: TextStyle(
                      fontFamily: 'Gilroy-Regular',
                      letterSpacing: 1.0,
                      fontSize: FSTextStyle.h7size,
                      color: FsColor.darkgrey),
                )
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'from',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        letterSpacing: 1.0,
                        fontSize: FSTextStyle.h7size,
                        color: FsColor.darkgrey),
                  ),
                  GestureDetector(
                    child: Text(
                      'Futurescape',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Bold',
                          letterSpacing: 1.0,
                          fontSize: FSTextStyle.h5size,
                          color: FsColor.basicprimary),
                    ),
                    onTap: () {
                      /* print("dsdsds");*/
                      // String accessToken = jsonDecode["data"]["access_token"];
                      /*AppModel appModel=new AppModel();
                      appModel.deviceRegister((){
                        print("Device Registre");
                      }, (s){
                        print("Device Fauiled");
                      });*/
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getApplicationVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print(appName);
    print(packageName);
    print(version);
    print(buildNumber);
    setState(() {
      application_version = version;
      app_environment = Environment().getCurrentConfig().build_variant;
    });
  }
}
