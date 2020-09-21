import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/translation/app_localizations.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/home_recipe_item.dart';

const String testDevice = 'B9B920FEF2D8A4E599809C90DE19FF61';

class RecipeRecentList extends StatefulWidget {
  final List<Recipe> _recentRecipes;

  RecipeRecentList(this._recentRecipes);

  @override
  _RecipeRecentListState createState() => _RecipeRecentListState();
}

class _RecipeRecentListState extends State<RecipeRecentList> {
  List<Recipe> recentRecipes;

  //BannerAd _bannerAd;
  var paddingBottom = 48.0;

  /*static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    nonPersonalizedAds: true,
    keywords: <String>['Game', 'Mario'],
  );*/

  @override
  void initState() {
    super.initState();
    /*FirebaseAdMob.instance.initialize(appId: Constants.AppId);

    _bannerAd = createBannerAd()
      ..load().then((loaded) {
        if (loaded && this.mounted) {
          _bannerAd..show();
        }
      });*/
  }

  /*BannerAd createBannerAd() {
    return BannerAd(
        adUnitId: Constants.bannerAdUnitId,
        //Change BannerAd adUnitId with Admob ID
        size: AdSize.banner,
        targetingInfo: targetingInfo);
  }*/

  /*@override
  void dispose() {
    super.dispose();
    hideBannerAd();
  }

  void hideBannerAd() {
    Future.delayed(Duration(milliseconds: 500), () {
      if (_bannerAd != null) _bannerAd.dispose();
      _bannerAd = null;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    recentRecipes = widget._recentRecipes;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Recent Recipes', style: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: (recentRecipes != null)
          ? Padding(
              padding: EdgeInsets.only(bottom: 0),
              child: ListView.builder(
                itemBuilder: (ctx, index) {
                  return HomeRecipeItem(
                    recipe: recentRecipes,
                    index: index,
                    path: HttpService.RECIPE_IMAGES_PATH,
                  );
                },
                itemCount: recentRecipes == null ? 0 : recentRecipes.length,
              ),
            )
          : Center(
              child: Text(
                AppLocalizations.of(context).translate('no_recent_recipes'),
                style: GoogleFonts.pacifico(fontSize: 17),
              ),
            ),
    );
  }
}
