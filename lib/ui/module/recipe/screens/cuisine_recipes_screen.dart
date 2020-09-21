import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/home_recipe_item.dart';

const String testDevice = 'B9B920FEF2D8A4E599809C90DE19FF61';

class CuisineRecipesScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final String id;
  final String title;

  CuisineRecipesScreen({@required this.id, @required this.title});

  @override
  _CuisineRecipesScreenState createState() => _CuisineRecipesScreenState();
}

class _CuisineRecipesScreenState extends State<CuisineRecipesScreen> {
  List<Recipe> _recipes = List<Recipe>();
  String _path = HttpService.RECIPE_IMAGES_PATH;
  bool _isLoadingPage;
  var _paddingBottom = 48.0;

  /*BannerAd _bannerAd;

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );*/

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
    _getAllRecipes(widget.id);
    /*FirebaseAdMob.instance.initialize(appId: Constants.AppId);

    _bannerAd = createBannerAd()
      ..load().then((loaded) {
        if (loaded && this.mounted) {
          _bannerAd..show();
        }
      });*/
  }

  /* BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: Constants.bannerAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo);
  }*/

  _getAllRecipes(String id) async {
    await HttpService.getRecipeByCuisine(id).then((recipes) {
      setState(() {
        _recipes = recipes;
        _isLoadingPage = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    //hideBannerAd();
  }

  /* void hideBannerAd() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (_bannerAd != null) _bannerAd.dispose();
      _bannerAd = null;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: !_isLoadingPage
          ? (_recipes.isEmpty)
              ? Center(
                  child: Text(
                    'No Recipes to Display',
                    style: GoogleFonts.pacifico(),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(bottom: /*_paddingBottom*/ 0),
                  child: ListView.builder(
                    itemBuilder: (ctx, index) {
                      return HomeRecipeItem(
                        recipe: _recipes,
                        index: index,
                        path: _path,
                      );
                    },
                    itemCount: _recipes == null ? 0 : _recipes.length,
                  ),
                )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
