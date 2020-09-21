//import 'dart:ui';
//
//import 'package:flutter/material.dart';
//import 'package:sso_futurescape/config/colors/color.dart';
//import 'package:sso_futurescape/ui/widgets/back_button.dart';
//import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
//import 'package:sso_futurescape/utils/storage/complex.dart';
//
//class SearchAddress extends StatefulWidget {
//  @override
//  _SearchAddressState createState() => new _SearchAddressState();
//
//
//}
//
//class _SearchAddressState extends State<SearchAddress> {
//  TextEditingController userNameController = new TextEditingController();
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      resizeToAvoidBottomPadding: false,
//      appBar: new AppBar(
//        backgroundColor: FsColor.white,
//        elevation: 1,
//        title: Container(
//              // decoration: BoxDecoration(
//              //   borderRadius: BorderRadius.all(Radius.circular(5.0),),
//              // ),
//              margin: EdgeInsets.all(0),
//              padding: EdgeInsets.all(0),
//              alignment: Alignment.center,
//              child: TextField(
//                style: TextStyle(fontSize: 15.0, color: FsColor.darkgrey,fontFamily: 'Gilroy-SemiBold'),
//                // style: FSTextStyle.appbartext,
//                decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(15.0),
//                  hintText: "search location",
//                  prefixIcon: Icon( FlutterIcon.search_1, size: FSTextStyle.h6size, color: FsColor.lightgrey,),
//                  hintStyle: TextStyle(fontSize: 15.0, color: FsColor.lightgrey,),
//                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: FsColor.primary)),
//                  suffix: Container(
//                    width: 24, height: 24,
//                    alignment: Alignment.center,
//                    child: FlatButton(
//                    padding: EdgeInsets.all(0),
//                    onPressed: (){},
//                    child: Icon(FlutterIcon.cancel_1, color: FsColor.darkgrey, size: FSTextStyle.h6size,),
//                    ),
//                  ),
//                ),
//                maxLines: 1,
//              ),
//            ),
//        leading: FsBackButton(),
//      ),
//      body:
//      SingleChildScrollView(
//        child: Container(
//        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
//            child:
//            Column(
//              mainAxisAlignment: MainAxisAlignment.start,
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                        ListView.builder(
//                          primary: false,
//                          physics: NeverScrollableScrollPhysics(),
//                          shrinkWrap: true,
//                          itemCount: searchaddress == null ? 0 : searchaddress.length,
//                          itemBuilder: (BuildContext context, int index) {
//                            Map place = searchaddress[index];
//                            return InkWell(
//                              onTap: (){},
//                              child: Container(
//                                padding: EdgeInsets.all(10),
//                                decoration: BoxDecoration(
//                                  border: Border(
//                                    bottom: BorderSide(width: 1.0, color: FsColor.lightgrey.withOpacity(0.5),)
//                                  ),
//                                ),
//                                child: Row(
//                                mainAxisAlignment: MainAxisAlignment.start,
//                                crossAxisAlignment: CrossAxisAlignment.center,
//                                children: [
//                                  Container(
//                                    child: Column(
//                                      children: [
//                                        Icon(FlutterIcon.location_1, color: FsColor.darkgrey, size: FSTextStyle.h3size),
//                                        SizedBox(height: 5),
//                                        Text('${place["distance"]}',
//                                          style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.lightgrey, fontFamily: 'Gilroy-SemiBold'),
//                                        ),
//                                      ],
//                                    ),
//                                  ),
//                                  SizedBox(width: 10),
//                                  Expanded(
//                                    child: Column(
//                                      mainAxisAlignment: MainAxisAlignment.start,
//                                      crossAxisAlignment: CrossAxisAlignment.start,
//                                      children: [
//                                        Text('${place["areaaddress"]}',
//                                          style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.basicprimary, fontFamily: 'Gilroy-SemiBold', letterSpacing: 1,),
//                                        ),
//                                        SizedBox(height: 5),
//                                        Text('${place["fulladdress"]}',
//                                          style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.darkgrey.withOpacity(0.65), fontFamily: 'Gilroy-SemiBold'),
//                                        ),
//                                      ],
//                                    ),
//
//                                  ),
//                                ],
//                              ),
//
//                              ),
//                            );
//                          },
//                        ),
//
//                      ],
//                    ),
//              ),
//
//
//
//      )
//
//
//    );
//  }
//
//
//}