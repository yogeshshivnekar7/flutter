import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class CovidNgo extends StatefulWidget {
  @override
  _CovidNgoState createState() => new _CovidNgoState();
}

class _CovidNgoState extends State<CovidNgo> {
  
void popupMenuSelected(String valueSelected){}


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.white,
        title: new Text(
          'NGO '.toLowerCase(),
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
                  Container(
                    child: Text(
                      "NGO & Other Organizations",
                      style: TextStyle(
                        color: FsColor.darkgrey, fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold',
                      ),
                    ),
                  ),
                ],
              ),
            ), 

            SizedBox(height: 5),

            Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: FsColor.lightgrey),
              )
              
             ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

             Text('MCKS Food for the Hungry Foundation',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('Please contact invest India to get in touch with NGO',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              ],
            ),
            ),

            Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: FsColor.lightgrey),
              )
              
             ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

             Text('Youth Feed India Program under SAFA Organization',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('Please contact invest India to get in touch with NGO',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              ],
            ),
            ),


            Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 15),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: FsColor.lightgrey),
              )
              
             ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

             Text('Zomato Feeding India',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('9871178810',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              ],
            ),
            ),

            Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: FsColor.lightgrey),
              )
              
             ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

             Text('Give India',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              FlatButton(
                onPressed: _launchGiveIndia, 
                padding: EdgeInsets.all(0),
                child: Text('https://indiafightscorona.giveindia.org/?utm_source=subs_homepage_desktop',
                style: TextStyle(
                  color: FsColor.primary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
                ),
              )
              

              ],
            ),
            ),


            Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: FsColor.lightgrey),
              )
              
             ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

             Text('Khusiyaan Foundation',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('9769181218',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              FlatButton(
                onPressed: _launchKhusiyaanFoundation, 
                padding: EdgeInsets.all(0),
                child: Text('http://www.khushiyaanfoundation.org/',
                style: TextStyle(
                  color: FsColor.primary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
                ),
              ),              

              ],
            ),
            ),


            Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: FsColor.lightgrey),
              )
              
             ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

             Text('K&G IRS Covid Relief Initiative',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              FlatButton(
                onPressed: _launchKgIrsRelief, 
                padding: EdgeInsets.all(0),
                child: Text('https://samarpann.org.in/%20donation/',
                style: TextStyle(
                  color: FsColor.primary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
                ),
              ),
              

              ],
            ),
            ),


            // Container(
            // width: double.infinity,
            // margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            // padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            // decoration: BoxDecoration(
            //   border: Border(
            //     bottom: BorderSide(width: 1, color: FsColor.lightgrey),
            //   )
              
            //  ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[

            //  Text('The Swades Foundation',
            //       style: TextStyle(
            //         color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
            //       ),
            //     ),
            //   SizedBox(height: 5),

            //   Text('+91 8208275516',
            //     style: TextStyle(
            //       color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
            //     ),
            //   ),

            //   FlatButton(
            //     onPressed: _launchSwadesFoundation, 
            //     padding: EdgeInsets.all(0),
            //     child: Text('https://www.investindia.gov.in/bip/resources/www.swadesfoundation.org',
            //     style: TextStyle(
            //       color: FsColor.primary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
            //     ),
            //     ),
            //   ),              

            //   ],
            // ),
            // ),


            // Container(
            // width: double.infinity,
            // margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            // padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
            // decoration: BoxDecoration(
            //   border: Border(
            //     bottom: BorderSide(width: 1, color: FsColor.lightgrey),
            //   )
              
            //  ),
            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: <Widget>[

            //  Text('SEEDS',
            //       style: TextStyle(
            //         color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
            //       ),
            //     ),
            //   SizedBox(height: 5),

            //   Text('+91 9267943261',
            //     style: TextStyle(
            //       color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
            //     ),
            //   ),

            //   FlatButton(
            //     onPressed: _launchSwadesFoundation, 
            //     padding: EdgeInsets.all(0),
            //     child: Text('http://www.seedsindia.org/covid19/',
            //     style: TextStyle(
            //       color: FsColor.primary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
            //     ),
            //     ),
            //   ),              

            //   ],
            // ),
            // ),

            
        
          ],
        ),
      ),
    );
  }
  _launchSeeds() async {
    const url = 'http://www.seedsindia.org/covid19/';
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }

  _launchSwadesFoundation() async {
    const url = 'https://www.investindia.gov.in/bip/resources/www.swadesfoundation.org';
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }

  _launchKhusiyaanFoundation() async {
    const url = 'http://www.khushiyaanfoundation.org/';
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }


  _launchKgIrsRelief() async {
    const url = 'https://samarpann.org.in/%20donation/';
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }

  _launchGiveIndia() async {
    const url = 'https://indiafightscorona.giveindia.org/?utm_source=subs_homepage_desktop';
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }
}





