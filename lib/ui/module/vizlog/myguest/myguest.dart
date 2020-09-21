import 'package:common_config/utils/fs_navigator.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/vizlog/myguest/myguest_pages/guest_expected.dart';
import 'package:sso_futurescape/ui/module/vizlog/myguest/myguest_pages/guest_notvisited.dart';
import 'package:sso_futurescape/ui/module/vizlog/myguest/myguest_pages/guest_visited.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitors_dashboard.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/responsive_widget.dart';

class MyGuest extends StatefulWidget {
  @override
  _MyGuestState createState() => new _MyGuestState();
}

class _MyGuestState extends State<MyGuest> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: ResponsiveWidget(
          primaryColor: FsColor.primaryvisitor,
          appBar: AppBar(
            leading: FsBackButtonlight(
              backEvent: (context) {
                backEvent(context);
              },
            ),
            title: Text(
              'My Guest'.toLowerCase(),
              style: FSTextStyle.appbartextlight,
            ),
            elevation: 0.0,
            backgroundColor: FsColor.primaryvisitor,
            bottom: TabBar(
              labelStyle: TextStyle(
                  fontFamily: 'Gilroy-SemiBold', color: FsColor.white),
              indicatorColor: FsColor.white,
              tabs: [
                // Tab(
                //   child: Container(
                //   margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                //   padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.center,
                //     crossAxisAlignment: CrossAxisAlignment.center,
                //     children: <Widget>[
                //       Text('Tab Text'),
                //       Container(
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.all(Radius.circular(15.0)),
                //           color: FsColor.red,
                //         ),
                //         alignment: Alignment.center,
                //         width: 20, height: 20,
                //         child: Text('4',
                //           style: TextStyle(
                //             fontSize: FSTextStyle.h7size,
                //             fontFamily: 'Gilroy-SemiBold',
                //             color: FsColor.white),
                //         ),
                //       )
                //     ],
                //   ),
                //   ),
                // ),
                Tab(text: "Expected".toLowerCase()),
                Tab(text: "Visited".toLowerCase()),
                Tab(text: "Not Visited".toLowerCase()),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GuestExpected(),
              GuestVisited(),
              GuestNotVisited(),
            ],
          ),
        ),
      ),
    );
  }
}

void backEvent(context) {
  FsNavigator.push(context, MyVisitorsDashboard());
}
