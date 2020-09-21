import 'package:common_config/utils/application.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/paymethod_data.dart';

class PayConfigurePage extends StatefulWidget {
  @override
  PayConfigurePageState createState() => new PayConfigurePageState();
}

class PayConfigurePageState extends State<PayConfigurePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: FsColor.primaryflat,
        elevation: 0.0,
        title: new Text(
          'Payment'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
      ),
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  alignment: Alignment.center,
                  child: Text(
                    'Choose Your Bank to See the Process'.toLowerCase(),
                    style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.darkgrey,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: ListView.builder(
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                        payconfigure == null ? 0 : payconfigure.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map bank = payconfigure[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                                side: BorderSide(
                                    color: FsColor.lightgrey, width: 1.0),
                              ),
                              elevation: 0.0,
                              child: InkWell(
                                child: Container(
                                  padding: const EdgeInsets.only(
                                    bottom: 15.0,
                                    top: 15.0,
                                  ),
                                  // height: 85,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(width: 10),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          "${bank["img"]}",
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Expanded(
                                        child: ListView(
                                          primary: false,
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Container(
                                              alignment: Alignment.centerLeft,
                                              child: RichText(
                                                  text: TextSpan(
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .body1,
                                                      children: [
                                                        TextSpan(
                                                          text: '${bank["name"]}'
                                                              .toLowerCase(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                            'Gilroy-SemiBold',
                                                            fontSize:
                                                            FSTextStyle.h6size,
                                                            color: FsColor
                                                                .basicprimary,
                                                          ),
                                                        ),
                                                      ])),
                                            ),
                                            SizedBox(height: 5),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          "images/play-icon.png",
                                          height: 36,
                                          width: 36,
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  _launchURL(bank["youtube_link"]);
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _launchURL(String youtube_url) async {
    if (Environment().getCurrentPlatform() == FsPlatforms.IOS) {
      if (await AppUtils.canLaunchUrl(youtube_url)) {
        await AppUtils.launchUrl(youtube_url, forceSafariVC: false);
      } else {
        if (await AppUtils.canLaunchUrl(youtube_url)) {
          await AppUtils.launchUrl(youtube_url);
        } else {
          throw 'Could not launch https://www.youtube.com/channel/UCwXdFgeE9KYzlDdR7TG9cMw';
        }
      }
    } else {
      //const url = youtube_url;
      if (await AppUtils.canLaunchUrl(youtube_url)) {
        await AppUtils.launchUrl(youtube_url);
      } else {
        throw 'Could not launch $youtube_url';
      }
    }
  }
}
