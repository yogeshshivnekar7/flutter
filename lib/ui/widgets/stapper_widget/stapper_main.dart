import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/main.dart';
import 'package:sso_futurescape/ui/module/chsone/payment/allreadypaid/payalready_method.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/stapper_widget/stapper_body.dart';

// ignore: must_be_immutable
class StepperMainWidget extends StatefulWidget {
  String description;
  String title;
  List<StapperBody> pages;
  Function onPageChange;
  Function afterInit;
  var listener;
  bool enableStepClick = true;
  bool heading = true;

  /*var afterInit;*/

  StepperMainWidget(
      {String title,
      String description,
      List<StapperBody> pages,
      Function onPageChange,
      Function afterInit,
        bool enableStepClick,
      bool heading}) {
    this.title = title;
    this.description = description;
    this.pages = pages;
    this.heading = heading;
    this.onPageChange = onPageChange;
    this.listener = listener;
    this.afterInit = afterInit;
    this.enableStepClick = enableStepClick;
  }

  @override
  State<StatefulWidget> createState() {
    return StepperMainWidgetState(
        pages: pages,
        heading: heading,
        onPageChange: onPageChange,
        afterInit: afterInit,
        title: title,
        enableStepClick: enableStepClick);
  }
}

class StepperMainWidgetState extends State<StepperMainWidget>
    implements SFunction {
  String description; // = 'Payment'.toLowerCase();
  String title; //= 'Payment'.toLowerCase();
  int currentPage = 1;
  List<StapperBody> pages;
  Function onPageChange;

  bool enableStepClick = true;

  bool heading = true;

  /*Function afterInit;*/
  @override
  void demo(int current) {
    print("asdashdhjszd");
    currentPage = current;
  }

  /* var listner;*/

  StepperMainWidgetState(
      {String title,
      String description,
      List<StapperBody> pages,
      Function onPageChange,
      Function afterInit,
        bool enableStepClick,
      bool heading}) {
    this.title = title;
    this.description = description;
    this.pages = pages;
    this.heading = heading;
    this.onPageChange = onPageChange;
    this.enableStepClick = enableStepClick;
    afterInit(this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: FsColor.primaryflat,
        elevation: 0.0,
        title: new Text(
          title == null ? "" : title,
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child: Column(
            children: <Widget>[
              Container(
                child: getStaper(),
              ),
              heading
                  ? Container(
                      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                      alignment: Alignment.center,
                      child: getTitle(),
                    )
                  : Container(),
              getPage(context, currentPage)
            ],
          ),
        ),
      ),
    );
  }

  Container getPage(BuildContext context, currentPage) {
    var page = Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(
              top: 10.0,
              bottom: 10.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('total due amount : ',
                    style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.darkgrey,
                    )),
                Row(
                  children: <Widget>[
                    Icon(
                      FlutterIcon.rupee,
                      size: FSTextStyle.h2size,
                      color: FsColor.darkgrey,
                    ),
                    Text('2000',
                        style: TextStyle(
                          fontFamily: 'Gilroy-Bold',
                          fontSize: FSTextStyle.h1size,
                          color: FsColor.darkgrey,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('other due amount : ',
                    style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.darkgrey,
                    )),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Enter Amount",
                  labelStyle: TextStyle(
                      fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: FsColor.basicprimary))),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Paid by",
                  labelStyle: TextStyle(
                      fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: FsColor.basicprimary))),
            ),
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                  child: GestureDetector(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text('Next',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold')),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PayAlreadyMethodPage(),
                          ),
                        );
                      },
                      color: FsColor.primaryflat,
                      textColor: FsColor.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
    print(currentPage);
    return pages[currentPage - 1].child;
  }

  Column getTitle() {
    StapperBody currentMsg = pages[currentPage - 1];

    return Column(
      children: <Widget>[
        Text(
          currentMsg.title == null
              ? ""
              : currentMsg.title /*.title!=null?currentMsg.title:"s"*/,
          style: TextStyle(
            fontFamily: 'Gilroy-SemiBold',
            fontSize: FSTextStyle.h5size,
            color: FsColor.darkgrey,
          ),
        ),
        Text(
          currentMsg.description == null ? "" : currentMsg.description,
          style: TextStyle(
            fontFamily: 'Gilroy-Regular',
            fontSize: FSTextStyle.h5size,
            color: FsColor.darkgrey,
          ),
        )
      ],
    );
  }

  Row getStaper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: getStepHeading(),
    );
  }

  /*List msg = [
    {"title": "already paid"},
    {"title": "Payment Method"},
    {"title": "already paid"}
  ];*/

  List<Widget> getStepHeading() {
    List<Widget> widgets = [];
    for (var a = 0; a < pages.length; a++) {
      if (a == 0) {
        widgets.add(SizedBox(width: 5.0));
        widgets.add(headingStape(a + 1, pages[a]));
      } else if (a == pages.length - 1) {
        widgets.add(Expanded(
            child: Divider(
          color: FsColorStepper.inactive,
          height: 1,
        )));
        widgets.add(headingStape(a + 1, pages[a]));
        widgets.add(SizedBox(width: 5.0));
      } else {
        widgets.add(Expanded(
            child: Divider(
          color: FsColorStepper.inactive,
          height: 1,
        )));
        widgets.add(headingStape(a + 1, pages[a]));
      }
    }
    return widgets;
  }

  GestureDetector headingStape(int a, StapperBody msg) {
    return GestureDetector(
        onTap: () {
          if (enableStepClick) {
            print(a);
            setState(() {
              onPageChange(currentPage, a);
              currentPage = a;
            });
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: 30.0,
          height: 30.0,
          decoration: BoxDecoration(
            color: currentPage == a
                ? FsColorStepper.active
                : FsColorStepper.inactive,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Text(
            "$a",
            style: TextStyle(
              fontFamily: 'Gilroy-Bold',
              fontSize: FSTextStyle.h6size,
              color: FsColor.white,
            ),
          ),
        ));
  }

  @override
  void next() {
    setState(() {
      currentPage = currentPage + 1;
    });
  }
}
