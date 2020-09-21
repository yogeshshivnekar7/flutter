import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_details_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';

import '../models/recipe.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  final String userid, fname, lname, image;

  ProfileScreen(this.userid, this.image, this.fname, this.lname);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String path = HttpService.USER_IMAGES_PATH;
  List<Recipe> recipes = List<Recipe>();
  int followersCounts = 0;
  int followingCounts = 0;
  bool isFollowing = false;
  int recipeCounts = 0;

  @override
  void initState() {
    super.initState();
    _retrieveData();
    _checkIfUserIsFollowing();
    getRecipesById();
    getUserRecipesCount();
  }

  getUserRecipesCount() async {
    await HttpService.getUserRecipesCount(widget.userid).then((value) {
      setState(() {
        recipeCounts = value;
      });
    });
  }

  getRecipesById() async {
    await HttpService.getRecipesByUser(widget.userid).then((value) {
      setState(() {
        recipes = value;
        print("recipes.length");
        print(recipes.length);
      });
    });
  }

  Future<void> _retrieveData() async {
    await HttpService.getNumberOfFollowing(widget.userid).then((value) {
      print('VALUE: $value');
      setState(() {
        followingCounts = value;
      });
    });

    await HttpService.getNumberOfFollowers(widget.userid).then((value) async {
      print('VALUE: $value');
      setState(() {
        followersCounts = value;
      });
    });
  }

  Future<void> _addUserFollower() async {
    String userId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('uid') != null) {
      setState(() {
        userId = prefs.get('uid');
      });
    } else {
      setState(() {
        userId = prefs.getString('id');
      });
    }

    await HttpService.addUserFollow(userId, widget.userid).then((value) {
      if (value == true) {
        setState(() {
          isFollowing = true;
        });
      } else {
        setState(() {
          isFollowing = false;
        });
      }
    });
  }

  Future<void> _checkIfUserIsFollowing() async {
    String userId;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('uid') != null) {
      setState(() {
        userId = prefs.get('uid');
      });
    } else {
      setState(() {
        userId = prefs.getString('id');
      });
    }
    await HttpService.checkIfUserIsFollowing(userId, widget.userid)
        .then((value) {
      print('USER ID: ${widget.userid}');
      print('following: $value');
      if (value == true) {
        setState(() {
          isFollowing = true;
        });
      } else {
        setState(() {
          isFollowing = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          '${widget.fname} ${widget.lname}',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                (widget.image != null)
                    ? (widget.image.contains(
                                'https://platform-lookaside.fbsbx.com') ||
                            widget.image
                                .contains('https://lh3.googleusercontent.com'))
                        ? CachedNetworkImage(
                            imageUrl: '${widget.image}',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => ShimmerWidget(
                              width: 70,
                              height: 70,
                              circular: true,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : CachedNetworkImage(
                            imageUrl: '$path${widget.image}',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 70.0,
                              height: 70.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => ShimmerWidget(
                              width: 70,
                              height: 70,
                              circular: true,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage:
                            AssetImage('assets/images/logo_user.png'),
                        radius: 20,
                      ),
                Column(
                  children: [
                    Text('Recipes',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    (recipeCounts != 0)
                        ? Text('$recipeCounts',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal))
                        : Text('0',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                  ],
                ),
                Column(
                  children: [
                    Text('Following',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    (followingCounts != 0)
                        ? Text('$followingCounts',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal))
                        : Text('0',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                  ],
                ),
                Column(
                  children: [
                    Text('Followers',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600)),
                    (followersCounts != 0)
                        ? Text('$followersCounts',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal))
                        : Text('0',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 130),
            child: Container(
              width: 80,
              height: 28,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: FlatButton(
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.5,
                      color:
                          (isFollowing == false) ? Colors.black : Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                onPressed: () => _addUserFollower(),
                color: (isFollowing == false)
                    ? Colors.white
                    : FsColor.primaryrecipe,
                child: (isFollowing == false)
                    ? Text(
                        'Follow',
                        style: TextStyle(fontSize: 14),
                      )
                    : Text(
                        'Following',
                        maxLines: 1,
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            child: Text(
              'Recipes',
              style: GoogleFonts.pacifico(fontSize: 21),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: (recipes.isNotEmpty)
                  ? GridView.builder(
                      itemCount: recipes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: queryData.size.width /
                            queryData.size.height /
                            0.7, // can be 1.5
                        crossAxisSpacing:
                            6, // padding between items horizontally
                        mainAxisSpacing: 2, // padding between items vertically
                      ),
                      itemBuilder: (context, index) {
                        return userRecipeItem(context, recipes, index,
                            HttpService.RECIPE_IMAGES_PATH);
                      })
                  : Center(
                      child: Text(
                        '${widget.fname} doesn\'t have recipes!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.pacifico(fontSize: 18),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  void selectRecipe(BuildContext context, int index, List<Recipe> list) {
    print('FNAME: ${list[index].fname}');
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecipeDetailsScreen(
          id: list[index].recipeid,
          name: list[index].name,
          image: list[index].image,
          duration: list[index].duration,
          serving: list[index].serving,
          difficulty: list[index].difficulty,
          cuisine: list[index].cuisine,
          categories: list[index].categories,
          ingredients: list[index].ingredients,
          steps: list[index].steps,
          date: list[index].date,
          userId: list[index].userId,
          userImage: list[index].userimage,
          lName: list[index].lname,
          fName: list[index].fname,
        ),
      ),
    );
  }

  Widget userRecipeItem(
      BuildContext context, List<Recipe> list, int index, String path) {
    return InkWell(
      onTap: () => selectRecipe(context, index, list),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(2),
            child: CachedNetworkImage(
              imageUrl: '$path${list[index].image}',
              placeholder: (context, url) => ShimmerWidget(
                width: double.infinity,
                height: 100,
                circular: false,
              ),
              width: double.infinity,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Text(
              list[index].name,
              style: GoogleFonts.lato(fontSize: 14),
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
