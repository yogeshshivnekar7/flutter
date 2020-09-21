import 'package:flutter/material.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  @override
  _PrivacyPolicyScreenState createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  String privacyPolicy;

  @override
  void initState() {
    super.initState();
    _getPrivacyPolicy();
  }

  Future _getPrivacyPolicy() async {
    await HttpService.getPrivacyPolicy().then((value) {
      setState(() {
        privacyPolicy = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          'Privacy Policy'.toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: privacyPolicy != null
            ? Container(
                child: Text(
                '$privacyPolicy',
                style: TextStyle(
                    height: 1.5,
                    fontFamily: 'Raleay',
                    fontWeight: FontWeight.w400,
                    fontSize: 16),
              ))
            : Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
      )),
    );
  }
}
