import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/notices/notice_details_presenter.dart';
import 'package:sso_futurescape/presentor/module/chsone/notices/notice_view.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class NoticesDetails extends StatefulWidget {
  var noticeId;

  NoticesDetails(this.noticeId);

  @override
  _NoticesDetailsState createState() => _NoticesDetailsState(noticeId);
}

class _NoticesDetailsState extends State<NoticesDetails>
    implements NoticeDetailsView {
  var noticeId;
  var noticeData;
  bool isLoading = true;
  NoticeDetailPresenter presentor;

  _NoticesDetailsState(this.noticeId);

  var socData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    presentor = new NoticeDetailPresenter(this);
    _getNoticeDetail(noticeId);
    ChsoneStorage.getSocietyDetails().then((data) {
      setState(() {
        socData = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.primaryflat,
        title: Text(
          noticeData == null
              ? "Loading..."
              : noticeData["notice_ref_no"].toString(),
          // noticeData["notice_ref_no"] == null?"-":noticeData["notice_ref_no"].toString(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
        actions: <Widget>[
          /*Container(
            width: 50,
            child: FlatButton(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Icon(FlutterIcon.print_1,
                  size: FSTextStyle.h6size, color: FsColor.white),
              onPressed: () {},
            ),
          )*/
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 50.0),
              color: FsColor.lightgreybg.withOpacity(0.25),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            socData == null
                                ? " "
                                : socData["soc_name"].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: FSTextStyle.h4size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.basicprimary),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            socData == null
                                ? " "
                                : socData["soc_address_1"].toString(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h7size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.darkgrey),
                          ),
                          Text(
                            socData == null
                                ? " "
                                : " ${socData["soc_address_2"].toString()}",
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.darkgrey),
                          ),
                        ],
                      )),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                    alignment: Alignment.center,
                    child: RichText(
                      text: TextSpan(
                        text: "Subject : ".toLowerCase(),
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-SemiBold',
                            color: FsColor.lightgrey),
                        children: <TextSpan>[
                          TextSpan(
                            text: noticeData == null
                                ? "Loading..."
                                : noticeData["subject"].toString(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-Bold',
                                color: FsColor.darkgrey),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Reference No.'.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              noticeData == null
                                  ? "Loading..."
                                  : noticeData["notice_ref_no"].toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.darkgrey),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Date'.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              noticeData == null
                                  ? "Loading..."
                                  : noticeData["published_on"].toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.darkgrey),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              transform: Matrix4.translationValues(0.0, -45.0, 0.0),
              child: Card(
                elevation: 1.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4.0),
                  ),
                ),
                child: Column(
                  children: <Widget>[

                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: FsColor.primaryflat.withOpacity(0.1),
                          border: Border(
                            bottom: BorderSide(
                                width: 1.0,
                                color: FsColor.basicprimary.withOpacity(0.2)),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          RichText(

                            text: TextSpan(
                              text: "type : ".toLowerCase(),
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                              children: <TextSpan>[

                                TextSpan(
                                  text: noticeData == null
                                      ? "Loading..."
                                      : noticeData["type"]
                                      .toString()
                                      .toLowerCase(),
                                  style: TextStyle(

                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-Bold',
                                      color: FsColor.basicprimary),
                                ),
                              ],
                            ),
                          ),
                          /* RichText(
                            text: TextSpan(
                              text: "Date : ".toLowerCase(),
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                              children: <TextSpan>[
                                TextSpan(
                                  text: noticeData == null
                                      ? "Loading..."
                                      : noticeData["published_on"]
                                      .toString()
                                      .toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-Bold',
                                      color: FsColor.basicprimary),
                                ),
                              ],
                            ),
                          ),*/
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          /* Text(
                            noticeData == null
                                ? "Loading..."
                                : """${noticeData["body"].toString()  }""",
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-Regular',
                                color: FsColor.basicprimary),
                          ),*/Html(data:
                          noticeData == null
                              ? "Loading..."
                              : noticeData["body"].toString(),
                            onLinkTap: (url) {
                              print("Opening $url...");
//                              AppUtils.downloadFile(url);
                              AppUtils.launchUrlWithUrl(url);
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getNoticeDetail(noticeId) {
    try {
      presentor.getNoticeDetail(noticeId);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onErrorDetailNotice(response) {
    setState(() {
      isLoading = false;
    });
    print(response);
  }

  @override
  void onFailureDetailNotice(response) {
    // setState(() {
    //   isLoading = false;
    // });
    print(response);
    // print("++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++");
  }

  @override
  void onSuccessDetailNotice(response) {
    print("sucesssss=====================>");
    if (response != null) {
      this.noticeData = response;
      setState(() {
        isLoading = false;
      });
    }
  }
}
