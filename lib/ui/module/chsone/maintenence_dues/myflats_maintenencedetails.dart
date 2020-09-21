import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/invoicing/myFlatsMaintenenceDetails_view.dart';
import 'package:sso_futurescape/presentor/module/chsone/invoicing/myflats_maintenencedetails_presenter.dart';
import 'package:sso_futurescape/ui/module/chsone/maintenence_dues/PerticularWidget.dart';
import 'package:sso_futurescape/ui/module/chsone/maintenence_dues/maintenence_overdue.dart';
import 'package:sso_futurescape/ui/module/chsone/maintenence_dues/perticualr_total_widget.dart';
import 'package:sso_futurescape/ui/module/error/no_internet.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class MyFlatsMaintenenceDetails extends StatefulWidget {
  var maintenence;
  BILLTYPE billType;

  var unitId;

  MyFlatsMaintenenceDetails(maintenence, billType, unitId) {
    this.maintenence = maintenence;
    this.billType = billType;
    this.unitId = unitId;
  }

  @override
  _MyFlatsMaintenenceDetailsState createState() =>
      _MyFlatsMaintenenceDetailsState(maintenence, billType, unitId);
}

class _MyFlatsMaintenenceDetailsState extends State<MyFlatsMaintenenceDetails>
    implements MyFlatsMaintenenceDetailsView {
  MyFlatsMaintenencedetailsPresnter _invoicePresenter;
  var invoice;
  String unit_id;
  bool isLoading = true;
  var metadata;
  var invoiceNumber;
  BILLTYPE billType;

  var unitId;

  _MyFlatsMaintenenceDetailsState(this.invoiceNumber, this.billType,
      this.unitId);

  var socData;

  void initState() {
    _invoicePresenter = new MyFlatsMaintenencedetailsPresnter(this);

    ChsoneStorage.getSocietyDetails().then((data) {
      setState(() {
        socData = data;
      });
    });
    _invoicePresenter.getInvoice(invoiceNumber, billType, unitId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.primaryflat,
        title: Text(
          "#" + invoiceNumber,
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
        actions: <Widget>[
          Container(
            width: 50,
            child: FlatButton(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Icon(FlutterIcon.download_1,
                  size: FSTextStyle.h6size, color: FsColor.white),
              onPressed: () => {_downloadFile(invoice)},
            ),
          )
        ],
      ),
      body: isLoading
          ? PageLoader()
          : SingleChildScrollView(
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
                            // 'Long Lorem Ipsum Housing Complex',
                            socData["soc_name"] == null
                                ? " "
                                : socData["soc_name"].toString(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: FSTextStyle.h4size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.primaryflat),
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
                            socData["soc_address_1"] == null
                                ? " "
                                : socData["soc_address_1"].toString(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.darkgrey),
                          ),
                          Text(
                            socData["soc_address_2"] == null
                                ? " "
                                : socData["soc_address_2"].toString(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.darkgrey),
                          ),
                        ],
                      )),
                  Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            getSocietyFullAddress(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h7size,
                                fontFamily: 'Gilroy-Regular',
                                color: FsColor.darkgrey),
                          ),
                        ],
                      )), Container(
                      margin: EdgeInsets.fromLTRB(0, 15, 0, 5


                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "invoicing peroid",
                            style: TextStyle(
                                fontSize: FSTextStyle.h4size,
                                fontFamily: 'Gilroy-Regular',
                                color: FsColor.darkgrey),
                          ),
                        ],
                      )),
                  Container(

                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            invoice['arrInvoiceDetails']['from_date'] +
                                " - " +
                                invoice['arrInvoiceDetails']['to_date'],
                            style: TextStyle(
                                fontSize: FSTextStyle.h5size,
                                fontFamily: 'Gilroy-Bold',
                                color: FsColor.darkgrey),
                          ),
                        ],
                      )),
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
                              'Name'.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['arrInvoiceDetails']['bill_to'] ==
                                  null
                                  ? "-"
                                  : invoice['arrInvoiceDetails']
                              ['bill_to']
                                  .toLowerCase(),
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
                              'Invoice No.'.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['arrInvoiceDetails']
                              ['invoice_number'],
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
                              'GSTIN/UIN'.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['arrInvoiceDetails']
                              ['member_gstin'] ==
                                  null
                                  ? "-"
                                  : invoice['arrInvoiceDetails']
                              ['member_gstin']
                                  .toString()
                                  .toLowerCase(),
                              //  invoice['arrInvoiceDetails']['member_gstin'].toLowerCase(),
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
                              'Invoice Date'.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['arrInvoiceDetails']
                              ['invoice_date'],
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
                              'Parking Unit'.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['arrInvoiceDetails']
                              ['parking_number'] ==
                                  null
                                  ? '-'
                                  : invoice['arrInvoiceDetails']
                              ['parking_number']
                                  .toString(),
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
                              'Due Date'.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['arrInvoiceDetails']['due_date'] ==
                                  null
                                  ? '-'
                                  : invoice['arrInvoiceDetails']
                              ['due_date'],
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
                  billType == BILLTYPE.MAINTANCE ?
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
                              'Buildup Area'.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['arrInvoiceDetails']['unit_area'] ==
                                  null
                                  ? '-'
                                  : invoice['arrInvoiceDetails']
                              ['unit_area'] +
                                  'sqft',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.darkgrey),
                            ),
                          ],
                        ),
                        /*Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Invoicing Period'.toLowerCase(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.lightgrey),
                                  ),
                                  Text(
                                    invoice["arrInvoiceDetails"]["from_date"] +" - "+
                                        invoice["arrInvoiceDetails"]["to_date"],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.darkgrey),
                                  ),
                                ],
                              ),*/
                      ],
                    ),
                  ) : Container(),

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
                              'Unit no'.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['arrInvoiceDetails']['building_unit']
                                  .toString(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.darkgrey),
                            ),
                          ],
                        ),
                        /*Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    'Invoicing Period'.toLowerCase(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.lightgrey),
                                  ),
                                  Text(
                                    invoice["arrInvoiceDetails"]["from_date"] +" - "+
                                        invoice["arrInvoiceDetails"]["to_date"],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.darkgrey),
                                  ),
                                ],
                              ),*/
                      ],
                    ),
                  )
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
                  children: _particularRender(),
                ),
              ),
            ),
            Container(
              transform: Matrix4.translationValues(0.0, -60.0, 0.0),
              padding: EdgeInsets.all(15),
              child: Column(
                children: <Widget>[
                  invoice['bank_details'] == null
                      ? Container()
                      : Container(
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'E-collect (VPA) Pay Via Netbanking : '
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.basicprimary),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: <Widget>[
                            Text(
                              'Account Name. : '.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['bank_details'] == null
                                  ? '-'
                                  : invoice['bank_details']
                              ['account_name']
                                  .toString()
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.darkgrey),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: 
                            invoice['bank_details']['bank_name'] == null
                                  ?<Widget>[Container(width:0,height:0)]
                                  :<Widget>[ 
                            Text(
                              'Bank Name. : '.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['bank_details'] == null
                                  ? '-'
                                  : invoice['bank_details']
                              ['bank_name']
                                  .toString()
                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.darkgrey),
                            ),
                          ],
                        ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Text(
                              'Account No. : '.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['bank_details'] == null
                                  ? '-'
                                  : invoice['bank_details']
                              ['account_number']
                                  .toString(),
//                                  .toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.darkgrey),
                            ),
                          ],
                        ),
                        // SizedBox(height: 5),
                        // Row(
                        //   children: <Widget>[
                        //     Text(
                        //       'Account type : '.toLowerCase(),
                        //       textAlign: TextAlign.left,
                        //       style: TextStyle(
                        //           fontSize: FSTextStyle.h6size,
                        //           fontFamily: 'Gilroy-SemiBold',
                        //           color: FsColor.lightgrey),
                        //     ),
                        //     Text(
                        //       'Current'.toLowerCase(),
                        //       textAlign: TextAlign.left,
                        //       style: TextStyle(
                        //           fontSize: FSTextStyle.h6size,
                        //           fontFamily: 'Gilroy-SemiBold',
                        //           color: FsColor.darkgrey),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 5),
                        Row(
                          children: <Widget>[
                            Text(
                              'IFSC : '.toLowerCase(),
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            Text(
                              invoice['bank_details'] == null
                                  ? '-'
                                  : invoice['bank_details']
                              ['bank_ifsc']
                                  .toString(),
//                                  .toLowerCase(),
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 10),
                    child: Column(
                      children: getNote(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  clearList() {
    return null;
  }

  @override
  onError(error) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
    setState(() {
      isLoading = false;
    });
  }

  @override
  onFailure(failed) {
    Toasly.error(context, AppUtils.errorDecoder(failed));
    setState(() {
      isLoading = false;
    });
  }

  @override
  onInvoiceFound(invoice) {
    if (invoice["data"]["particular_header"][0]['name'] == "Sr No") {
      invoice["data"]["particular_header"].removeAt(0);
      for (var i = 0; i < invoice["data"]["particular_value"].length; i++) {
        invoice["data"]["particular_value"][i].removeAt(0);
      }
    }
    this.invoice = invoice["data"];
    setState(() {
      isLoading = false;
    });
  }

  List<Widget> _particularRender() {
    List<Widget> widget = [];
    Widget heading = Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: FsColor.primaryflat.withOpacity(0.1),
          border: Border(
            bottom: BorderSide(
                width: 1.0, color: FsColor.basicprimary.withOpacity(0.2)),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Particular'.toLowerCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-Bold',
                color: FsColor.basicprimary),
          ),
          Text(
            'Amount'.toLowerCase(),
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-Bold',
                color: FsColor.basicprimary),
          ),
        ],
      ),
    );
    widget.add(heading);
    for (var i = 0; i < invoice['particular_value'].length; i++) {
      widget.add(PerticualrsWidget(
          invoice['particular_header'], invoice['particular_value'][i]));
    }

    var invoiceAmountDetail = invoice['invoice_amount_detail'];

    Widget heading3 = PerticualrTotalWidget(billType, invoiceAmountDetail);

    Widget heading4 = Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 1.0, color: FsColor.basicprimary.withOpacity(0.2)),
          )),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Amount in Words : '.toLowerCase(),
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.lightgrey),
          ),
          Flexible(
            child: Text(
              invoiceAmountDetail['amount_in_words'] == null
                  ? "-"
                  : invoiceAmountDetail['amount_in_words']
                  .toString()
                  .toLowerCase(),
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: FSTextStyle.h6size,
                  fontFamily: 'Gilroy-SemiBold',
                  color: FsColor.darkgrey),
            ),
          ),
        ],
      ),
    );

    widget.add(heading3);
    widget.add(heading4);

    return widget;
  }

  getNote() {
    List<Widget> widget = [];
    Widget row = SizedBox(height: 5);
    widget.add(row);
    for (var i = 0; i < invoice['arrInvoiceGeneralSetting'].length; i++) {
      Widget notesRow = Row(
        children: <Widget>[
          Text(
            '',
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-Bold',
                color: FsColor.darkgrey),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Text(
              invoice['arrInvoiceGeneralSetting'][i] == null
                  ? "-"
                  : invoice['arrInvoiceGeneralSetting'][i]
                  .toString()
                  .toLowerCase(),
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: FSTextStyle.h6size,
                  fontFamily: 'Gilroy-Regular',
                  color: FsColor.darkgrey),
            ),
          )
        ],
      );
      widget.add(notesRow);
    }
    return widget;
  }

  _downloadFile(var url) {
    print(url['invoice_amount_detail']['downloaded_link']);
    _launchUrlWithUrl(url['invoice_amount_detail']['downloaded_link']);
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

  String getSocietyFullAddress() {
    String fullAddress = "";
    if (socData["soc_landmark"] != null &&
        socData["soc_landmark"].toString().trim() != "") {
      fullAddress = fullAddress + socData["soc_landmark"];
    }

    if (socData["soc_city_or_town"] != null &&
        socData["soc_landmark"].toString().trim() != "") {
      fullAddress = fullAddress + "," + socData["soc_city_or_town"];
    }

    if (socData["soc_state"] != null &&
        socData["soc_state"].toString().trim() != "") {
      fullAddress = fullAddress + "," + socData["soc_state"];
    }

    if (socData["soc_pincode"] != null) {
      fullAddress = fullAddress + "," + socData["soc_pincode"].toString();
    }
    return fullAddress;
  }
}
