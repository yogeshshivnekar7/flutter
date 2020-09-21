import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

/*class ResponsiveWidget extends StatefulWidget {
  Widget body;
  Widget appBar;
  Widget floatingActionButton;

  Color primaryColor = Colors.black;

  ResponsiveWidget(
      {this.body, this.appBar, this.floatingActionButton, this.primaryColor});

  @override
  State<StatefulWidget> createState() {
    return ResponsiveWidgetState(
        body, appBar, floatingActionButton, primaryColor);
  }
}*/

class ResponsiveWidget extends StatelessWidget {
  Widget body;
  Widget appBar;
  Widget floatingActionButton;
  Color primaryColor;

  ResponsiveWidget(
      {this.body, this.appBar, this.floatingActionButton, this.primaryColor});

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final bool useMobileLayout = shortestSide < 768.0;
    return useMobileLayout
        ? Scaffold(
      resizeToAvoidBottomPadding: true,
            appBar: appBar,
            // body: SingleChildScrollView(
            //   child: body,
            // ),
            body: body,
          )
        : Scaffold(
            appBar: appBar,
            floatingActionButton: floatingActionButton,
            body: Container(
                child: Stack(
              children: <Widget>[
                Container(
                  color: primaryColor,
                  height: 200,
                  width: double.infinity,
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                    //transform: Matrix4.translationValues(0.0, -150.0, 0.0),
                    decoration: BoxDecoration(
                        color: FsColor.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4.0),
                          topRight: Radius.circular(4.0),
                        ),
                        border: Border.all(
                            width: 1,
                            color: FsColor.lightgrey.withOpacity(0.5))),
                    alignment: Alignment.center,
                    width: 768,
                    child: body,
                  ),
                ),
              ],
            )),
          );
  }
}
