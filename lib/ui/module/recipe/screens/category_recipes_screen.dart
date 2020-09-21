import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/home_recipe_item.dart';

const String testDevice = 'B9B920FEF2D8A4E599809C90DE19FF61';

class CategoryRecipesScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final String id;
  final String title;

  CategoryRecipesScreen({this.id, this.title});

  @override
  _CategoryRecipesScreenState createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  List<Recipe> _recipes = List<Recipe>();
  String _path = HttpService.RECIPE_IMAGES_PATH;
  bool _isLoadingPage;
  var paddingBottom = 48.0;

  //BannerAd _bannerAd;

  /*static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );*/

  @override
  void initState() {
    super.initState();
    _isLoadingPage = true;
    _getAllRecipes(widget.id);
    //FirebaseAdMob.instance.initialize(appId: Constants.AppId);

    /*_bannerAd = createBannerAd()
      ..load().then((loaded) {
        if (loaded && this.mounted) {
          _bannerAd..show();
        }
      });*/
  }

  @override
  void dispose() {
    super.dispose();
    //hideBannerAd();
  }

  /*BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: Constants.bannerAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo);
  }*/

  /*void hideBannerAd() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (_bannerAd != null) _bannerAd.dispose();
      _bannerAd = null;
    });
  }*/

  // Get all recipes of a specific category
  _getAllRecipes(String id) async {
    await HttpService.getRecipeByCategory(widget.id).then((recipes) {
      setState(() {
        _recipes = recipes;
        _isLoadingPage = false;
      });
    });
  }

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
          color: Colors.black,
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
                  padding: EdgeInsets.only(
                    bottom: /*paddingBottom*/ 0,
                  ),
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
