import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/chsone/receipt/receipt_presenter.dart';
import 'package:sso_futurescape/presentor/module/chsone/receipt/receipt_view.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/list_widget.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class MyFlatsReceiptsList extends StatefulWidget {
  String unit_id;

  @override
  _MyFlatsReceiptsListState createState() =>
      new _MyFlatsReceiptsListState(unit_id);

  MyFlatsReceiptsList(this.unit_id);
}

class _MyFlatsReceiptsListState extends State<MyFlatsReceiptsList>
    implements ReceiptView, PageLoadListener {
  ReceiptPresenter _receiptPresenter;

  String unit_id;
  bool isLoading = true;

  FsListState listListner;

  @override
  void initState() {
    print('unit_id  $unit_id');
    _receiptPresenter = new ReceiptPresenter(this);
    super.initState();
    _receiptPresenter.getReceipts(unit_id,
        is_pagination: '1', page: "1", per_page: '10');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Receipts'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 1.0,
        backgroundColor: FsColor.primaryflat,
        leading: FsBackButtonlight(),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Center(
          child: FsListWidget(
              title: false,
              message: FsString.NO_RECIEPT,
              pageLoadListner: this,
              itemBuilder: (BuildContext context, int index, var item) {
                return getChildItem(item);
              },
              afterView: (v) {
                listListner = v;
              }),
        )
        ,
      ),
    );
  }

  _downloadFile(var url) {
    print(url);
    _launchUrlWithUrl(url["download_link"]);
  }

  Future<void> _launchUrlWithUrl(String url) async {
    /* try {
      print(url);
      if (await canLaunch(url)) {
        await launch(url);
      } else {}
    } catch (e) {
      print(e);
    }*/
    AppUtils.downloadFile(url);
  }

  Padding getChildItem(var receipt) {
    print(receipt);
    var childItem = Padding(
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
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "receipt no. : ".toLowerCase(),
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.lightgrey),
                        ),
                        Text(
                          '#${receipt["receipt_number"]}',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.primaryflat),
                        ),
                      ],
                    ),
                    Text(
                      receipt["payment_date"] == null
                          ? ""
                          : receipt["payment_date"].toLowerCase(),
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.darkgrey),
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Payment of : ".toLowerCase(),
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-SemiBold',
                            color: FsColor.lightgrey),
                      ),
                      Flexible(
                        child: Text(
                          '${receipt["bill_type"]}'.toLowerCase(),
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.darkgrey),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        "Amount : ".toLowerCase(),
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-SemiBold',
                            color: FsColor.lightgrey),
                      ),
                      Icon(FlutterIcon.rupee,
                          color: FsColor.darkgrey, size: FSTextStyle.h6size),
                      Text(
                        AppUtils.doubleFormat(receipt["payment_amount"]),
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-SemiBold',
                            color: FsColor.darkgrey),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0.0, 10.0, 0, 0.0),
                  decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            width: 1.0,
                            color: FsColor.basicprimary.withOpacity(0.2)),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Paid by : ".toLowerCase(),
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              "${receipt["full_name"]}".toLowerCase(),
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
                            receipt["display_status"] != "cleared"
                                ? Text(
                              receipt["display_status"].toLowerCase(),
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.darkgrey),
                            )
                                : FlatButton(
                              shape: new RoundedRectangleBorder(
                                borderRadius:
                                new BorderRadius.circular(4.0),
                              ),
                              onPressed: () =>
                              {
                                _downloadFile(receipt)
                              },
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 0.0),
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    "Download",
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-Bold',
                                        color: FsColor.darkgrey),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(FlutterIcon.download_1,
                                      color: FsColor.darkgrey,
                                      size: FSTextStyle.h6size),
                                ],
                              ),
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
          onTap: null,
        ),
      ),
    );
    return childItem;
  }

  _MyFlatsReceiptsListState(this.unit_id);

  @override
  clearList() {
    listListner.clearList();
  }

  @override
  onError(error) {
    listListner.notItems();
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  onFailure(failure) {
    listListner.notItems();
    print(failure);
    Toasly.error(context, AppUtils.errorDecoder(failure));
    setState(() {
      isLoading = false;
    });
  }

  @override
  onReceiptFound(receiptList) {
    var metadata = receiptList['data']['metadata'];
    List receiptList2 = receiptList["data"]["results"];
    listListner.addListList(metadata, receiptList2);
  }

  @override
  lastPage(int page) {}

  @override
  loadNextPage(String pageNumber) {
    _receiptPresenter.getReceipts(unit_id,
        is_pagination: '1', page: pageNumber, per_page: '10');
  }
}
