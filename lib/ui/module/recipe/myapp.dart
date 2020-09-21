import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/category_recipes_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/home_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/login_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/profile_edit_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/recipe_details_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/register_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/splash_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/tabs_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/translation/app_localizations.dart';

//void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static void setLocale(BuildContext context, Locale locale) {
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale _locale;

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.white, statusBarBrightness: Brightness.light));
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      color: Colors.white,
      title: 'FoodRecipes',
      debugShowCheckedModeBanner: false,
      supportedLocales: [
        Locale('en', 'US'),
        Locale('zh', 'CN'),
      ],
      locale: _locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        for (var locale in supportedLocales) {
          if (locale.languageCode == deviceLocale.languageCode &&
              locale.countryCode == deviceLocale.countryCode) {
            return deviceLocale;
          }
        }
        return supportedLocales.first;
      },
      theme: ThemeData(
        primarySwatch: FsColor.primaryrecipe,
        accentColor: Colors.lightGreen,
        canvasColor: Colors.white,
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().primaryTextTheme.copyWith(
              bodyText1: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              bodyText2: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              subtitle2: TextStyle(
                color: Colors.black45,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              headline6: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              headline4: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
              subtitle1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
        ),
      ),
      // home: CategoriesScreen(),
      initialRoute: '/',
      // default is '/'
      routes: {
        '/': (ctx) => SplashScreen1(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
        RegisterScreen.routeName: (ctx) => RegisterScreen(),
        EditProfileScreen.routeName: (ctx) => EditProfileScreen(),
        TabsScreen.routeName: (ctx) => TabsScreen(),
        CategoryRecipesScreen.routeName: (ctx) => CategoryRecipesScreen(),
        RecipeDetailsScreen.routeName: (ctx) => RecipeDetailsScreen(),
      },
      onGenerateRoute: (settings) {
        print(settings.arguments);
        return MaterialPageRoute(
          builder: (ctx) => HomeScreen(),
        );
      },
    );
  }
}
