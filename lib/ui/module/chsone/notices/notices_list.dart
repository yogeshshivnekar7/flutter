import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/chsone/notices/notice_list_presenter.dart';
import 'package:sso_futurescape/presentor/module/chsone/notices/notice_view.dart';
import 'package:sso_futurescape/ui/module/chsone/notices/notices_details.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class NoticesList extends StatefulWidget {
  var currentUnit;
  NOTICE_TYPE noticeType;
  var title;

  NoticesList(this.currentUnit, this.noticeType, this.title);

  @override
  _NoticesListState createState() =>
      new _NoticesListState(currentUnit, noticeType, title);
}

class _NoticesListState extends State<NoticesList>
    implements PageLoadListener, NoticeView {
  ListNoticePresenter presentor;
  FsListState listListner;
  List notices = [];
  bool isLoading = false;
  var currentUnit;
  NOTICE_TYPE noticeType;
  String title;

  _NoticesListState(this.currentUnit, this.noticeType, this.title);

  @override
  void initState() {
    super.initState();
    presentor = new ListNoticePresenter(this);
    _getNotices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          title.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 1.0,
        backgroundColor: FsColor.primaryflat,
        leading: FsBackButtonlight(),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),

        child: Center(child: FsListWidget(
            title: false,
            message: FsString.NO_NOTICE_ANNOUNCEMENT,
            pageLoadListner: this,
            itemBuilder: (BuildContext context, int index, var item) {
              // Map notice = notices[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Card(
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    // side:BorderSide(color: FsColor.lightgrey, width: 1.0),
                  ),
                  child: InkWell(
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
                      child: Column(
                        children: <Widget>[
                          Container(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      text: "Subject : ".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.lightgrey),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${item["subject"].toString()}'
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize: FSTextStyle.h5size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.primaryflat),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 10.0, 0, 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "ref no. : ".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.lightgrey),
                                    ),
                                    Text(
                                      '${item["notice_ref_no"]}'
                                          .toString()
                                          .toLowerCase(),
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
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                            decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                      width: 1.0,
                                      color: FsColor.basicprimary.withOpacity(
                                          0.2)),
                                )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Date : ".toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.lightgrey),
                                      ),
                                      Text(
                                        '${item["published_on"]}'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Text(
                                        "Type : ".toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.lightgrey),
                                      ),
                                      Text(
                                        '${item["type"]}'.toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                NoticesDetails(item["notice_id"])),
                      );
                    },
                  ),
                ),
              );
            },
            afterView: (FsListState v) {
              listListner = v;
              /* Timer(Duration(milliseconds: 100), () {
                    setState(() {
                      listListner.addListList({
                        "total": 8,
                        "per_page": 10,
                        "current_page": 1,
                        "last_page": 1,
                        "from": 1,
                        "to": 10
                      }, notices);
                    });
                  });*/
            }),)
        ,
      ),
    );
  }

  @override
  lastPage(int page) {
    // TODO: implement lastPage
  }

  @override
  loadNextPage(String page) {
    _getNotices(page: page);
  }

  void _getNotices({page}) {
    try {
      if (noticeType == NOTICE_TYPE.NOTICE) {
        print("in notice====================>");
        presentor.getNoticeList(currentUnit, noticeType: "notice", page: page);
      } else if (noticeType == NOTICE_TYPE.ANNOUNCEMENT) {
        print("in announcement====================>");
        presentor.getNoticeList(currentUnit,
            noticeType: "announcement", page: page);
      } else if (noticeType == NOTICE_TYPE.ALL) {
        print("in announcement====================>");
        presentor.getNoticeList(currentUnit,
            page: page);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onErrorListNotice(error) {
    listListner.notItems();
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  void onFailureListNotice(failure) {
    listListner.notItems();
    print(failure);
    Toasly.error(context, AppUtils.errorDecoder(failure));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void onSuccessListNotice(matedata, allNoticeList) {
    print(allNoticeList);
    listListner.addListList(matedata, allNoticeList);
    setState(() {});
  }
}

enum NOTICE_TYPE { NOTICE, ANNOUNCEMENT, ALL }
