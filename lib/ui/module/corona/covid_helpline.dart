import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class CovidHelpline extends StatefulWidget {
  @override
  _CovidHelplineState createState() => new _CovidHelplineState();
}

class _CovidHelplineState extends State<CovidHelpline> {
  
void popupMenuSelected(String valueSelected){}


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.white,
        title: new Text(
          'Helpline Numbers'.toLowerCase(),
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            Container(
              margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Row(
                children: <Widget>[
                  Icon(FlutterIcon.minus, color: FsColor.primary, size: FSTextStyle.h6size,),
                  SizedBox(width: 10,),
                  Expanded(
                    child: Text(
                      "Emergency Helpline numbers to deal with pandemic",
                      style: TextStyle(
                        color: FsColor.darkgrey, fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold',
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
              child: Text(
                "Here are the Emergency helpline numbers are given by the government to fight Covid 19:".toLowerCase(),
                style: TextStyle(
                  color: FsColor.darkgrey.withOpacity(0.8), fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),
            ),    

            SizedBox(height: 20),

            Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

              Expanded(
                child: Text('National Helpline',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              ),
              SizedBox(width: 10),

              Text('+91-11-23978046',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                ),
              ),

              ],
            ),
            ),

            Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

              Expanded(
                child: Text('Maharashtra Helpline',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              ),
              SizedBox(width: 10),

              Text('020-26127394',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                ),
              ),

              ],
            ),
            ),

            Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

              Expanded(
                child: Text('For LiveHelpdesk Whatsapp on',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              ),
              SizedBox(width: 10),

              Text('+91-9013151515',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                ),
              ),

              ],
            ),
            ),
           
        
          ],
        ),
      ),
    );
  }
}
