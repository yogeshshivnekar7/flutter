import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/scroll_widget.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

/*void main() => runApp(MyApp());*/

class DeepLinkWebView extends StatefulWidget {
  String url;

  @override
  State<StatefulWidget> createState() {
    return DeepLinkWebViewState(this.url);
  }

  DeepLinkWebView(
    this.url,
  );
}

class DeepLinkWebViewState extends State<DeepLinkWebView> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  String url;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<String> _onUrlChanged;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([]);
    flutterWebviewPlugin.onUrlChanged.listen((String url) {
      print("url");
      print(url);
    });
    flutterWebviewPlugin.onBack.listen((data){
      print("data");
      print(url);
    });

  }

  @override
  void dispose() {
    try {
      _onUrlChanged.cancel();
      flutterWebviewPlugin.dispose();
    } catch (e) {
      print(e);
    }
    super.dispose();
  }

  static Color backgroundColor() {
    return FsColor.white;
  }

  @override
  Widget build(BuildContext context) {
    print("sssssssss");
    print(url);
    return
      WillPopScope(
      // ignore: missing_return
      onWillPop: () {
        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      },
      child:
          new FsScrollWidget(
              childWidget()
          ),
//      Scaffold(
//        body: ConstrainedBox(
//          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
//          child: Container(
//            child:,
//          ),
//        ),
//      ),


    );
  }
  Widget childWidget() {
   return WebviewScaffold(
      url: url,
      clearCache: false,
      clearCookies: false,
      withJavascript: true,
      geolocationEnabled: true,

      // run javascript
      withZoom: false,
      // if you want the user zoom-in and zoom-out
      hidden: false,
      // put it true if you want to show CircularProgressIndicator while waiting for the page to load
      appCacheEnabled: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, size: 18.0),
          color: FsColor.black,
          onPressed: () {
            SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          },
        ),
        backgroundColor: backgroundColor(),
        title: Text(
          AppUtils.capitalize("Survey"),
          style: FSTextStyle.appbartext,
        ),
        centerTitle: false,
        elevation: 1,
        // give the appbar shadows
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }

  DeepLinkWebViewState(
    this.url,
  );
}
