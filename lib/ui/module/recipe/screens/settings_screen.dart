import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sso_futurescape/ui/module/recipe/constants.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/cookbook_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/following_followers_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/user_recipes_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import 'languages_screen.dart';

final BaseCacheManager baseCacheManager = DefaultCacheManager();

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings-screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // final GoogleSignIn googleSignIn = new GoogleSignIn();
  // final FacebookLogin facebookLogin = new FacebookLogin();
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  String fname, lname, image;
  String path = HttpService.USER_IMAGES_PATH;
  String id;
  String userid;
  int followersCounts = 0;
  int followingCounts = 0;

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  Future _retrieveData() async {
    var profileData = await SsoStorage.getUserProfile();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //
    //id = prefs.getString('id').toString();
    print(profileData);
    id = profileData["user_id"].toString();
    fname = profileData["first_name"];
    lname = profileData["last_name"];
    image = profileData["avatar_medium"] + "?dummy=0";
    /*if (id != 'null') {
      await HttpService.getUserInfo(id).then((value) {
        setState(() {
          if (value != null) {
            fname = value.fname;
            lname = value.lname;
            image = value.image;
          }
        });
      });
    }
    else if (await googleSignIn.isSignedIn()) {
      _auth.currentUser().then((value) {
        setState(() {
          List name = value.displayName.split(" ");
          fname = name[0];
          lname = name[1];
          image = value.photoUrl;
        });
      });
    }
    else if (await facebookLogin.isLoggedIn) {
      facebookLogin.currentAccessToken.then((value) async {
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${value.token}');
        final profile = await json.decode(graphResponse.body);
        setState(() {
          id = profile['id'];
          fname = profile['first_name'];
          lname = profile['last_name'];
          image = profile['picture']['data']['url'];
        });
      });
    }*/

    if (prefs.getString('id') != null) {
      setState(() {
        userid = prefs.getString('id');
      });
    } else {
      setState(() {
        userid = prefs.get('uid');
      });
    }

    await HttpService.getNumberOfFollowing(userid).then((value) {
      setState(() {
        followingCounts = value;
      });
    });

    await HttpService.getNumberOfFollowers(userid).then((value) {
      setState(() {
        followersCounts = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: <Widget>[
                (image != null)
                    ? (image.contains('https://platform-lookaside.fbsbx.com') ||
                            image.contains('https://lh3.googleusercontent.com'))
                        ? CachedNetworkImage(
                            imageUrl: '$image',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => ShimmerWidget(
                              width: 80,
                              height: 80,
                              circular: true,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : CachedNetworkImage(
                            imageUrl: /*$path*/ '$image',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => ShimmerWidget(
                              width: 80,
                              height: 80,
                              circular: true,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Shimmer.fromColors(
                            baseColor: Colors.grey[300],
                            highlightColor: Colors.grey[100],
                            child: Image.asset('assets/images/logo_user.png')),
                        radius: 40,
                      ),
                SizedBox(height: 10),
                (fname != null && lname != null)
                    ? Text(
                        '$fname $lname',
                        style: TextStyle(fontSize: 20),
                      )
                    : Container(
                        height: 23,
                        child: ShimmerWidget(
                          width: 120,
                          height: 20,
                          circular: false,
                        ),
                      ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FollowingFollowersScreen(
                                  userid, fname, lname, 1))),
                      child: Column(
                        children: [
                          Text('Following',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          (followingCounts != null)
                              ? Text('$followingCounts',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal))
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  child: Text('0',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FollowingFollowersScreen(
                                  userid, fname, lname, 0))),
                      child: Column(
                        children: [
                          Text('Followers',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600)),
                          (followersCounts != null)
                              ? Text('$followersCounts',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal))
                              : Shimmer.fromColors(
                                  baseColor: Colors.grey[300],
                                  highlightColor: Colors.grey[100],
                                  child: Text('0',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal)),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProfileView(),
                            //EditProfileScreen(retrieveData: _retrieveData),
                          )),
                      child: listViewItem(
                          context,
                          Icon(
                            Icons.person_pin,
                            color: Colors.black,
                          ),
                          'My Profile'),
                    ),
                    Divider(height: 1.5, indent: 15, endIndent: 15),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MyRecipesScreen(id),
                          )),
                      child: listViewItem(
                          context,
                          Icon(
                            Icons.assignment,
                            color: Colors.black,
                          ),
                          'My Recipes'),
                    ),
                    Divider(height: 1.5, indent: 15, endIndent: 15),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CookbookScreen(),
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/images/ic_cookbook_black.png',
                                  width: 24,
                                )),
                            SizedBox(
                              width: 15,
                            ),
                            Text('My Cookbook',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal)),
                            Spacer(),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 15,
                              color: Theme.of(context).iconTheme.color,
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Text(
                        'Other',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),*/
