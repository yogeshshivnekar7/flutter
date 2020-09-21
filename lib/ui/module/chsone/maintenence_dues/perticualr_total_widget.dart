import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/maintenence_dues/maintenence_overdue.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class PerticualrTotalWidget extends StatelessWidget {
  var invoiceAmountDetail;
  BILLTYPE billtype;

  PerticualrTotalWidget(this.billtype, this.invoiceAmountDetail);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
            width: 1.0, color: FsColor.basicprimary.withOpacity(0.2)),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 200,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Invoice Total'.toLowerCase(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.lightgrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(FlutterIcon.rupee,
                            size: FSTextStyle.h6size, color: FsColor.darkgrey),
                        Text(
                          invoiceAmountDetail['invoice_amount'] == null
                              ? '-'
                              : invoiceAmountDetail['invoice_amount']
                                  .toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.basicprimary),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Total Tax'.toLowerCase(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.lightgrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(FlutterIcon.rupee,
                            size: FSTextStyle.h6size, color: FsColor.darkgrey),
                        Text(
                          invoiceAmountDetail['tax_amount'] == null
                              ? '-'
                              : '(+)' +
                                  invoiceAmountDetail['tax_amount'].toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.darkgrey),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Credit Adjustment'.toLowerCase(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.lightgrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(FlutterIcon.rupee,
                            size: FSTextStyle.h6size, color: FsColor.darkgrey),
                        Text(
                          invoiceAmountDetail['advance_paid'] == null
                              ? '-'
                              : '(-)' +
                                  invoiceAmountDetail['advance_paid']
                                      .toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.darkgrey),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Grand Total'.toLowerCase(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.lightgrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(FlutterIcon.rupee,
                            size: FSTextStyle.h6size, color: FsColor.darkgrey),
                        Text(
                          invoiceAmountDetail['grand_total'] == null
                              ? '-'
                              : invoiceAmountDetail['grand_total'].toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.basicprimary),
                        ),
                      ],
                    ),
                  ],
                ),
                billtype == BILLTYPE.MAINTANCE
                    ? SizedBox(height: 5)
                    : Container(),
                billtype == BILLTYPE.MAINTANCE
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Principal Arrears'.toLowerCase(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.lightgrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(FlutterIcon.rupee,
                            size: FSTextStyle.h6size,
                            color: FsColor.darkgrey),
                        Text(
                          invoiceAmountDetail['principal_arrears'] == null
                              ? '-'
                              : '(+)' +
                              invoiceAmountDetail['principal_arrears']
                                  .toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.darkgrey),
                        ),
                      ],
                    ),
                  ],
                )
                    : Container(),
                billtype == BILLTYPE.MAINTANCE
                    ? SizedBox(height: 5)
                    : Container(),
                billtype == BILLTYPE.MAINTANCE
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Interest Arrears'.toLowerCase(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.lightgrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(FlutterIcon.rupee,
                            size: FSTextStyle.h6size,
                            color: FsColor.darkgrey),
                        Text(
                          invoiceAmountDetail['interest_arrears'] == null
                              ? '-'
                              : '(+)' +
                              invoiceAmountDetail['interest_arrears']
                                  .toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.darkgrey),
                        ),
                      ],
                    ),
                  ],
                )
                    : Container(),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Balance Dues'.toLowerCase(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.lightgrey),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(FlutterIcon.rupee,
                            size: FSTextStyle.h6size, color: FsColor.darkgrey),
                        Text(
                          invoiceAmountDetail['total_due'] == null
                              ? '-'
                              : invoiceAmountDetail['total_due'].toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.basicprimary),
                        ),
                      ],
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
}
