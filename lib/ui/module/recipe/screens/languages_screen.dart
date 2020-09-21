import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sso_futurescape/ui/module/recipe/translation/app_localizations.dart';

import '../myapp.dart';

class LanguagesScreen extends StatefulWidget {
  @override
  _LanguagesScreenState createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends State<LanguagesScreen> {
  void _changeLanguage(String language) {
    Locale _temp;
    switch (language) {
      case 'en':
        _temp = Locale('en', 'US');
        _saveLanguage('en');
        break;
      case 'zh':
        _temp = Locale('zh', 'CN');
        _saveLanguage('zh');
        break;
      default:
        _temp = Locale('en', 'US');
    }

    MyApp.setLocale(context, _temp);
  }

  Future<void> _saveLanguage(String language) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('lang', language);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        title: Text(
          AppLocalizations.of(context).translate('languages'),
          style: TextStyle(color: Colors.black),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
            child: Text(
              AppLocalizations.of(context).translate('choose_Language'),
              style:
                  TextStyle(fontFamily: 'Raleway', fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      onTap: () => _changeLanguage('en'),
                      title: Text(
                        AppLocalizations.of(context).translate('english'),
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      leading: Image.asset(
                        'assets/images/flag_us.png',
                        width: 35,
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      onTap: () => _changeLanguage('zh'),
                      title: Text(
                        AppLocalizations.of(context).translate('chinese'),
                        style: TextStyle(
                            fontFamily: 'Raleway',
                            fontWeight: FontWeight.w500,
                            fontSize: 20),
                      ),
                      leading: Image.asset(
                        'assets/images/flag_ch.png',
                        width: 35,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
