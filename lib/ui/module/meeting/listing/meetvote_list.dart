import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';

import 'meeting_list.dart';
import 'voting_list.dart';

class MeetVoteList extends StatefulWidget {

  var societyId;

  MeetVoteList({this.societyId});

  @override
  _MeetVoteListState createState() => new _MeetVoteListState();
}

class _MeetVoteListState extends State<MeetVoteList> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: FsBackButtonlight(backEvent: MeetVoteUtils.onBackPressed(context),),
          title: Text('Meetings'.toLowerCase(),
            style: FSTextStyle.appbartextlight,
          ),
          elevation: 0.0,
          backgroundColor: FsColor.primarymeeting,
        ),
        body: MeetingList(societyId: widget.societyId),
      ),
    );
  }

  Widget _getTabBar() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: FsBackButtonlight(backEvent: MeetVoteUtils.onBackPressed(context),),
          title: Text('View List'.toLowerCase(),
            style: FSTextStyle.appbartextlight,
          ),
          elevation: 0.0,
          // backgroundColor: FsColor.white,
          backgroundColor: FsColor.primarymeeting,
          // bottom: TabBar(
          //   indicatorColor: FsColor.primarymeeting,
          //   indicatorWeight: 2,
          //   labelColor: FsColor.primarymeeting,
          //   unselectedLabelColor: FsColor.secondarymeeting,
          //   labelStyle: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', letterSpacing: 0.5),
          //   labelPadding: EdgeInsets.all(0),
          //   tabs: [
          //     Tab(text: "Meeting".toLowerCase()),
          //     Tab(text: "Voting".toLowerCase()),
          //   ],
          // ),
          bottom: TabBar(
            indicatorColor: FsColor.white,
            indicatorWeight: 2,
            // labelColor: FsColor.primarymeeting,
            // unselectedLabelColor: FsColor.secondarymeeting,
            labelStyle: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', letterSpacing: 0.5),
            tabs: [
              Tab(text: "Meeting".toUpperCase()),
              Tab(text: "Voting".toUpperCase()),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            MeetingList(societyId: widget.societyId),
            VotingList(),
          ],
        ),
      ),
    );
  }
}
