import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_config/utils/firebase/firebase_dynamiclink.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:getflutter/getflutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/recipe/models/comment.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/profile_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/utils/util.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

import '../constants.dart';
import '../database/cookbook_db_helper.dart';
import '../translation/app_localizations.dart';

final BaseCacheManager baseCacheManager = DefaultCacheManager();

const String testDevice = 'B9B920FEF2D8A4E599809C90DE19FF61';

class RecipeDetailsScreen extends StatefulWidget {
  static const routeName = '/meal-detail';

  String id,
      name,
      image,
      duration,
      serving,
      difficulty,
      cuisine,
      categories,
      ingredients,
      steps,
      userId,
      fName,
      lName,
      userImage,
      type,
      date;

  RecipeDetailsScreen(
      {this.id,
      this.name,
      this.image,
      this.duration,
      this.serving,
      this.difficulty,
      this.cuisine,
      this.categories,
      this.ingredients,
      this.steps,
      this.userId,
      this.fName,
      this.lName,
      this.userImage,
      this.date,
      this.type});

  @override
  RecipeDetailsScreenState createState() => RecipeDetailsScreenState();
}

class RecipeDetailsScreenState extends State<RecipeDetailsScreen> {
  List<String> _ingredients = new List<String>();
  List<String> _steps = new List<String>();
  List _selectedIngredients = List();
  List<Comment> comments = new List<Comment>();

  var db = new CookBookDatabaseHelper();

  TextEditingController _commentTextController;
  String recipeId, userId;
  int savedRecipeId;
  String _recipeImagesPath = HttpService.RECIPE_IMAGES_PATH;
  String _uerImagesPath = HttpService.USER_IMAGES_PATH;

  double _iconRating = 0.0;
  double _globalRating = 0.0;
  int _likes = 0;
  bool _isFollowing = false;

  /*InterstitialAd _interstitialAd;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
  );*/
  bool _isLoadingPage = false;

  @override
  Future<void> initState() {
    super.initState();
    if (widget.type != null) {
      print("widget.type");
      print(widget.type);
      getRecipeById();
    } else {
      call();

      /*FirebaseAdMob.instance.initialize(appId: Constants.AppId);
    createInterstitialAd()
      ..load()
      ..show();*/
    }
  }

  void call() {
    _commentTextController = TextEditingController();
    _getUserIdFromPreferences().then((value) {
      setState(() {
        userId = value;
        print('USERID: $userId');
      });
    });

    _getIngredients();
    _getSteps();
    _getRecipeIfExist();
    _getUserRate();
    _getRecipeRate();
    _getRecipeLikes();
    _checkIfUserIsFollowing();
    _getRecipeComments();

    HttpService.updateRecipeViews(widget.id);
  }

  Future getRecipeById() async {
    _isLoadingPage = true;
    await HttpService.getRecipeByRecipeID(widget.id).then((recipes) {
      print(recipes);
      //[{"recipe_id":"26","recipe_name":"dipesb","recipe_image":"image_21036.jpg","recipe_duration":"79"
      // ,"recipe_serving":"89","recipe_difficulty":"Hard","cuisine_id":"7","category_id":"Seafood",
      // "recipe_ingredients":"sbdb\nshsbs","recipe_steps":"snsns","views":"1","date":"2020-07-30 12:01:25"
      // ,"user_id":"41694","likes":"0","fname":"Dipesh","lname":"Jain"}]
      /*setState(() {
        //_recipes = recipes;
        _isLoadingPage = false;
      });*/
      if (recipes.length > 0) {
        Recipe map = recipes[0];
        widget.id = map.recipeid.toString();
        widget.name = map.name.toString();
        widget.image = map.image.toString();
        widget.duration = map.duration.toString();
        widget.serving = map.serving.toString();
        widget.difficulty = map.difficulty.toString();
        widget.cuisine = map.cuisine.toString();
        widget.categories = map.categories.toString();
        widget.ingredients = map.ingredients.toString();
        widget.steps = map.steps.toString();
        widget.userId = map.userId.toString();
        widget.fName = map.fname.toString();
        widget.lName = map.lname.toString();
        widget.userImage = map.userimage.toString();
        widget.date = map.date.toString();
        setState(() {
          _isLoadingPage = false;
          call();
        });
      } else {
        Toasly.error(context, "Recipe not found!");
        Navigator.pop(context);
      }
    });
  }

  void dispose() {
    _commentTextController.dispose();
    // _interstitialAd?.dispose();
    super.dispose();
  }

