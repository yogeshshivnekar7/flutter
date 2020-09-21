import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class CovidDonate extends StatefulWidget {
  @override
  _CovidDonateState createState() => new _CovidDonateState();
}

class _CovidDonateState extends State<CovidDonate> {
  
void popupMenuSelected(String valueSelected){}


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.white,
        title: new Text(
          'Donate '.toLowerCase(),
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Card(
              elevation: 0.5,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Container(
            width: double.infinity,
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            
              
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

              Text('Download AarogyaSetu App',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              
              SizedBox(width: 5),

              RaisedButton(
                color: FsColor.basicprimary,
                onPressed: _launchAarogyaSetu, 
                padding: EdgeInsets.all(0),
                child: Text('Click Here',
                style: TextStyle(
                  color: FsColor.white, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                ),
                ),
              ),

              

              ],
            ),
            ),
            ),


            Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
            padding: EdgeInsets.fromLTRB(10, 15, 10, 5),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: FsColor.lightgrey),
                top: BorderSide(width: 1, color: FsColor.lightgrey),
              )
              
             ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

             Text('For more government announcement and updates go to :',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              FlatButton(
                onPressed: _launchMyGov, 
                padding: EdgeInsets.all(0),
                child: Text('https://www.mygov.in/',
                style: TextStyle(
                  color: FsColor.primary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
                ),
              )
              

              ],
            ),
            ),





        
          ],
        ),
      ),
    );
  }
    _launchMyGov() async {
    const url = 'https://www.mygov.in/';
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }

  _launchAarogyaSetu() async {
    const url = 'https://play.google.com/store/apps/details?id=nic.goi.aarogyasetu';
    if (await AppUtils.canLaunchUrl(url)) {
      await AppUtils.launchUrl(url);
    } else {
      throw 'could not launch $url';
    }
  }
}



