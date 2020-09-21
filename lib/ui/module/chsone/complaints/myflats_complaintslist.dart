import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/complaints/complaints_open.dart';
import 'package:sso_futurescape/ui/module/chsone/complaints/myflats_complaintadd.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';

class MyFlatsComplaintsList extends StatefulWidget {
  var currentUnit;

  MyFlatsComplaintsList(this.currentUnit);

  @override
  _MyFlatsComplaintsListState createState() =>
      new _MyFlatsComplaintsListState(currentUnit);
}

class _MyFlatsComplaintsListState extends State<MyFlatsComplaintsList> {
  var currentUnit;

  _MyFlatsComplaintsListState(this.currentUnit);

  @override
  Widget build(BuildContext context) {
    return
      DefaultTabController(
        length: 3,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            leading: FsBackButtonlight(),
            title: Text(
              'Complaints'.toLowerCase(),
              style: FSTextStyle.appbartextlight,
            ),
            elevation: 1.0,
            backgroundColor: FsColor.primaryflat,
            bottom: TabBar(
              labelStyle: TextStyle(
                  fontFamily: 'Gilroy-SemiBold', color: FsColor.white),
              indicatorColor: FsColor.white,
              tabs: [
                Tab(text: "Open".toLowerCase()),
                Tab(text: "Resolved".toLowerCase()),
                Tab(text: "Closed".toLowerCase()),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ComplaintsOpen(currentUnit, COMPLAINT_TYPE.OPEN),
              ComplaintsOpen(currentUnit, COMPLAINT_TYPE.RESOLVED),
              ComplaintsOpen(currentUnit, COMPLAINT_TYPE.CLOSED),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            tooltip: 'Increment',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        MyFlatsComplaintsAdd(
                            this.currentUnit)),
              );
            },
            child: const Icon(Icons.add),
          ),
        ),
      );
  }
}
