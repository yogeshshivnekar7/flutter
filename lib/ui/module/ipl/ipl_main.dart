import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/ipl/api_call.dart';
import 'package:sso_futurescape/ui/module/ipl/ipl_card.dart';
import 'package:sso_futurescape/ui/module/ipl/ipl_leaderboard.dart';
import 'package:sso_futurescape/ui/module/ipl/ipl_participatequiz.dart';
import 'package:sso_futurescape/ui/module/ipl/ipl_predictwinner.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';

class IplMain extends StatefulWidget {
  List<UserProfile> userprofile;

  IplMain({this.userprofile});

  @override
  _IplMainState createState() => new _IplMainState();
}

class _IplMainState extends State<IplMain> with SingleTickerProviderStateMixin {
  int userid;
  TabController _tabController;
  bool loading = false;

  Future fetchdata() async {
    if (widget.userprofile != null) {
      await fetchIplUser(
              widget.userprofile[0].firstname,
              widget.userprofile[0].lastname,
              widget.userprofile[0].userid,
              widget.userprofile[0].mobile)
          .then((value) {
        if (value != null) {
          if (mounted) {
            setState(() {
              userid = value['data']['auth_id'];
              loading = false;
            });
          }
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    FsFacebookUtils.callCartClick("ipl_card_click", "card");
    setState(() {
      loading = true;
    });
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(_handleTabIndex);
    fetchdata();
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabIndex);
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabIndex() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Scaffold(
      body: PageLoader(
        title: '',
      ),
    )
        : Scaffold(
      appBar: AppBar(
        leading: FsBackButtonlight(),
        title: Text(
          _tabController.index == 0
              ? 'Predict winner'.toLowerCase()
              : _tabController.index == 1
              ? 'Participate in Quiz'.toLowerCase()
              : 'Leaderboard'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 0.0,
        backgroundColor: FsColor.primaryipl,
      ),
      bottomNavigationBar: Card(
        margin: EdgeInsets.all(10),
        elevation: 5,
        child: TabBar(
            controller: _tabController,
            // indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: FsColor.primaryipl,
            indicatorWeight: 3,
            labelColor: FsColor.primaryipl,
            unselectedLabelColor: FsColor.darkgrey.withOpacity(0.65),
            labelStyle: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                letterSpacing: 0.5),
            labelPadding: EdgeInsets.all(0),
            tabs: [
              Tab(text: "Predict winner"),
              Tab(text: "Quiz"),
              Tab(
                text: "Leaderboard",
              ),
            ]),
      ),
      body: DefaultTabController(
        length: 3,
        child: TabBarView(
          controller: _tabController,
          children: [
            IplPredictWinner(
              userid: userid,
              action: (var action) {
                _tabController.animateTo((_tabController.index + 1) % 3);
              },
            ),
            IplParticipateQuiz(
              userid: userid,
              action: (var action) {
                _tabController.animateTo((_tabController.index + 1) % 3);
              },
            ),
            IplLeaderboard(
              userid: userid,
            ),
          ],
        ),
      ),
    );
  }
}
