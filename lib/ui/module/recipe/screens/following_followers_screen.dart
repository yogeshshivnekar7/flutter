import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/profile_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';

import '../models/user.dart';

class FollowingFollowersScreen extends StatefulWidget {
  final String _userId, _fName, _lName;
  final int index;

  FollowingFollowersScreen(this._userId, this._fName, this._lName, this.index);

  @override
  _FollowingFollowersScreenState createState() =>
      _FollowingFollowersScreenState();
}

class _FollowingFollowersScreenState extends State<FollowingFollowersScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  String _path = HttpService.USER_IMAGES_PATH;
  List<User> _following = new List<User>();
  List<User> _followers = new List<User>();
  List<String> choices = const <String>[
    'Followers',
    'Following',
  ];
  int followersCounts = 0;
  int followingCounts = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: 2, vsync: this, initialIndex: widget.index);

    // Get the number of followers and following
    _getFollowersFollowingCounts();
    // Get all the user followers
    _getUserFollowers();
    // Get all the user following
    _getUserFollowing();
  }

  Future _getFollowersFollowingCounts() async {
    await HttpService.getNumberOfFollowing(widget._userId).then((value) {
      setState(() {
        followingCounts = value;
      });
    });

    await HttpService.getNumberOfFollowers(widget._userId).then((value) async {
      setState(() {
        followersCounts = value;
      });
    });
  }

  Future<void> _getUserFollowers() async {
    await HttpService.getUserFollowers(widget._userId).then((value) {
      setState(() {
        _followers = value;
      });
    });

    setState(() {
      isLoading = false;
    });
  }

  Future<void> _getUserFollowing() async {
    await HttpService.getUserFollowing(widget._userId).then((value) {
      setState(() {
        _following = value;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          '${widget._fName} ${widget._lName}',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: getTabBar(),
          ),
          Expanded(
            child: getTabBarPages(),
          ),
        ],
      ),
    );
  }

  Widget getTabBar() {
    return TabBar(controller: _tabController, labelColor: Colors.black, tabs: [
      Tab(text: "$followersCounts  Followers"),
      Tab(text: "$followingCounts  Following"),
    ]);
  }

  Widget getTabBarPages() {
    return TabBarView(controller: _tabController, children: <Widget>[
      (!isLoading)
          ? (followersCounts == 0)
              ? Container(
                  child: Center(
                      child: Text('You have no followers',
                          textAlign: TextAlign.center)),
                )
              : followersFollowingList(context, _followers)
          : Center(
              child: CircularProgressIndicator(),
            ),
      (!isLoading)
          ? (followingCounts == 0)
              ? Container(
                  child: Center(
                      child: Text(
                          'You are not following anyone, start following!',
                          textAlign: TextAlign.center)))
              : followersFollowingList(context, _following)
          : Center(
              child: CircularProgressIndicator(),
            ),
    ]);
  }

  Widget followersFollowingList(BuildContext context, List<User> user) {
    return ListView.builder(
      itemCount: user.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                user[index].id,
                user[index].image,
                user[index].fname,
                user[index].lname,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              height: 70,
              child: Card(
                elevation: 1.5,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: [
                      (user[index].image != null)
                          ? (user[index].image.contains(
                                      'https://platform-lookaside.fbsbx.com') ||
                                  user[index].image.contains(
                                      'https://lh3.googleusercontent.com'))
                              ? CachedNetworkImage(
                                  imageUrl: '${user[index].image}',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => ShimmerWidget(
                                      width: 50, height: 50, circular: true),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                              : CachedNetworkImage(
                                  imageUrl: '$_path${user[index].image}',
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    width: 50.0,
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  placeholder: (context, url) => ShimmerWidget(
                                      width: 50, height: 50, circular: true),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                )
                          : CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  AssetImage('assets/images/logo_user.png'),
                              radius: 25,
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '${user[index].fname} ${user[index].lname}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
