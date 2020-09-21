import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

class CovidQuarantine extends StatefulWidget {
  @override
  _CovidQuarantineState createState() => new _CovidQuarantineState();
}

class _CovidQuarantineState extends State<CovidQuarantine> {
  
void popupMenuSelected(String valueSelected){}


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.white,
        title: new Text(
          'Quarantine '.toLowerCase(),
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
                      "Quarantine Places & Hospital",
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

             Text('Kasturba Hospital for Infectious Diseases',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('Sane Guruji Marg, Arya Nagar, Chinchpokli, Mumbai, Maharashtra 400034 ',
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

             Text('National Institute of Virology',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('20-A, P B No 11, Dr Ambedkar Road, Pune, 411001 ',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              SizedBox(height: 5),

              Text('020 2612 7301',
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

             Text('Seth GS Medical College & KEM Hospital',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('Acharya Donde Marg, Parel, Mumbai 400 012. India. ',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              SizedBox(height: 5),

              Text('91-22-2410 7000',
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

             Text('Armed Forces Medical College',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('Pimpri chinchwad, Pune',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              SizedBox(height: 5),

              Text('+91 20 26330781',
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

             Text('BJ Medical College',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('B.J. Govt. Medical College and Sassoon General Hospitals & College of Nursing Jai Prakash Narayan Road, Near Pune Railway Station, Pune - 411001',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              SizedBox(height: 5),

              Text('+91 20 26128000',
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

             Text('Indira Gandhi Govt. Medical College',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('Mayo Hospital, Central Ave, Mominpura, Nagpur, Maharashtra 440018',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              SizedBox(height: 5),

              Text(' 0712 272 5423',
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

             Text('Grant Medical College & Sir JJ Hospital',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('J J Marg, Nagpada, Mumbai Central, Mumbai, Maharashtra 400008',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              SizedBox(height: 5),

              Text('022 2373 5555',
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

             Text('Govt. Medical College',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('Hanuman Nagar, Ajni Rd, Medical Chowk, Ajni, Nagpur, Maharashtra 440003',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              SizedBox(height: 5),

              Text('0712 274 3588',
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

             Text('Dr Vaishampayan Memorial Govt Medical College',
                  style: TextStyle(
                    color: FsColor.basicprimary, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold',
                  ),
                ),
              SizedBox(height: 5),

              Text('Court Road Opp. District Court Rang Bhavan Chowk, Sidheshwar Peth, Solapur, Maharashtra 413003',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
                ),
              ),

              SizedBox(height: 5),

              Text('0217 274 9401',
                style: TextStyle(
                  color: FsColor.darkgrey, fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular',
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
