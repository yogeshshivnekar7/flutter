import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/main_dashboard.dart';
import 'package:sso_futurescape/ui/module/vizlog/intercom/gate_list/gate_list.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitor_help.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';

import 'committee_members_list/intercom_committee.dart';
import 'member_view/intercom_allmembers.dart';
import 'query_change.dart';
// Ref Link : https://www.developerlibs.com/2018/06/flutter-apply-search-box-in-appbar.html

class MyVisitorsIntercomList extends StatefulWidget {
  var currenUnit;

  @override
  _MyVisitorsIntercomListState createState() =>
      new _MyVisitorsIntercomListState(currenUnit);

  MyVisitorsIntercomList(this.currenUnit);
}

class _MyVisitorsIntercomListState extends State<MyVisitorsIntercomList> {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  List _tabTitles = ["All Members", "Gate", "Committee Members"];

  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "Search query";

  var currentUnit;

  _MyVisitorsIntercomListState(this.currentUnit);

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
  }

  void _startSearch() {
    print("open search box");
    ModalRoute.of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("");
    });
  }

  /*Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment = CrossAxisAlignment.center;

    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            const Text('Seach box'),
          ],
        ),
      ),
    );
  }*/

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: FsColor.white.withOpacity(0.3)),
        border: InputBorder.none,
      ),
      style: TextStyle(
          color: _isSearching ? FsColor.basicprimary : FsColor.white,
          fontSize: FSTextStyle.h6size),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
    print("search query " + newQuery);
//    onQueryChange.changeQuery(newQuery);
//    intercomMember.search(newQuery);
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: Icon(
            Icons.clear,
            color: _isSearching ? FsColor.darkgrey : FsColor.white,
          ),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  void _backbtnClick(context) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainDashboard()),
            (Route<dynamic> route) => false);
//    Navigator.popUntil(
//        context, ModalRoute.withName('/dashboard'));
  }

  List<Widget> getTabs() {
    List<Widget> tabs = [];
    for (var tabTitle in _tabTitles) {
      tabs.add(Tab(
        text: tabTitle,
      ));
    }
    return tabs;
  }

  List<Widget> getTabPages() {
    return [IntercomAllMembers(), GateLists(currentUnit), IntercomCommittee()];
  }

  int getTabsCount() {
    return _tabTitles.length;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: getTabsCount(),
      child: Scaffold(
        appBar: new AppBar(
          elevation: 1,
          backgroundColor:
          /*_isSearching ? FsColor.white :*/ FsColor.primaryvisitor,
          leading: /* _isSearching ? FsBackButton() :*/ FsBackButtonlight(
            backEvent: (context) {
              _backbtnClick(context);
            },
          ),
          title:
          /* _isSearching
              ? _buildSearchField()
              : */
          Text(
            'Intercom'.toLowerCase(),
            style: FSTextStyle.appbartextlight,
          ),
//          actions: _buildActions(),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.help_outline,
                color: FsColor.white,
                size: 24,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MyVisitorHelp(comingFrom: "inter_help"),
                  ),
                );
              },
            )
          ],
          bottom: TabBar(
            onTap: (value) {
              print("v $value");
            },
            indicatorColor: FsColor.white,
            indicatorWeight: 2,
            labelColor: FsColor.white,
            unselectedLabelColor: FsColor.white.withOpacity(0.7),
            labelStyle: TextStyle(
                fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold'),
            isScrollable: true,
            tabs: getTabs(),
          ),
        ),
        body: TabBarView(
          children: getTabPages(),
        ),
      ),
    );
  }

//  OnQueryChange onQueryChange;

  onQueryChang(OnQueryChange onQueryChange) {
    print("onquerychage--- $onQueryChange");
//    this.onQueryChange = onQueryChange;
  }
}
