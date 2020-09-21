import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/maintenence_dues/maintenence_overdue.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';

class MyFlatsMaintenenceList extends StatefulWidget {
  var currentUnit;

  MyFlatsMaintenenceList(this.currentUnit);

  @override
  _MyFlatsMaintenenceListState createState() =>
      new _MyFlatsMaintenenceListState(currentUnit);
}

class _MyFlatsMaintenenceListState extends State<MyFlatsMaintenenceList> {
  var currentUnit;

  _MyFlatsMaintenenceListState(this.currentUnit);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double tabWidth = width / 6;

    return /* MaterialApp(
      home: */
        DefaultTabController(
      length: 4,
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: FsBackButtonlight(),
          title: Text(
            'Maintenence Due'.toLowerCase(),
            style: FSTextStyle.appbartextlight,
          ),
          elevation: 1.0,
          backgroundColor: FsColor.primaryflat,
          bottom: TabBar(
            isScrollable: true,
            labelStyle:
                TextStyle(fontFamily: 'Gilroy-SemiBold', color: FsColor.white),
            indicatorColor: FsColor.white,
            tabs: [
              Container(
                width: tabWidth,
                child: Tab(text: "Overdue".toLowerCase()),
              ),
              Container(
                width: tabWidth,
                child: Tab(text: "Unpaid".toLowerCase()),
              ),
              Container(
                width: tabWidth,
                child: Tab(text: "Paid".toLowerCase()),
              ),
              Container(
                width: tabWidth,
                child: Tab(text: "All".toLowerCase()),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MaintenenceOverdue(
                currentUnit, DUES_TYPE.OVERDUE, BILLTYPE.MAINTANCE),
            MaintenenceOverdue(
                currentUnit, DUES_TYPE.UNPAID, BILLTYPE.MAINTANCE),
            MaintenenceOverdue(currentUnit, DUES_TYPE.PAID, BILLTYPE.MAINTANCE),
            MaintenenceOverdue(currentUnit, DUES_TYPE.ALL, BILLTYPE.MAINTANCE),
            /*MaintenenceUnpaid(),
              MaintenencePaid(),
              MaintenenceAll(),*/
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () => {
        //     // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(builder: (context) => MyFlatsComplaintsAdd()),
        //     // ),
        //   },
        //   child: Icon(FlutterIcon.rupee, size: FSTextStyle.h4size, color: FsColor.white),
        //   backgroundColor: FsColor.primaryflat,
        // ),
      ),
      /*  ),*/
    );
  }
}
