//import 'dart:ui';
//
//import 'package:flutter/material.dart';
//import 'package:sso_futurescape/config/colors/color.dart';
//import 'package:sso_futurescape/ui/module/grocery/grocery_list.dart';
//import 'package:sso_futurescape/ui/module/sso/unit_building_setup/building.dart';
//import 'package:sso_futurescape/ui/module/sso/unit_building_setup/unit.dart';
//import 'package:sso_futurescape/ui/widgets/back_button.dart';
//import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
//import 'package:sso_futurescape/utils/storage/complex.dart';
//
//class GroceryBuyAnything extends StatefulWidget {
//  @override
//  _GroceryBuyAnythingState createState() => new _GroceryBuyAnythingState();
//}
//
//class _GroceryBuyAnythingState extends State<GroceryBuyAnything> {
//  TextEditingController userNameController = new TextEditingController();
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      resizeToAvoidBottomPadding: false,
//      appBar: new AppBar(
//        backgroundColor: FsColor.primarygrocery,
//        elevation: 0.0,
//        title: new Text(
//          'Buy anything',
//          style: FSTextStyle.appbartextlight,
//        ),
//        leading: FsBackButtonlight(),
//        actions: <Widget>[
//          FlatButton(
//            onPressed: () {
//              _howitworksModalBottomSheet(context);
//            },
//            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//            child: Text(
//              'How it Works ?',
//              style: TextStyle(
//                  fontSize: FSTextStyle.h6size,
//                  color: FsColor.white,
//                  fontFamily: 'Gilroy-SemiBold'),
//            ),
//          ),
//          SizedBox(width: 5),
//        ],
//      ),
//      body: Stack(
//        children: <Widget>[
//          ListView(
//            children: <Widget>[
//              Container(
//                width: double.infinity,
//                decoration: BoxDecoration(
//                    borderRadius: const BorderRadius.all(
//                      Radius.circular(4.0),
//                    ),
//                    border: Border.all(
//                      width: 1.0,
//                      color: FsColor.lightgrey,
//                    )),
//                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                child: Row(
//                  children: <Widget>[
//                    Image.asset(
//                      "images/store_icon.png",
//                      height: 44, width: 44, fit: BoxFit.cover,
//                    ),
//                    SizedBox(width: 5),
//                    Expanded(
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                Container(
//                                    child: Text(
//                                  'A1 Mart',
//                                  style: TextStyle(
//                                      fontSize: FSTextStyle.h5size,
//                                      color: FsColor.basicprimary,
//                                      fontFamily: 'Gilroy-SemiBold'),
//                                )),
//                                Container(
//                                  height: 24,
//                                  child: FlatButton(
//                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                    child: Text(
//                                      'Change',
//                                      style: TextStyle(
//                                          fontSize: FSTextStyle.h7size,
//                                          color: FsColor.primarygrocery,
//                                          fontFamily: 'Gilroy-SemiBold'),
//                                    ),
//                                    onPressed: () {
//                                      Navigator.push(
//                                        context,
//                                        MaterialPageRoute(
//                                          builder: (context) => GroceryList(),
//                                        ),
//                                      );
//                                    },
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          SizedBox(height: 3),
//                          Container(
//                            alignment: Alignment.topLeft,
//                            child: Text(
//                              'shop no 420, lorem apartment, ipsum road, vashi navi mumbai'
//                                  .toLowerCase(),
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(
//                                  fontSize: FSTextStyle.h7size,
//                                  color: FsColor.lightgrey,
//                                  fontFamily: 'Gilroy-SemiBold'),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              Container(
//                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
//                  alignment: Alignment.centerLeft,
//                  child: Text(
//                    'Make a list of items'.toLowerCase(),
//                    style: TextStyle(
//                        fontSize: FSTextStyle.h5size,
//                        color: FsColor.basicprimary,
//                        fontFamily: 'Gilroy-SemiBold'),
//                  )),
//              Container(
//                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
//
//                child: SingleChildScrollView(
//                  child: ConstrainedBox(
//                    constraints: BoxConstraints(
//                      minHeight: 230.0,
//                    ),
//                    child: Column(
//                      mainAxisAlignment: MainAxisAlignment.start,
//                      crossAxisAlignment: CrossAxisAlignment.start,
//                      children: <Widget>[
//                        Container(
//                          height: 48,
//                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//
//                          child: TextField(
//                            maxLines: 1,
//                            style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.basicprimary, fontFamily: 'Gilroy-Regular'),
//                            decoration: InputDecoration(
//                              hintText: "Add items".toLowerCase(),
//                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: FsColor.primarygrocery)),
//                              suffix: Container(
//                                width: 30, height: 30,
//                                alignment: Alignment.center,
//                                child: RaisedButton(
//                                padding: EdgeInsets.all(0),
//                                color: FsColor.primarygrocery,
//                                onPressed: (){},
//                                child: Icon(FlutterIcon.plus, color: FsColor.white, size: FSTextStyle.h6size,),
//                                ),
//                              ),
//                              ),
//                            ),
//                        ),
//                        SizedBox(height: 30),
//                        ListView.builder(
//                          primary: false,
//                          physics: AlwaysScrollableScrollPhysics(),
//                          shrinkWrap: true,
//                          itemCount: buyanythingitem == null
//                              ? 0
//                              : buyanythingitem.length,
//                          itemBuilder: (BuildContext context, int index) {
//                            Map place = buyanythingitem[index];
//                            return Container(
//                                padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
//                                margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
//                                decoration: BoxDecoration(
//                                    border: Border(
//                                        bottom: BorderSide(
//                                  width: 1.0,
//                                  color: FsColor.lightgrey.withOpacity(0.5),
//                                ))),
//                                child: Container(
//                                  child: Row(
//                                    children: <Widget>[
//                                      Expanded(
//                                        child: Container(
//                                          alignment: Alignment.center,
//                                          child: ListView(
//                                            primary: false,
//                                            physics:
//                                                NeverScrollableScrollPhysics(),
//                                            shrinkWrap: true,
//                                            children: <Widget>[
//                                              Container(
//                                                  alignment:
//                                                      Alignment.centerLeft,
//                                                  child: Text(
//                                                    '${place["name"]}',
//                                                    style: TextStyle(
//                                                      fontFamily:
//                                                          'Gilroy-SemiBold',
//                                                      fontSize:
//                                                          FSTextStyle.h6size,
//                                                      color: FsColor.darkgrey,
//                                                    ),
//                                                  )),
//                                            ],
//                                          ),
//                                        ),
//                                      ),
//                                      SizedBox(width: 10),
//                                      Container(
//                                        child: Row(
//                                          children: <Widget>[
//                                            Container(
//                                              height: 24,
//                                              width: 24,
//                                              child: FlatButton(
//                                                padding: EdgeInsets.fromLTRB(
//                                                    0, 0, 0, 0),
//                                                child: Icon(FlutterIcon.minus,
//                                                    color:
//                                                        FsColor.primarygrocery,
//                                                    size: FSTextStyle.h6size),
//                                                onPressed: () {},
//                                              ),
//                                            ),
//                                            SizedBox(width: 5),
//                                            Text(
//                                              '${place["qty"]}',
//                                              style: TextStyle(
//                                                  fontSize: FSTextStyle.h6size,
//                                                  color: FsColor.basicprimary,
//                                                  fontFamily:
//                                                      'Gilroy-SemiBold'),
//                                            ),
//                                            SizedBox(width: 5),
//                                            Container(
//                                              height: 24,
//                                              width: 24,
//                                              child: FlatButton(
//                                                padding: EdgeInsets.fromLTRB(
//                                                    0, 0, 0, 0),
//                                                child: Icon(FlutterIcon.plus,
//                                                    color:
//                                                        FsColor.primarygrocery,
//                                                    size: FSTextStyle.h6size),
//                                                onPressed: () {},
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              );
//                          },
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//              Container(
//                  margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
//                  alignment: Alignment.centerLeft,
//                  child: Text(
//                    'Address'.toLowerCase(),
//                    style: TextStyle(
//                        fontSize: FSTextStyle.h5size,
//                        color: FsColor.basicprimary,
//                        fontFamily: 'Gilroy-SemiBold'),
//                  )),
//              Container(
//                width: double.infinity,
//                decoration: BoxDecoration(
//                    color: FsColor.primarygrocery.withOpacity(0.05),
//                    borderRadius: const BorderRadius.all(
//                      Radius.circular(4.0),
//                    ),
//                    border: Border.all(
//                      width: 1.0,
//                      color: FsColor.lightgrey,
//                    )),
//                margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
//                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                child: Row(
//                  children: <Widget>[
//                    Image.asset(
//                      "images/home.png",
//                      height: 36,
//                      width: 36,
//                      fit: BoxFit.cover,
//                    ),
//                    SizedBox(width: 5),
//                    Expanded(
//                      child: Column(
//                        mainAxisAlignment: MainAxisAlignment.center,
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          Container(
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                Container(
//                                    child: Text(
//                                  'Home'.toLowerCase(),
//                                  style: TextStyle(
//                                      fontSize: FSTextStyle.h5size,
//                                      color: FsColor.basicprimary,
//                                      fontFamily: 'Gilroy-SemiBold'),
//                                )),
//                                Container(
//                                  height: 24,
//                                  child: FlatButton(
//                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
//                                    child: Text(
//                                      'Change',
//                                      style: TextStyle(
//                                          fontSize: FSTextStyle.h7size,
//                                          color: FsColor.primarygrocery,
//                                          fontFamily: 'Gilroy-SemiBold'),
//                                    ),
//                                    onPressed: () {},
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          SizedBox(height: 3),
//                          Container(
//                            alignment: Alignment.topLeft,
//                            child: Text(
//                              'shop no 420, lorem apartment, ipsum road, vashi navi mumbai'
//                                  .toLowerCase(),
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(
//                                  fontSize: FSTextStyle.h7size,
//                                  color: FsColor.lightgrey,
//                                  fontFamily: 'Gilroy-SemiBold'),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//              SizedBox(height: 50),
//            ],
//          ),
//          Positioned(
//            bottom: 0,
//            left: 0,
//            right: 0,
//            child: Container(
//              width: double.infinity,
//              padding: EdgeInsets.all(8.0),
//              child: GestureDetector(
//                child: RaisedButton(
//                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
//                  shape: new RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(4.0),
//                  ),
//                  child: Text('Continue Order',
//                      style: TextStyle(
//                          fontSize: FSTextStyle.h6size,
//                          fontFamily: 'Gilroy-SemiBold')),
//                  onPressed: () {
//                    _termsDialog();
//                  },
//                  color: FsColor.primarygrocery,
//                  textColor: FsColor.white,
//                ),
//              ),
//            ),
//          )
//        ],
//      ),
//    );
//  }
//
//  void _termsDialog() {
//    // flutter defined function
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        // return object of type Dialog
//        return AlertDialog(
//          contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//          scrollable: true,
//          shape: new RoundedRectangleBorder(
//            borderRadius: new BorderRadius.circular(10.0),
//          ),
//          content: Container(
//            child: Column(
//              children: <Widget>[
//                Container(
//                  height: 200,
//                  // color: FsColor.primarygrocery.withOpacity(0.1),
//                  child: Image.asset(
//                    'images/terms.png',
//                    fit: BoxFit.cover,
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                  child: Text(
//                    'we are now connecting you to the shop/restaurant!'
//                        .toLowerCase(),
//                    textAlign: TextAlign.center,
//                    style: TextStyle(
//                        fontSize: FSTextStyle.h5size,
//                        color: FsColor.basicprimary,
//                        fontFamily: 'Gilroy-Bold'),
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        alignment: Alignment.center,
//                        width: 24,
//                        height: 24,
//                        child: Icon(FlutterIcon.right_open,
//                            color: FsColor.primarygrocery,
//                            size: FSTextStyle.h6size),
//                      ),
//                      SizedBox(width: 10),
//                      Expanded(
//                        child: Text(
//                          'we only help you to find your nearest shops & restaurants'
//                              .toLowerCase(),
//                          textAlign: TextAlign.left,
//                          style: TextStyle(
//                              fontSize: FSTextStyle.h6size,
//                              color: FsColor.darkgrey,
//                              fontFamily: 'Gilroy-SemiBold'),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        alignment: Alignment.center,
//                        width: 24,
//                        height: 24,
//                        child: Icon(FlutterIcon.right_open,
//                            color: FsColor.primarygrocery,
//                            size: FSTextStyle.h6size),
//                      ),
//                      SizedBox(width: 10),
//                      Expanded(
//                        child: Text(
//                          'we facilitate direct communication between buyer and seller'
//                              .toLowerCase(),
//                          textAlign: TextAlign.left,
//                          style: TextStyle(
//                              fontSize: FSTextStyle.h6size,
//                              color: FsColor.darkgrey,
//                              fontFamily: 'Gilroy-SemiBold'),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        alignment: Alignment.center,
//                        width: 24,
//                        height: 24,
//                        child: Icon(FlutterIcon.right_open,
//                            color: FsColor.primarygrocery,
//                            size: FSTextStyle.h6size),
//                      ),
//                      SizedBox(width: 10),
//                      Expanded(
//                        child: Text(
//                          'we do not mediate in any nature of dispute between buyer and seller'
//                              .toLowerCase(),
//                          textAlign: TextAlign.left,
//                          style: TextStyle(
//                              fontSize: FSTextStyle.h6size,
//                              color: FsColor.darkgrey,
//                              fontFamily: 'Gilroy-SemiBold'),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        alignment: Alignment.center,
//                        width: 24,
//                        height: 24,
//                        child: Icon(FlutterIcon.right_open,
//                            color: FsColor.primarygrocery,
//                            size: FSTextStyle.h6size),
//                      ),
//                      SizedBox(width: 10),
//                      Expanded(
//                        child: Text(
//                          'right delivery of right order is sole responsibility of the shops & restaurants'
//                              .toLowerCase(),
//                          textAlign: TextAlign.left,
//                          style: TextStyle(
//                              fontSize: FSTextStyle.h6size,
//                              color: FsColor.darkgrey,
//                              fontFamily: 'Gilroy-SemiBold'),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  margin: EdgeInsets.fromLTRB(0, 5, 10, 0),
//                  child: Row(
//                    children: <Widget>[
//                      Container(
//                        alignment: Alignment.center,
//                        width: 24,
//                        height: 24,
//                        child: Icon(FlutterIcon.right_open,
//                            color: FsColor.primarygrocery,
//                            size: FSTextStyle.h6size),
//                      ),
//                      SizedBox(width: 10),
//                      Expanded(
//                        child: Text(
//                          'monetary deals are sole affairs between buyers and sellers'
//                              .toLowerCase(),
//                          textAlign: TextAlign.left,
//                          style: TextStyle(
//                              fontSize: FSTextStyle.h6size,
//                              color: FsColor.darkgrey,
//                              fontFamily: 'Gilroy-SemiBold'),
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  alignment: Alignment.center,
//                  child: GestureDetector(
//                    child: FlatButton(
//                      child: Text('Read the T&C for further details',
//                          style: TextStyle(
//                              fontSize: FSTextStyle.h6size,
//                              fontFamily: 'Gilroy-SemiBold',
//                              color: FsColor.primary)),
//                      onPressed: () {},
//                    ),
//                  ),
//                ),
//                Container(
//                  width: double.infinity,
//                  child: GestureDetector(
//                    child: RaisedButton(
//                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
//                      shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(4.0),
//                      ),
//                      child: Text('I Agree',
//                          style: TextStyle(
//                              fontSize: FSTextStyle.h6size,
//                              fontFamily: 'Gilroy-SemiBold')),
//                      onPressed: () {
//                        Navigator.pop(context);
//                      },
//                      color: FsColor.primarygrocery,
//                      textColor: FsColor.white,
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        );
//      },
//    );
//  }
//}
//
//void _howitworksModalBottomSheet(context) {
//  showModalBottomSheet(
//      context: context,
//      builder: (BuildContext context) {
//        return Container(
//          height: double.infinity,
//          padding: EdgeInsets.all(10),
//          child: SingleChildScrollView(
//            child: Column(
//              children: <Widget>[
//                Container(
//                  margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
//                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Text(
//                        'How it Works',
//                        style: TextStyle(
//                          fontSize: FSTextStyle.h5size,
//                          fontFamily: 'Gilroy-SemiBold',
//                          color: FsColor.basicprimary,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  child: Column(
//                    children: <Widget>[
//                      Container(
//                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                        decoration: BoxDecoration(
//                            border: Border(
//                                bottom: BorderSide(
//                          width: 1.0,
//                          color: FsColor.lightgrey.withOpacity(0.5),
//                        ))),
//                        child: Row(
//                          children: <Widget>[
//                            Container(
//                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                                width: 40,
//                                height: 40,
//                                decoration: BoxDecoration(
//                                  color:
//                                      FsColor.primarygrocery.withOpacity(0.2),
//                                  borderRadius: BorderRadius.all(
//                                    Radius.circular(25.0),
//                                  ),
//                                ),
//                                child: Icon(
//                                  FlutterIcon.list_numbered,
//                                  size: FSTextStyle.h4size,
//                                  color: FsColor.primarygrocery,
//                                )),
//                            SizedBox(width: 10),
//                            Expanded(
//                                child: Text(
//                              'make a list of items and place an order without any payment',
//                              style: TextStyle(
//                                fontSize: FSTextStyle.h6size,
//                                fontFamily: 'Gilroy-SemiBold',
//                                color: FsColor.darkgrey,
//                              ),
//                            )),
//                          ],
//                        ),
//                      ),
//                      Container(
//                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                        decoration: BoxDecoration(
//                            border: Border(
//                                bottom: BorderSide(
//                          width: 1.0,
//                          color: FsColor.lightgrey.withOpacity(0.5),
//                        ))),
//                        child: Row(
//                          children: <Widget>[
//                            Container(
//                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                                width: 40,
//                                height: 40,
//                                decoration: BoxDecoration(
//                                  color:
//                                      FsColor.primarygrocery.withOpacity(0.2),
//                                  borderRadius: BorderRadius.all(
//                                    Radius.circular(25.0),
//                                  ),
//                                ),
//                                child: Icon(
//                                  FlutterIcon.list_alt,
//                                  size: FSTextStyle.h4size,
//                                  color: FsColor.primarygrocery,
//                                )),
//                            SizedBox(width: 10),
//                            Expanded(
//                                child: Text(
//                              'Received an estimated bill for the order',
//                              style: TextStyle(
//                                fontSize: FSTextStyle.h6size,
//                                fontFamily: 'Gilroy-SemiBold',
//                                color: FsColor.darkgrey,
//                              ),
//                            )),
//                          ],
//                        ),
//                      ),
//                      Container(
//                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
//                        decoration: BoxDecoration(
//                            border: Border(
//                                bottom: BorderSide(
//                          width: 1.0,
//                          color: FsColor.lightgrey.withOpacity(0.5),
//                        ))),
//                        child: Row(
//                          children: <Widget>[
//                            Container(
//                                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                                width: 40,
//                                height: 40,
//                                decoration: BoxDecoration(
//                                  color:
//                                      FsColor.primarygrocery.withOpacity(0.2),
//                                  borderRadius: BorderRadius.all(
//                                    Radius.circular(25.0),
//                                  ),
//                                ),
//                                child: Icon(
//                                  FlutterIcon.money,
//                                  size: FSTextStyle.h4size,
//                                  color: FsColor.primarygrocery,
//                                )),
//                            SizedBox(width: 10),
//                            Expanded(
//                                child: Text(
//                              'confirm the items and make payment',
//                              style: TextStyle(
//                                fontSize: FSTextStyle.h6size,
//                                fontFamily: 'Gilroy-SemiBold',
//                                color: FsColor.darkgrey,
//                              ),
//                            )),
//                          ],
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Container(
//                  width: double.infinity,
//                  padding: EdgeInsets.all(8.0),
//                  child: GestureDetector(
//                    child: RaisedButton(
//                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
//                      shape: new RoundedRectangleBorder(
//                        borderRadius: new BorderRadius.circular(4.0),
//                      ),
//                      child: Text('Proceed',
//                          style: TextStyle(
//                              fontSize: FSTextStyle.h6size,
//                              fontFamily: 'Gilroy-SemiBold')),
//                      onPressed: () {
//                        Navigator.pop(context);
//                      },
//                      color: FsColor.primarygrocery,
//                      textColor: FsColor.white,
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),
//        );
//      });
//}
