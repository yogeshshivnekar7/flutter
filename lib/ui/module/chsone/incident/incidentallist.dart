import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/maintenence_dues/maintenence_overdue.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';

class IncidentalList extends StatefulWidget {
  var currentUnit;

  // MyFlatsMaintenenceList

  IncidentalList(this.currentUnit);

  @override
  _IncidentalListState createState() => new _IncidentalListState(currentUnit);
}

class _IncidentalListState extends State<IncidentalList> {
  var currentUnit;

  _IncidentalListState(this.currentUnit);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double tabWidth = width / 6;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          leading: FsBackButtonlight(),
          title: Text(
            'Incidental Dues'.toLowerCase(),
            style: FSTextStyle.appbartextlight,
          ),
          elevation: 1.0,
          backgroundColor: FsColor.primaryflat,
        ),
        body: Center(
            child: MaintenenceOverdue(currentUnit, null, BILLTYPE.INCIDENTAL)));
  }
}
