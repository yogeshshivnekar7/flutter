import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/recipe/database/cookbook_db_helper.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_details_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/utils/util.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';

import '../constants.dart';
import '../translation/app_localizations.dart';

final BaseCacheManager baseCacheManager = DefaultCacheManager();

const String testDevice = 'B9B920FEF2D8A4E599809C90DE19FF61';

class CookbookRecipeDetailsScreen extends StatefulWidget {
  static const routeName = '/meal-detail';

  final String id,
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
      date;

  CookbookRecipeDetailsScreen(
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
      this.date});

  @override
  _CookbookRecipeDetailsScreenState createState() =>
      _CookbookRecipeDetailsScreenState();
}

class _CookbookRecipeDetailsScreenState
    extends State<CookbookRecipeDetailsScreen> {
  List<String> _ingredients = new List<String>();
  List<String> _steps = new List<String>();
  List _selectedIngredients = List();
  var db = new CookBookDatabaseHelper();
  String recipeId;
  int savedRecipeId;
  String recipeImagesPath = HttpService.RECIPE_IMAGES_PATH;

  // InterstitialAd _interstitialAd;

  bool isFollowing = false;

  /*static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
  );*/

  @override
  void initState() {
    super.initState();
    _getIngredients();
    _getSteps();
    getRecipeIfExist();

    /* FirebaseAdMob.instance.initialize(appId: Constants.AppId);
    createInterstitialAd()
      ..load()
      ..show();*/
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
    await HttpService.addUserFollow(userId, widget.userId).then((value) {
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

  /*InterstitialAd createInterstitialAd() {
    return InterstitialAd(
        adUnitId: '$Constants.interstitialAdUnitId',
        targetingInfo: targetingInfo,
        listener: (MobileAdEvent event) {});
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }*/

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
      setState(() {
        recipeId = savedRecipeId.toString();
      });
    } else {
      savedRecipeId = await db.deleteRecipe(int.parse(widget.id));
      setState(() {
        recipeId = null;
      });
    }
  }

  // From local database
  Future<String> getRecipeIfExist() async {
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

  Future<void> _shareRecipes() {
    baseCacheManager
        .getSingleFile(recipeImagesPath + widget.image)
        .then((info) {
      info.readAsBytes().then((bytes) async {
        await Share.file('${Constants.sharingRecipeTitle}', 'esys.png',
            bytes.buffer.asUint8List(), 'image/png',
            text:
                'I found this amazing ${widget.name} recipe on oneapp by Chef ${widget.fName + " " + widget.lName}, download oneapp for more details \n ' +
                    await RecipeDetailsScreenState.getRecipeIDLink(
                        widget.id, widget.fName, widget.lName, widget.name));
        //https://play.google.com/store/apps/details?id=${Constants.GooglePlayIdentifier}
      });
    });
    return null;
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
                  color: (isFollowing == false) ? Colors.black : Colors.white,
                ),
                borderRadius: BorderRadius.all(Radius.circular(3))),
            onPressed: () => _addUserFollower(),
            color: (isFollowing == false) ? Colors.white : FsColor
                .primaryrecipe,
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 280,
                        width: double.infinity,
                        child: CachedNetworkImage(
                          cacheManager: baseCacheManager,
                          imageUrl: recipeImagesPath + widget.image,
                          placeholder: (context, url) => ShimmerWidget(
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
                              onPressed: () => Navigator.pop(context, false),
                            ),
                          ),
                          Spacer(),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: FlatButton(
                              color: Colors.white.withOpacity(0.5),
                              child: Icon(
                                Icons.share,
                                size: 25,
                              ),
                              shape: new CircleBorder(),
                              onPressed: _shareRecipes,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: FlatButton(
                              color: Colors.white.withOpacity(0.5),
                              child: recipeId != null
                                  ? Icon(
                                      Icons.favorite,
                                      size: 25,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      size: 25,
                                    ),
                              shape: new CircleBorder(),
                              onPressed: _addToFavorite,
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
                                    top: 20, left: 25, right: 25, bottom: 5),
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Expanded(
                                        child: AutoSizeText(widget.name,
                                            minFontSize: 20,
                                            maxLines: 2,
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: FsColor.primaryrecipe)),
                                      ),
                                    ])),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
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
                                  child: _ingredients.isNotEmpty
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
                                          itemCount: _ingredients == null
                                              ? 0
                                              : _ingredients.length,
                                        )
                                      : Center(
                                          child: CircularProgressIndicator(),
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
                                      itemBuilder: (ctx, index) => Card(
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
