import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sso_futurescape/ui/module/recipe/models/category.dart';
import 'package:sso_futurescape/ui/module/recipe/models/cuisine.dart';
import 'package:sso_futurescape/ui/module/recipe/models/recipe.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/categories_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/cuisine_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/home_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_add_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

import '../translation/app_localizations.dart';
import 'settings_screen.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = '/tabs-screen';

  final List<Recipe> mostCollected;
  final List<Recipe> recentRecipesWithLimit;
  final List<Recipe> allRecipes;
  final List<Recipe> recentRecipes;
  final List<Category> categories;
  final List<Cuisine> cuisine;
  final BuildContext loginContext;

  static _TabsScreenState a;

  static changeButton() {
    a.selectPage(0);
  }

  TabsScreen({this.allRecipes,
    this.recentRecipesWithLimit,
    this.recentRecipes,
    this.categories,
    this.cuisine,
    this.mostCollected,
    this.loginContext});

  @override
  _TabsScreenState createState() => a = _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;
  List<Recipe> mostCollected;
  List<Recipe> recentRecipesWithLimit;
  List<Recipe> allRecipes;
  List<Recipe> recentRecipes;
  List<Category> categories;
  List<Cuisine> cuisine;

  @override
  void initState() {
    super.initState();
    _retrieveData();
  }

  Future _retrieveData() async {
    var profile = await SsoStorage.getUserProfile();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', profile['user_id'].toString());
    prefs.setString('uid', profile['user_id'].toString());
    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('first_time');

    if (firstTime == null) {
      // first time
      prefs.setBool('first_time', false);
    }*/

    /*String lang = prefs.getString('lang');
    if (lang == 'en') {
      MyApp.setLocale(context, Locale('en', 'US'));
    } else if (lang == 'zh') {
      MyApp.setLocale(context, Locale('zh', 'CN'));
    }*/
    //MyApp.setLocale(context, Locale('en', 'US'));
    // Get all categories
    await HttpService.getCategories().then((c) {
      setState(() {
        categories = c;
        print('Retrieved All Categories');
      });
    });

    // Get all cuisine
    await HttpService.getCuisine().then((c) {
      setState(() {
        cuisine = c;
        print('Retrieved All Cuisine');
      });
    });

    // Get all recipes
    await HttpService.getAllRecipes().then((r) {
      setState(() {
        allRecipes = r;
        print('Retrieved All Recipes');
      });
    });

    // Get most collected recipes
    await HttpService.getMostCollectedRecipes().then((r) {
      setState(() {
        mostCollected = r;
        print('Retrieved Most Collected Recipes');
      });
    });

    // Get recent recipes with a limit
    await HttpService.getRecentRecipesWithLimit().then((r) {
      setState(() {
        recentRecipesWithLimit = r;
        print('Retrieved Recent Recipes With Limit');
      });
    });

    // Get all recent recipes
    await HttpService.getRecentRecipes().then((r) {
      setState(() {
        recentRecipes = r;
        print('Retrieved All Recent Recipes');
      });
    });

    setState(() {
      isRetrieving = false;
    });
  }

  bool isRetrieving = true;

  void selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  Widget _appBar(BuildContext context) {
    return AppBar(
      centerTitle: true,
      brightness: Brightness.light,
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      title: Text(
        _pages[_selectedPageIndex]['title'],
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  Widget _body(BuildContext context) {
    return Stack(
      children: <Widget>[
        _pages[_selectedPageIndex]['page'],
      ],
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      onTap: selectPage,
      elevation: 0,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.black26,
      selectedItemColor: Theme.of(context).primaryColor,
      currentIndex: _selectedPageIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ic_home.png', scale: 2.2),
          activeIcon:
          Image.asset('assets/images/ic_home_filled.png', scale: 2.2),
          title: Text('Home'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ic_category.png', scale: 2.2),
          activeIcon:
          Image.asset('assets/images/ic_category_filled.png', scale: 2.2),
          title: Text('Categories'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ic_add.png', scale: 2.2),
          activeIcon:
          Image.asset('assets/images/ic_add_filled.png', scale: 2.2),
          title: Text('Add Recipe'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ic_country.png', scale: 2.2),
          activeIcon:
          Image.asset('assets/images/ic_country_filled.png', scale: 2.2),
          title: Text('Cuisine'),
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/images/ic_profile.png', scale: 1.9),
          activeIcon:
          Image.asset('assets/images/ic_profile_filled.png', scale: 1.9),
          title: Text('CookBook'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _pages = [
      {
        'page': HomeScreen(
          mostCollectedRecipes: mostCollected,
          allRecipes: allRecipes,
        ),
        'title': AppLocalizations.of(context).translate('home'),
      },
      {
        'page': CategoriesScreen(
          categories: categories,
        ),
        'title': AppLocalizations.of(context).translate('categories'),
      },
      {
        'page': AddRecipeScreen(),
        'title': 'Add Recipe',
      },
      {
        'page': CuisineScreen(cuisine),
        'title': AppLocalizations.of(context).translate('cuisine'),
      },
      {
        'page': SettingsScreen(),
        'title': '',
      },
    ];
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: isRetrieving ? PageLoader() : _body(context),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }
}
