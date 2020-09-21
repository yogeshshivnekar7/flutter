//import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
//import 'package:flutter/material.dart';
//import 'package:sso_futurescape/config/colors/color.dart';
//import 'package:sso_futurescape/ui/module/vizlog/mydomestic_help/add_staff/addstaff_information.dart';
//import 'package:sso_futurescape/ui/widgets/back_button.dart';
//import 'package:sso_futurescape/ui/widgets/mobile_number_widget.dart';
//
//class AddStaffContact extends StatefulWidget {
//  @override
//  _AddStaffContactState createState() => _AddStaffContactState();
//}
//
//class _AddStaffContactState extends State<AddStaffContact> {
//
//  ContactNumberController userNameController = new ContactNumberController();
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
//        padding: EdgeInsets.fromLTRB(20.0, 50.0, 20.0, 20.0),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.center,
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            Container(
//              alignment: Alignment.topLeft,
//              child: Text(
//                'enter staff contact number'.toLowerCase(),
//                style: TextStyle(fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey, height: 1.2,),
//              ),
//            ),
//            Container(
//              alignment: Alignment.topLeft,
//              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
//              child: MobileNumberWidget(
//                controller: userNameController,
//              ),
//            ),
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
//                  child: Text('Next',
//                      style: TextStyle(
//                        fontSize: FSTextStyle.h6size,
//                        fontFamily: 'Gilroy-SemiBold',
//                      )),
//                  onPressed: () {
//                    Navigator.push(
//                      context, MaterialPageRoute(
//                      builder: (context) => AddStaffInformation()),
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
//
//
//}
