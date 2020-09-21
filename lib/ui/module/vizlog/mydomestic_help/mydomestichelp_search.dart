//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:sso_futurescape/config/colors/color.dart';
//import 'package:sso_futurescape/ui/module/vizlog/mydomestic_help/add_staff/addstaff_contact.dart';
//import 'package:sso_futurescape/ui/module/vizlog/mydomestic_help/mydomestic_details.dart';
//import 'package:sso_futurescape/ui/widgets/back_button.dart';
//import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
//import 'package:sso_futurescape/utils/storage/complex.dart';
//
//class MyDomesticHelpSearch extends StatefulWidget {
//  @override
//  _MyDomesticHelpSearchState createState() => _MyDomesticHelpSearchState();
//}
//
//class _MyDomesticHelpSearchState extends State<MyDomesticHelpSearch> {
//  final TextEditingController _searchControl = new TextEditingController();
//
//  List<String> _timeslots = [
//    '7am-9am',
//    '9am-11am',
//    '11am-3pm',
//    '3pm-6pm',
//    '6pm-9pm',
//  ];
//  String _selectedfreetimeslots;
//  // List<String> _category = [
//  //   'Driver',
//  //   'Maid',
//  //   'Cook',
//  //   'Bodyguard',
//  //   'Cleaner',
//  // ];
//
//  // String _selectedcategory;
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: new AppBar(
//        backgroundColor: FsColor.primaryvisitor,
//        elevation: 0.0,
//        title: new Text(
//          'Domestic Help',
//          style: FSTextStyle.appbartextlight,
//        ),
//        leading: FsBackButtonlight(),
//      ),
//      body: ListView(
//        children: <Widget>[
//          Padding(
//            padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
//            child: Text(
//              "search with Category".toLowerCase(),
//              style: TextStyle(fontSize: FSTextStyle.h5size,fontFamily: 'Gilroy-SemiBold',color: FsColor.darkgrey,height: 1.2,),
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
//            child: Column(
//              children: <Widget>[
//            Container(
//              decoration: BoxDecoration(
//                color: Colors.blueGrey[50],
//                borderRadius: BorderRadius.all(
//                  Radius.circular(5.0),
//                ),
//              ),
//              width: double.infinity,
//
//            // child: DropdownButtonFormField(
//            //     isExpanded: true,
//            //     decoration: InputDecoration(
//            //       contentPadding: EdgeInsets.all(10.0),
//            //       border: OutlineInputBorder(
//            //         borderRadius: BorderRadius.circular(5.0),
//            //         borderSide: BorderSide(
//            //           color: FsColor.white,
//            //         ),
//            //       ),
//            //       enabledBorder: OutlineInputBorder(
//            //         borderSide: BorderSide(
//            //           color: FsColor.white,
//            //         ),
//            //         borderRadius: BorderRadius.circular(5.0),
//            //       ),
//            //       hintText: "e.g: maid, driver etc..",
//            //       prefixIcon: Icon(
//            //         FlutterIcon.th_large,
//            //         size: FSTextStyle.h5size,
//            //         color: Colors.blueGrey[300],
//            //       ),
//            //       hintStyle: TextStyle(
//            //         fontSize: FSTextStyle.h6size,
//            //         color: Colors.blueGrey[300],
//            //         fontFamily: 'Gilroy-Regular'
//            //       ),
//            //     ),
//
//            //     hint: Text(''.toLowerCase(),
//            //       style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
//            //     ),
//            //     value: _selectedcategory,
//            //     onChanged: (newValue) {setState(() {_selectedcategory = newValue;});},
//            //     items: _category.map((category) {
//            //       return DropdownMenuItem(
//            //         child: Text(category,
//            //           style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
//            //         ),
//            //         value: category,
//            //       );
//            //     }).toList(),
//            //   ),
//
//              child: TextField(
//                style: TextStyle(
//                  fontSize: 15.0,
//                  color: FsColor.darkgrey,
//                ),
//                decoration: InputDecoration(
//                  contentPadding: EdgeInsets.all(10.0),
//                  border: OutlineInputBorder(
//                    borderRadius: BorderRadius.circular(5.0),
//                    borderSide: BorderSide(
//                      color: Colors.white,
//                    ),
//                  ),
//                  enabledBorder: OutlineInputBorder(
//                    borderSide: BorderSide(
//                      color: Colors.white,
//                    ),
//                    borderRadius: BorderRadius.circular(5.0),
//                  ),
//                  hintText: "e.g: maid, driver etc..",
//                  prefixIcon: Icon(
//                    FlutterIcon.th_large,
//                    size: FSTextStyle.h5size,
//                    color: Colors.blueGrey[300],
//                  ),
//                  hintStyle: TextStyle(
//                    fontSize: 15.0,
//                    color: Colors.blueGrey[300],
//                  ),
//                ),
//                maxLines: 1,
//                controller: _searchControl,
//              ),
//
//
//
//
//            ),
//
//
//            Container(
//              alignment: Alignment.topLeft,
//              child: DropdownButton(
//                // isExpanded: false,
//                hint: Text('Free Time Slots'.toLowerCase(),
//                  style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
//                ),
//                value: _selectedfreetimeslots,
//                onChanged: (newValue) {setState(() {_selectedfreetimeslots = newValue;});},
//                items: _timeslots.map((timeslots) {
//                  return DropdownMenuItem(
//                    child: Text(timeslots,
//                      style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
//                    ),
//                    value: timeslots,
//                  );
//                }).toList(),
//              ),
//            ),
//
//
//              ],
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.all(15),
//            child: ListView.builder(
//              primary: false,
//              physics: NeverScrollableScrollPhysics(),
//              shrinkWrap: true,
//              itemCount: domestichelplist == null ? 0 : domestichelplist.length,
//              itemBuilder: (BuildContext context, int index) {
//                Map item = domestichelplist[index];
//                return Padding(
//                  padding: const EdgeInsets.only(bottom: 15.0),
//                  child: InkWell(
//                    child: Container(
//                      padding: const EdgeInsets.only(bottom: 5.0, top: 5.0,),
//                      // height: 85,
//                      child: Row(
//                        children: <Widget>[
//                          ClipRRect(
//                            borderRadius: BorderRadius.circular(25),
//                            child: Image.asset(
//                              "${item["photo"]}",
//                              height: 48,
//                              width: 48,
//                              fit: BoxFit.cover,
//                            ),
//                          ),
//                          SizedBox(width: 15),
//                          Expanded(
//                            child: Container(
//                              alignment: Alignment.center,
//                              // height: 80,
//                              // width: MediaQuery.of(context).size.width - 100,
//                              child: ListView(
//                                primary: false,
//                                physics: NeverScrollableScrollPhysics(),
//                                shrinkWrap: true,
//                                children: <Widget>[
//                                  Container(
//                                    alignment: Alignment.centerLeft,
//                                    child: RichText(
//                                        text: TextSpan(
//                                          style: Theme.of(context).textTheme.body1,
//                                            children: [
//                                          TextSpan(
//                                            text: '${item["name"]}',
//                                            style: TextStyle(fontFamily: 'Gilroy-SemiBold',fontSize: FSTextStyle.h6size,color: FsColor.basicprimary,),
//                                          ),
//                                        ])),
//                                  ),
//                                  SizedBox(height: 5),
//                                  Container(
//                                    alignment: Alignment.centerLeft,
//                                    child: RichText(
//                                        text: TextSpan(
//                                          style: Theme.of(context).textTheme.body1,
//                                            children: [
//                                          TextSpan(
//                                            text: '${item["designation"]}',
//                                            style: TextStyle(fontFamily: 'Gilroy-SemiBold',fontSize: FSTextStyle.h6size,color: FsColor.lightgrey,),
//                                          ),
//                                        ])),
//                                  ),
//                                  SizedBox(height: 5),
//                                  Row(
//                                    children: <Widget>[
//                                      Container(
//                                        child: Row(
//                                          children: <Widget>[
//                                            Icon(Icons.star, size: FSTextStyle.h5size, color: FsColor.yellow,),
//                                            SizedBox(width: 2),
//                                            Container(
//                                              alignment: Alignment.centerLeft,
//                                              child: Text(
//                                                "${item["rating"]}",
//                                                style: TextStyle( fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey,),
//                                                maxLines: 1, textAlign: TextAlign.left,
//                                              ),
//                                            ),
//                                          ],
//                                        ),
//                                      ),
//                                      SizedBox(width: 20),
//                                      Container(
//                                        child: Row(
//                                          children: <Widget>[
//                                            Text('${item["workingin"]}',
//                                            style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey)),
//                                            Text(' Houses'.toLowerCase(),
//                                            style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.lightgrey)),
//                                          ],
//                                        ),
//                                      ),
//                                    ],
//                                  ),
//                                  SizedBox(height: 5.0),
//                                  Row(
//                                    children: <Widget>[
//                                      Text('Free : ',
//                                      style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.lightgrey)),
//                                      Text('${item["free"]}',
//                                      style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey)),
//                                    ],
//                                  ),
//
//                                ],
//                              ),
//                            ),
//                          ),
//                        ],
//                      ),
//                    ),
//                    onTap: () {
//                      Navigator.push(context,
//                        MaterialPageRoute(
//                        builder: (context) =>
//                          MyDomesticHelpDetails()),
//                      );
//                    },
//                  ),
//                );
//              },
//            ),
//          ),
//          Container(
//            alignment: Alignment.center,
//            padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
//            child: Text(
//                "could not find your Staff? don't worry!. You can add your Staff here".toLowerCase(),
//                textAlign: TextAlign.center,
//                style: TextStyle(
//
//                    fontSize: FSTextStyle.h6size,
//                    color: FsColor.lightgrey,
//                    fontFamily: 'Gilroy-SemiBold')),
//          ),
//          Container(
//            alignment: Alignment.center,
//            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
//            child: GestureDetector(
//              child: RaisedButton(
//                child: Text('Add Your Own',
//                    style: TextStyle(
//                        fontSize: FSTextStyle.h6size,
//                        fontFamily: 'Gilroy-SemiBold')),
//                shape: new RoundedRectangleBorder(
//                  borderRadius: new BorderRadius.circular(4.0),
//                ),
//                color: FsColor.primaryvisitor,
//                textColor: FsColor.white,
//                onPressed: () {
//                  Navigator.push(
//                    context, MaterialPageRoute(
//                      builder: (context) => AddStaffContact()),
//                  );
//                },
//              ),
//            ),
//          ),
//        ],
//      ),
//    );
//  }
//
//}