  Future<void> _getRecipeComments() async {
    await HttpService.getRecipeComments(widget.id).then((value) {
      setState(() {
        comments = value;
      });
    });
  }

  Future<String> _getUserIdFromPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.get('uid') != null) {
      return prefs.get('uid');
    } else {
      return prefs.getString('id');
    }
  }

  Future<void> _getUserRate() async {
    await HttpService.getUserRateOfRecipe(widget.id, userId).then((value) {
      if (value != null) {
        setState(() {
          _iconRating = double.parse(value);
        });
      }
    });
  }

  Future<void> _addUserFollower() async {
    await HttpService.addUserFollow(userId, widget.userId).then((value) {
      if (value == true) {
        setState(() {
          _isFollowing = true;
        });
      } else {
        setState(() {
          _isFollowing = false;
        });
      }
    });
  }

  Future<void> _addUserRate(double rate) async {
    await HttpService.addUserRate(userId, rate, widget.id);
  }

  Future<void> _getRecipeRate() async {
    await HttpService.getRecipeRate(widget.id).then((value) {
      if (value != null) {
        setState(() {
          try {
            _globalRating = double.parse(value);
          } catch (e) {
            _globalRating = 0.0;
          }
        });
      }
    });
  }

  Future<void> _getRecipeLikes() async {
    await HttpService.getRecipeLikes(widget.id).then((value) {
      setState(() {
        try {
          if (value != null) {
            _likes = value;
          }
        } catch (e) {
          _likes = 0;
        }
      });
    });
  }

  Future<void> _checkIfUserIsFollowing() async {
    await HttpService.checkIfUserIsFollowing(userId, widget.userId)
        .then((value) {
      if (value == true) {
        setState(() {
          _isFollowing = true;
        });
      } else {
        setState(() {
          _isFollowing = false;
        });
      }
    });
  }

  Future<void> _addRecipeComment(String comment) async {
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
    await HttpService.addRecipeComment(userId, widget.id, comment);
  }

  /*InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: '$Constants.interstitialAdUnitId',
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {});
  }*/

  _getIngredients() {
    String htmlString = widget.ingredients;

    if (widget.ingredients.contains('<li>')) {
      List<dom.Element> ps = parse(htmlString.replaceAll('<br>', '</li><li>'))
          .querySelectorAll('li');
      if (ps.isNotEmpty)
        ps.forEach((f) {
          if (f.text != '') {
            _ingredients.add(f.text);
          }
        });
    } else {
      LineSplitter ls = new LineSplitter();
      List<String> lines = ls.convert(widget.ingredients);
      for (var i = 0; i < lines.length; i++) {
        _ingredients.add(lines[i]);
      }
    }
  }

  _getSteps() {
    if (widget.steps.contains('<li>')) {
      String htmlString = widget.steps;
      List<dom.Element> ps = parse(htmlString.replaceAll('<br>', '</li><li>'))
          .querySelectorAll('li');
      if (ps.isNotEmpty)
        ps.forEach((f) {
          if (f.text != '') {
            _steps.add(f.text);
          }
        });
    } else {
      LineSplitter ls = new LineSplitter();
      List<String> lines = ls.convert(widget.steps);
      for (var i = 0; i < lines.length; i++) {
        _steps.add(lines[i]);
      }
    }
  }

  void _onIngredientSelected(bool selected, id) {
    if (selected == true) {
      setState(() {
        _selectedIngredients.add(id);
      });
    } else {
      setState(() {
        _selectedIngredients.remove(id);
      });
    }
  }

  Future<void> _addToFavorite() async {
    if (recipeId == null) {
      savedRecipeId = await db.saveRecipe(
        new Recipe(
            id: widget.id,
            name: widget.name,
            image: widget.image,
            duration: widget.duration,
            serving: widget.serving,
            difficulty: widget.difficulty,
            categories: widget.categories,
            cuisine: widget.cuisine,
            ingredients: widget.ingredients,
            steps: widget.steps,
            userId: widget.userId,
            userimage: widget.userImage,
            date: widget.date,
            lname: widget.lName,
            fname: widget.fName),
      );
      await HttpService.updateRecipeLikes(widget.id, 'plus');
      _getRecipeLikes();
      setState(() {
        recipeId = savedRecipeId.toString();
      });
    } else {
      savedRecipeId = await db.deleteRecipe(int.parse(widget.id));
      await HttpService.updateRecipeLikes(widget.id, 'minus');
      _getRecipeLikes();
      setState(() {
        recipeId = null;
      });
    }
  }

  // From local database
  Future<String> _getRecipeIfExist() async {
    await db.getRecipe(int.parse(widget.id)).then((value) {
      if (value != null) {
        setState(() {
          recipeId = value.id;
        });
      } else {
        return null;
      }
    });
    return recipeId;
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: _isLoadingPage
            ? PageLoader()
            : SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 55),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 280,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          cacheManager: baseCacheManager,
                          imageUrl: _recipeImagesPath + widget.image,
                          placeholder: (context, url) =>
                              ShimmerWidget(
                                width: double.infinity,
                                height: double.infinity,
                                circular: false,
                              ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: FlatButton(
                              color: Colors.white.withOpacity(0.5),
                              child: Icon(
                                Icons.arrow_back,
                                size: 25,
                              ),
                              shape: new CircleBorder(),
                              onPressed: () =>
                                  Navigator.pop(context, false),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 250, 0, 0),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 20,
                                    left: 25,
                                    right: 5,
                                    bottom: 5),
                                child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Expanded(
                                        flex: 2,
                                        child: AutoSizeText(widget.name,
                                            minFontSize: 18,
                                            maxLines: 2,
                                            overflow:
                                            TextOverflow.visible,
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: FsColor
                                                    .primaryrecipe)),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                            children: <Widget>[
                                              InkWell(
                                                child: Icon(
                                                  Icons.share,
                                                  size: 27,
                                                ),
                                                onTap: () =>
                                                    baseCacheManager
                                                        .getSingleFile(
                                                        _recipeImagesPath +
                                                            widget.image)
                                                        .then((info) {
                                                      info.readAsBytes().then(
                                                              (bytes) async {
                                                            await Share.file(
                                                                '${Constants
                                                                    .sharingRecipeTitle}',
                                                                'esys.png',
                                                                bytes.buffer
                                                                    .asUint8List(),
                                                                'image/png',
                                                                text: 'I found this amazing ${widget
                                                                    .name} recipe on oneapp by Chef ${widget
                                                                    .fName +
                                                                    " " + widget
                                                                    .lName}, download oneapp for more details \n ' +
                                                                    await getRecipeIDLink(
                                                                        widget
                                                                            .id,
                                                                        widget
                                                                            .fName,
                                                                        widget
                                                                            .lName,
                                                                        widget
                                                                            .name)
                                                              /*'${Constants.sharingRecipeText} \n https://play.google.com/store/apps/details?id=${Constants.GooglePlayIdentifier}'*/);
                                                          });
                                                    }),
                                              ),
                                              SizedBox(
                                                width: 7,
                                              ),
                                              InkWell(
                                                child: recipeId != null
                                                    ? Icon(
                                                  Icons.favorite,
                                                  color: Colors.red,
                                                  size: 27,
                                                )
                                                    : Icon(
                                                  Icons
                                                      .favorite_border,
                                                  color: Colors.red,
                                                  size: 27,
                                                ),
                                                onTap: _addToFavorite,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .only(left: 10),
                                                  child: Container(
                                                      child: AutoSizeText(
                                                          '$_likes',
                                                          style: TextStyle(
                                                              fontSize:
                                                              19,
                                                              color: Colors
                                                                  .black))),
                                                ),
                                              )
                                            ]),
                                      )
                                    ])),
                            SizedBox(
                              height: 5,
                            ),
                            (widget.userId != userId)
                                ? GestureDetector(
                              onTap: () =>
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: (context) =>
                                          ProfileScreen(
                                              widget.userId,
                                              widget.userImage,
                                              widget.fName,
                                              widget.lName))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 25),
                                child: authorRecipeItem(
                                    widget.userId,
                                    widget.userImage,
                                    widget.fName,
                                    widget.lName,
                                    widget.date),
                              ),
                            )
                                : Container(),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25),
                              child: Row(
                                children: <Widget>[
                                  detailsContainer(
                                      context,
                                      AppLocalizations.of(context)
                                          .translate('no_of_serving'),
                                      widget.serving),
                                  detailsContainer(
                                      context,
                                      AppLocalizations.of(context)
                                          .translate('difficulty'),
                                      widget.difficulty),
                                  detailsContainer(
                                      context,
                                      AppLocalizations.of(context)
                                          .translate('duration'),
                                      Util.getDuration(widget.duration)),
                                ],
                              ),
                            ),
                            buildSectionTitle(context, 'Rate Recipe'),
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  child: (_iconRating != null)
                                      ? GFRating(
                                    color: FsColor.primaryrecipe,
                                    borderColor:
                                    FsColor.primaryrecipe,
                                    allowHalfRating: true,
                                    halfFilledIcon: Icon(
                                      Icons.star_half,
                                      size: 30,
                                      color: FsColor.primaryrecipe,
                                    ),
                                    filledIcon: Icon(
                                      Icons.star,
                                      size: 30,
                                      color: FsColor.primaryrecipe,
                                    ),
                                    size: GFSize.SMALL,
                                    value: _iconRating,
                                    onChanged: (value) {
                                      setState(() {
                                        _iconRating = value;
                                        _addUserRate(_iconRating);
                                        _getRecipeRate();
                                      });
                                    },
                                  )
                                      : GFRating(
                                    color: FsColor.primaryrecipe,
                                    borderColor:
                                    FsColor.primaryrecipe,
                                    allowHalfRating: true,
                                    halfFilledIcon: Icon(
                                      Icons.star_half,
                                      size: 30,
                                      color: FsColor.primaryrecipe,
                                    ),
                                    filledIcon: Icon(
                                      Icons.star,
                                      size: 30,
                                      color: FsColor.primaryrecipe,
                                    ),
                                    size: GFSize.SMALL,
                                    value: 0,
                                    onChanged: (value) {
                                      setState(() {
                                        _iconRating = value;
                                        _addUserRate(_iconRating);
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7),
                                  child: (_globalRating != 0.0 &&
                                      _globalRating.toString() !=
                                          'NaN')
                                      ? Text('$_globalRating')
                                      : Container(),
                                ),
                              ],
                            ),
                            buildSectionTitle(
                                context,
                                AppLocalizations.of(context)
                                    .translate('ingredients')),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                MediaQuery.removePadding(
                                  context: context,
                                  removeTop: true,
                                  child: (_ingredients != null &&
                                      _ingredients.length > 0)
                                      ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                    const NeverScrollableScrollPhysics(),
                                    itemExtent: 40,
                                    itemBuilder: (ctx, index) =>
                                        checkBoxListTile(
                                            context,
                                            _selectedIngredients,
                                            index,
                                            _ingredients),
                                    itemCount: _ingredients.length,
                                  )
                                      : Center(
                                    child:
                                    CircularProgressIndicator(),
                                  ),
                                ),
                              ],
                            ),
                            buildSectionTitle(
                                context,
                                AppLocalizations.of(context)
                                    .translate('steps')),
                            MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: _steps.isNotEmpty
                                  ? ListView.builder(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, index) =>
                                    Card(
                                      elevation: 0,
                                      child: stepsListTile(
                                          context, index, _steps),
                                    ),
                                itemCount: _steps.length,
                              )
                                  : Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            buildSectionTitle(context, 'Comments'),
                            addCommentForm(context),
                            MediaQuery.removePadding(
                              context: context,
                              removeTop: true,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemBuilder: (ctx, index) =>
                                    commentListItem(
                                        context, comments, index),
                                itemCount: comments.length,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 250,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget authorRecipeItem(
      String userId, String image, String fname, String lname, String date) {
    String path = HttpService.USER_IMAGES_PATH;
    return Row(
      children: [
        (image != null)
            ? (image.contains('https://platform-lookaside.fbsbx.com') ||
                    image.contains('https://lh3.googleusercontent.com'))
                ? CircleAvatar(
                    backgroundImage: NetworkImage('$image'),
                    backgroundColor: Colors.white,
                  )
                : CircleAvatar(
                    backgroundImage: NetworkImage('$path$image'),
                    backgroundColor: Colors.white,
                  )
            : CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: AssetImage('assets/images/logo_user.png'),
              ),
        SizedBox(
          width: 10,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$fname $lname',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Spacer(),
        Container(
          width: 80,
          height: 28,
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: FlatButton(
            padding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: 0.5,
                  color: (_isFollowing == false) ? Colors.black : Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(3))),
            onPressed: () => _addUserFollower(),
            color:
            (_isFollowing == false) ? Colors.white : FsColor.primaryrecipe,
            child: (_isFollowing == false)
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
      ],
    );
  }

  Widget buildSectionTitle(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 25, right: 25, bottom: 3),
      child: Container(
        child: AutoSizeText(
          text,
          style: GoogleFonts.pacifico(color: Colors.black, fontSize: 18),
        ),
      ),
    );
  }

  Widget detailsContainer(BuildContext context, String title, String value) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 5, top: 10, bottom: 10, right: 5),
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: FsColor.primaryrecipe, width: 0.4),
            borderRadius: BorderRadius.circular(5)),
        child: Column(
          children: <Widget>[
            AutoSizeText(title,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 16,
                    fontFamily: 'Raleway')),
            AutoSizeText(value,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    fontFamily: 'Raleway')),
          ],
        ),
      ),
    );
  }

  Widget checkBoxListTile(
      BuildContext context, List selecteditems, int index, List items) {
    return CheckboxListTile(
      dense: true,
      controlAffinity: ListTileControlAffinity.leading,
      value: selecteditems.contains(index),
      onChanged: (bool selected) {
        setState(() {
          _onIngredientSelected(selected, index);
        });
      },
      title: AutoSizeText(
        items[index],
        style: GoogleFonts.lato(fontSize: 14.5, fontWeight: FontWeight.normal),
        maxLines: 2,
      ),
    );
  }

  Widget stepsListTile(BuildContext context, int index, List items) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Row(
        children: <Widget>[
          AutoSizeText(
            '${index + 1}.',
            style: GoogleFonts.pacifico(),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: AutoSizeText(
              items[index],
              style: GoogleFonts.lato(fontSize: 14.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget addCommentForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              'Add a comment',
              style: TextStyle(fontSize: 15),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              border: Border.all(
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLength: 120,
                controller: _commentTextController,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.normal),
                maxLines: 3,
                cursorColor: Colors.black,
                decoration: InputDecoration.collapsed(
                    hintText: "Enter your comment here",
                    hintStyle: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.normal)),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FlatButton(
              color: FsColor.primaryrecipe,
              onPressed: () async {
                if (_commentTextController.value.text.isNotEmpty) {
                  await _addRecipeComment(_commentTextController.value.text);
                  setState(() {
                    _commentTextController.clear();
                  });
                  await _getRecipeComments();
                } else {
                  Fluttertoast.showToast(msg: 'Please write a comment');
                }
              },
              child: Text(
                'Add',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget commentListItem(
      BuildContext context, List<Comment> comments, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        child: Card(
          elevation: 1.5,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              children: [
                (comments[index].image != null)
                    ? (comments[index].image.contains(
                                'https://platform-lookaside.fbsbx.com') ||
                            comments[index]
                                .image
                                .contains('https://lh3.googleusercontent.com'))
                        ? CachedNetworkImage(
                            imageUrl: '${comments[index].image}',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => ShimmerWidget(
                              width: 50,
                              height: 50,
                              circular: true,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          )
                        : CachedNetworkImage(
                            imageUrl: '$_uerImagesPath${comments[index].image}',
                            imageBuilder: (context, imageProvider) => Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => ShimmerWidget(
                              width: 50,
                              height: 50,
                              circular: true,
                            ),
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 2,
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            '${comments[index].fName} ${comments[index].lName}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Spacer(),
                          Text(
                            '${getDate(comments, index)}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'RobotoCondensed',
                                fontSize: 14),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '${comments[index].comment}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                              softWrap: true,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: (comments[index].userId == userId)
                                ? InkWell(
                                    onTap: () async {
                                      await HttpService.deleteUserComment(
                                          comments[index].id);
                                      await _getRecipeComments();
                                    },
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: FsColor.primaryrecipe,
                                    ),
                                  )
                                : Container(),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getDate(List<Comment> comments, int index) {
    var dateTime =
    DateFormat("yyyy-MM-dd HH:mm:ss").parse(comments[index].date, true);
    var dateLocal = dateTime.toLocal();
    print(dateLocal);
    return AppUtils.getConvertDate(dateLocal.toString(),
        date_to_formate: "dd-MM-yyyy HH:mm:ss");
    //comments[index].date.substring(0, 16);
  }

  static Future<String> getRecipeIDLink(String id, String name, String lastName,
      String categories) async {
    Map my_data = {
      "r_id": id,
      //"s_ty": EnumToString.parse(businessAppMode).substring(0, 1)
    };
    Uri uri = await FirebaseDynamicLink.getLink(name + " " + lastName,
        categories, "share_recipe_${name} ${lastName}_${id}",
        data: my_data);
    //.then((uri) async {
    print(uri);
    return uri.toString();
    /*String s =
          "Hey, I found ${place["company_name"]} ${getTypeDetail()} on oneapp! "
          "Giving home deliveries at your ease. Stay home stay safe. Download 'oneapp' now! ${uri}";
      final RenderBox box = context.findRenderObject();*/
    // FsFacebookUtils.shareSubmitEvent(businessAppMode, place["company_name"]);
    //});
  }
}
