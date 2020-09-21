//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:flutter/foundation.dart';
//import 'package:flutter/material.dart';
//import 'package:sso_futurescape/config/colors/color.dart';
//import 'package:sso_futurescape/ui/module/sso/profile/utils/uploadimage.dart';
//import 'package:sso_futurescape/ui/module/vizlog/myvisitors_dashboard.dart';
//import 'package:sso_futurescape/ui/widgets/back_button.dart';
//import 'package:sso_futurescape/ui/widgets/mobile_number_widget.dart';
//
//class AddStaffProof extends StatefulWidget {
//  @override
//  _AddStaffProofState createState() => _AddStaffProofState();
//}
//
//class _AddStaffProofState extends State<AddStaffProof> {
//
//  ContactNumberController userNameController = new ContactNumberController();
//
//  String _selectedcategory;
//  List<String> _category = [
//    'Aadhaar UID',
//    'Pan Card',
//    'Passport',
//    'Election ID Card',
//    'Driving License',
//    'Ration Card',
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return new Scaffold(
//      appBar: new AppBar(
//        backgroundColor: FsColor.primaryvisitor,
//        elevation: 0.0,
//        title: new Text(
//          'Add Domestic Help'.toLowerCase(),
//          style: FSTextStyle.appbartextlight,
//        ),
//        leading: FsBackButtonlight(),
//      ),
//      resizeToAvoidBottomPadding: false,
//      body: SingleChildScrollView(
//        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//
//            Container(
//              alignment: Alignment.topLeft,
//              child: Text(
//                'fill the staff proof'.toLowerCase(),
//                style: TextStyle(
//                  fontSize: FSTextStyle.h5size,
//                  fontFamily: 'Gilroy-SemiBold',
//                  color: FsColor.darkgrey,
//                  height: 1.2,
//                ),
//              ),
//            ),
//
//            Container(
//              alignment: Alignment.topLeft,
//              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
//              child: DropdownButtonFormField(
//                  isExpanded: true,
//                  decoration: InputDecoration(
//                    labelText: 'ID Proof'.toLowerCase(),
//                    labelStyle: TextStyle(
//                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey, fontSize: FSTextStyle.h6size),
//                    focusedBorder: UnderlineInputBorder(
//                        borderSide: BorderSide(color: FsColor.basicprimary))),
//                      value: _selectedcategory,
//                      onChanged: (newValue) {
//                      setState(() {
//                        _selectedcategory = newValue;
//                      }
//                    );
//                  },
//                  items: _category.map((category) {
//                    return DropdownMenuItem(
//                      child: new Text(category,
//                        style: TextStyle(
//                          fontFamily: 'Gilroy-SemiBold',
//                          fontSize: FSTextStyle.h6size,
//                          color: FsColor.darkgrey
//                        ),
//                      ),
//                      value: category,
//                    );
//                  }).toList(),
//                ),
//            ),
//
//            Container(
//              alignment: Alignment.topLeft,
//              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
//              child: TextField(
//                style: TextStyle(
//                    fontFamily: 'Gilroy-SemiBold',
//                    fontSize: FSTextStyle.h6size,
//                    color: FsColor.darkgrey),
//                decoration: InputDecoration(
//                    labelText: 'Proof Number'.toLowerCase(),
//                    labelStyle: TextStyle(
//                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey, fontSize: FSTextStyle.h6size),
//                    focusedBorder: UnderlineInputBorder(
//                        borderSide: BorderSide(color: FsColor.basicprimary))),
//              ),
//            ),
//
//
//            Container(
//              height: 180,
//              width: 180,
//              decoration: BoxDecoration(
//                border: Border.all(color: FsColor.darkgrey,width: 2.0,),
//                image: DecorationImage(
//                  image: AssetImage("images/no-image.jpg"),
//                  fit: BoxFit.fill,
//                ),
//              ),
//              margin: EdgeInsets.only(
//                  left: 0.0, right: 0.0, top: 10.0, bottom: 10.0),
//              child: FlatButton(
//                onPressed: () => {
//                  _uploadImageDialog(),
//                },
//                padding: EdgeInsets.all(10.0),
//                child: new Icon(
//                  Icons.camera_alt,
//                  size: 30.0,
//                  color: FsColor.white,
//                ),
//                color: FsColor.basicprimary.withOpacity(0.5),
//              ),
//            ),
//
//
//            Container(
//              child: Text(
//                'Upload a ID Proof Document'.toLowerCase(),
//                style: TextStyle(
//                    fontFamily: 'Gilroy-SemiBold',
//                    fontSize: FSTextStyle.h7size,
//                    color: FsColor.lightgrey),
//              ),
//            ),
//
//
//
//            SizedBox(height: 20.0),
//
//
//
//            Container(
//              alignment: Alignment.center,
//              child: GestureDetector(
//                child: RaisedButton(
//                  color: FsColor.primaryvisitor,
//                  textColor: FsColor.white,
//                  padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
//                  shape: new RoundedRectangleBorder(
//                    borderRadius: new BorderRadius.circular(4.0),
//                  ),
//                  child: Text('Done',
//                      style: TextStyle(
//                        fontSize: FSTextStyle.h6size,
//                        fontFamily: 'Gilroy-SemiBold',
//                      )),
//                  onPressed: () {
//                    Navigator.push(
//                      context, MaterialPageRoute(
//                      builder: (context) => MyVisitorsDashboard()),
//                    );
//                  },
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//
//void _uploadImageDialog() {
//    showDialog(
//      context: context,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: new Text("choose image",
//            textAlign: TextAlign.center,
//            style: TextStyle(
//              fontFamily: 'Gilroy-SemiBold',
//              fontSize: FSTextStyle.h4size,
//              color: FsColor.darkgrey)),
//          shape: new RoundedRectangleBorder(
//            borderRadius: new BorderRadius.circular(7.0),
//          ),
//          content: Container(
//            height: 120.0,
//            alignment: Alignment.center,
//            child: Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              mainAxisSize: MainAxisSize.max,
//              children: <Widget>[
//                Container(
//                  padding: EdgeInsets.only(top: 10, left: 0),
//                  height: 120,
//                  width: MediaQuery.of(context).size.width,
//                  child: ListView.builder(
//                    scrollDirection: Axis.horizontal,
//                    shrinkWrap: true,
//                    primary: false,
//                    itemCount: uploadimage == null ? 0 : uploadimage.length,
//                    itemBuilder: (BuildContext context, int index) {
//                      Map upload = uploadimage[index];
//                      return Padding(
//                        padding: const EdgeInsets.only(right: 0, top: 10),
//                        child: InkWell(
//                          child: Container(
//                            height: 120,
//                            width: 90,
//                            child: Column(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              children: <Widget>[
//                                SizedBox(height: 8),
//                                ClipRRect(
//                                  child: Image.asset(
//                                    "${upload["img"]}",
//                                    height: 50,
//                                    width: 50,
//                                    fit: BoxFit.cover,
//                                  ),
//                                ),
//                                SizedBox(height: 8),
//                                Container(
//                                  alignment: Alignment.center,
//                                  child: Text(
//                                    "${upload["name"]}",
//                                    style: TextStyle(
//                                      fontSize: FSTextStyle.h6size,
//                                      fontFamily: 'Gilroy-Regular',
//                                    ),
//                                    maxLines: 2,
//                                    textAlign: TextAlign.left,
//                                  ),
//                                ),
//                              ],
//                            ),
//                          ),
//                          onTap: () {},
//                        ),
//                      );
//                    },
//                  ),
//                ),
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            FlatButton(
//              child: new Text(
//                "Cancel",
//                style: TextStyle(
//                  fontFamily: 'Gilroy-SemiBold',
//                  fontSize: FSTextStyle.h6size,
//                  color: FsColor.darkgrey,),
//              ),
//              onPressed: () {
//                Navigator.of(context, rootNavigator: true).pop('dialog');
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }
//
//}