//                    InkWell(
//                      onTap: () => showModalBottomSheet(
//                        context: context,
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.only(
//                              topLeft: Radius.circular(30),
//                              topRight: Radius.circular(30)),
//                        ),
//                        backgroundColor: Colors.white,
//                        builder: (context) => Container(
//                          height: 200,
//                          child: ListView(
//                            children: [
//                              Padding(
//                                padding:
//                                    const EdgeInsets.fromLTRB(20, 20, 20, 20),
//                                child: Text('Settings'),
//                              ),
//                              Divider(height: 1.5, indent: 20, endIndent: 20),
//                              Padding(
//                                padding:
//                                    const EdgeInsets.symmetric(horizontal: 15),
//                                child: InkWell(
//                                  onTap: () => Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => LanguagesScreen(),
//                                    ),
//                                  ),
//                                  child: ListTile(
//                                    leading: Icon(
//                                      Icons.language,
//                                      color: Colors.black,
//                                    ),
//                                    title: Text(
//                                      'Language',
//                                      style: TextStyle(
//                                          fontFamily: 'RobotoCondensed',
//                                          fontSize: 18),
//                                    ),
//                                    trailing: Icon(
//                                      Icons.arrow_forward_ios,
//                                      size: 15,
//                                      color: Theme.of(context).iconTheme.color,
//                                    ),
//                                  ),
//                                ),
//                              ),
//                              Divider(height: 1.5, indent: 20, endIndent: 20),
//                            ],
//                          ),
//                        ),
//                      ),
//                      child: listViewItem(
//                          context,
//                          Icon(
//                            Icons.settings,
//                            color: Colors.black,
//                          ),
//                          'Settings'),
//                    ),
//                    Divider(height: 1.5, indent: 15, endIndent: 15),
                    /* InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PrivacyPolicyScreen(),
                          )),
                      child: listViewItem(
                          context,
                          Icon(
                            Icons.description,
                            color: Colors.black,
                          ),
                          'Privacy Policy'),
                    ),
                    Divider(height: 1.5, indent: 15, endIndent: 15),*/
                    /*InkWell(
                      onTap: () => LaunchReview.launch(
                          androidAppId: Constants.GooglePlayIdentifier,
                          iOSAppId: Constants.AppStoreIdentifier),
                      child: listViewItem(
                          context,
                          Icon(
                            Icons.rate_review,
                            color: Colors.black,
                          ),
                          'Rate Us'),
                    ),*/
                    // Divider(height: 1.5, indent: 15, endIndent: 15),
                    true == true
                        ? Container()
                        : InkWell(
                            onTap: () => _shareApp(),
                            child: listViewItem(
                                context,
                                Icon(
                                  Icons.share,
                                  color: Colors.black,
                                ),
                                'Share App'),
                          ),
                  ],
                ),
              ),
            ),
          ))
        ],
      ),
    );
  }

  Widget listViewItem(BuildContext context, Icon icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          CircleAvatar(backgroundColor: Colors.white, child: icon),
          SizedBox(
            width: 15,
          ),
          Text(text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal)),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            size: 15,
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
    );
  }

  Future<void> _shareApp() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
      ),
      backgroundColor: Colors.white,
      builder: (context) => Container(
        height: 150,
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 20),
              child: Text('Share'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LanguagesScreen(),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () async {
                        /*FlutterShareMe().shareToFacebook(
                            url:
                                'https://play.google.com/store/apps/details?id=${Constants.GooglePlayIdentifier}',
                            msg: '${Constants.sharingAppText}');*/
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(50),
                              bottomRight: Radius.circular(50)),
                          color: Colors.white,
                        ),
                        height: 60,
                        width: 60,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          color: Colors.white,
                          child: Image.asset(
                            'assets/images/ic_facebook_share.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => Share.text(
                          '${Constants.sharingAppText}',
                          '${Constants.sharingAppText} \n https://play.google.com/store/apps/details?id=${Constants.GooglePlayIdentifier}',
                          'text/plain'),
                      child: Container(
                        height: 60,
                        width: 60,
                        child: Card(
                          color: Colors.white70,
                          child: Center(
                              child: Text(
                            'Other',
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return null;
  }
}
