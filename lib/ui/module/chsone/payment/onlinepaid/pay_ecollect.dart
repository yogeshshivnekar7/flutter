import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/onlinepaid/pay_configure.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class PayEcollectPage extends StatefulWidget {
  var vapDetails;

  PayEcollectPage(this.vapDetails);

  @override
  PayEcollectPageState createState() =>
      new PayEcollectPageState(this.vapDetails);
}

class PayEcollectPageState extends State<PayEcollectPage> {
  var vapDetails;
  String vpaOption = "";
  String socName;

  PayEcollectPageState(s) {
    vapDetails = s["extra_data"];
    vpaOption = s["value"];
    print("sssss");
    print(s);
    print(vpaOption);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ChsoneStorage.getSocietyDetails().then((socDetails) {
      socName = socDetails["soc_name"].toString();
      setState(() {});
    });
  }

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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
              child: Column(
                children: <Widget>[
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(width: 5.0),
                        Container(
                          alignment: Alignment.center,
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: FsColorStepper.active,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Text(
                            '1',
                            style: TextStyle(
                              fontFamily: 'Gilroy-Bold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.white,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                              color: FsColorStepper.active,
                              height: 1,
                            )),
                        Container(
                          alignment: Alignment.center,
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: FsColorStepper.active,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Text(
                            '2',
                            style: TextStyle(
                              fontFamily: 'Gilroy-Bold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.white,
                            ),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                              color: FsColorStepper.active,
                              height: 1,
                            )),
                        Container(
                          alignment: Alignment.center,
                          width: 30.0,
                          height: 30.0,
                          decoration: BoxDecoration(
                            color: FsColorStepper.active,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Text(
                            '3',
                            style: TextStyle(
                              fontFamily: 'Gilroy-Bold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 5.0),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    alignment: Alignment.center,
                    child: Text(
                      'Transfer via NEFT/IMPS'.toLowerCase(),
                      style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h5size,
                        color: FsColor.darkgrey,
                      ),
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                              'For E-Collect transaction go to your banks/mobile apps or use online netbanking'
                                  .toLowerCase(),
                              style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                  fontSize: FSTextStyle.h6size,
                                  color: FsColor.darkgrey)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                      margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                      elevation: 0,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          border: Border.all(
                              width: 1.0,
                              color: FsColor.lightgrey.withOpacity(0.3)),
                        ),
                        child: Column(
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  child: Text(
                                    'Beneficiary : '.toLowerCase(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-Regular',
                                        color: FsColor.lightgrey),
                                  ),
                                ),
                                Container(
                                  child: Flexible(
                                    child: Text(
                                      socName == null ? "Loading..." : socName,
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  child: Text(
                                    'Account No. : '.toLowerCase(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-Regular',
                                        color: FsColor.lightgrey),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    vpaOption.toString(), //.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.darkgrey),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  child: Text(
                                    'IFS Code : '.toLowerCase(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-Regular',
                                        color: FsColor.lightgrey),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    vapDetails["ifsccode"]
                                        .toString(),
//                                        .toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.darkgrey),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 100.0,
                                  child: Text(
                                    'Account Type : '.toLowerCase(),
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-Regular',
                                        color: FsColor.lightgrey),
                                  ),
                                ),
                                Container(
                                  child: Text(
                                    'Current'.toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.darkgrey),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Note:',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              height: 2,
                              color: FsColor.lightgrey),
                        ),
                        Text(
                          '1. No Need to inform Complex',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-Regular',
                              height: 1.5,
                              color: FsColor.darkgrey),
                        ),
                        Text(
                          '2. Configure E-Collect Complex Account',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-Regular',
                              height: 1.5,
                              color: FsColor.darkgrey),
                        ),
                        Text(
                          '3. Get Automated Receipt',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-Regular',
                              height: 1.5,
                              color: FsColor.darkgrey),
                        ),
                        Container(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                margin:
                                EdgeInsets.only(bottom: 20.0, top: 20.0),
                                child: GestureDetector(
                                  child: RaisedButton(
                                    padding: EdgeInsets.fromLTRB(
                                        30.0, 10.0, 30.0, 10.0),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                      new BorderRadius.circular(4.0),
                                    ),
                                    child: Text('How to Configure',
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold')),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PayConfigurePage(),
                                        ),
                                      );
                                    },
                                    color: FsColor.primaryflat,
                                    textColor: FsColor.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
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
}
