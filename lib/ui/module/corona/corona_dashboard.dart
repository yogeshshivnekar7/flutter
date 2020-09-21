import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/corona/covid_donate.dart';
import 'package:sso_futurescape/ui/module/corona/covid_helpline.dart';
import 'package:sso_futurescape/ui/module/corona/covid_ngo.dart';
import 'package:sso_futurescape/ui/module/corona/covid_quarantine.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:carousel_slider/carousel_options.dart';

class CoronaDashboard extends StatefulWidget {
  CoronaDashboard();
  @override
  _CoronaDashboardState createState() =>
      new _CoronaDashboardState();
}

class _CoronaDashboardState extends State<CoronaDashboard>{
    // CoronaPresenter presenter;
    var coronaData;
    
    String mahaActive='No Data';
    String mahaConfirmed='No Data';
    String mahaConfirmedToday='No Data';
    String mahaRecovered='No Data';
    String mahaRecoveredToday='No Data';

    String indiaActive='No Data';
    String indiaConfirmed='No Data';
    String indiaConfirmedToday='No Data';
    String indiaRecovered='No Data';
    String indiaRecoveredToday='No Data';

    var lastupdatedtime='';
    bool isLoading = true;
    @override
    Widget build(BuildContext context) {
       return new Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: FsColor.white,
        title: new Text(
          'Corona information with cubeoneapp'.toLowerCase(),
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(),
      ),
      
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            // Container(
            //   margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
            //   child: Text(
            //     'Last updated on '+lastupdatedtime+' IST',
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //             color: FsColor.lightgrey, fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-Regular',
            //     ),
            //   ),
            // ),


            // Container(
            //   margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
            //   child: Row(
            //     children: <Widget>[
            //       Icon(FlutterIcon.minus, color: FsColor.primary, size: FSTextStyle.h6size,),
            //       SizedBox(width: 10,),
            //       Container(
            //         child: Text(
            //           "Maharashtra",
            //           style: TextStyle(
            //             color: FsColor.darkgrey, fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold',
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[

            //     Expanded(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
                   
            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //           child: Text(
            //             "Confirmed".toLowerCase(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey, fontFamily: 'Gilroy-SemiBold'),
            //           ),
            //         ),

            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            //           child: Text(
            //             mahaConfirmed.toLowerCase(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: FSTextStyle.h4size, color: FsColor.red, fontFamily: 'Gilroy-SemiBold'),
            //           ),
            //         ),

            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: <Widget>[
            //               Icon(FlutterIcon.up, color: FsColor.red, size: FSTextStyle.h7size,),
            //               Text(
            //                 mahaConfirmedToday.toLowerCase(),
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.red, fontFamily: 'Gilroy-SemiBold'),
            //               )
            //             ],
            //           ),
                     
            //         ),


            //       ],
            //       ),
            //     ),


            //      Expanded(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
                   
            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //           child: Text(
            //             "Recovered".toLowerCase(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey, fontFamily: 'Gilroy-SemiBold'),
            //           ),
            //         ),

            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
            //           child: Text(
            //             mahaRecovered.toLowerCase(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: FSTextStyle.h4size, color: FsColor.green, fontFamily: 'Gilroy-SemiBold'),
            //           ),
            //         ),

            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: <Widget>[
            //               Icon(FlutterIcon.up, color: FsColor.green, size: FSTextStyle.h7size,),
            //               Text(
            //                 mahaRecoveredToday.toLowerCase(),
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.green, fontFamily: 'Gilroy-SemiBold'),
            //               )
            //             ],
            //           ),
                     
            //         ),

            //       ],
            //       ),
            //     ),

            //   ],
            // ),

            // SizedBox(height: 15),


            // Container(
            //   margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
            //   child: Row(
            //     children: <Widget>[
            //       Icon(FlutterIcon.minus, color: FsColor.primary, size: FSTextStyle.h6size,),
            //       SizedBox(width: 10,),
            //       Container(
            //         child: Text(
            //           "Across India",
            //           style: TextStyle(
            //             color: FsColor.darkgrey, fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold',
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),


            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: <Widget>[

            //     Expanded(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
                   
            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //           child: Text(
            //             "Confirmed".toLowerCase(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey, fontFamily: 'Gilroy-SemiBold'),
            //           ),
            //         ),

            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            //           child: Text(
            //             indiaConfirmed.toLowerCase(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: FSTextStyle.h4size, color: FsColor.red, fontFamily: 'Gilroy-SemiBold'),
            //           ),
            //         ),

            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: <Widget>[
            //               Icon(FlutterIcon.up, color: FsColor.red, size: FSTextStyle.h7size,),
            //               Text(
            //                 indiaConfirmedToday.toLowerCase(),
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.red, fontFamily: 'Gilroy-SemiBold'),
            //               )
            //             ],
            //           ),
                     
            //         ),


            //       ],
            //       ),
            //     ),


            //      Expanded(
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //       children: <Widget>[
                   
            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //           child: Text(
            //             "Recovered".toLowerCase(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.darkgrey, fontFamily: 'Gilroy-SemiBold'),
            //           ),
            //         ),

            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            //           child: Text(
            //             indiaRecovered.toLowerCase(),
            //             textAlign: TextAlign.center,
            //             style: TextStyle(fontSize: FSTextStyle.h4size, color: FsColor.green, fontFamily: 'Gilroy-SemiBold'),
            //           ),
            //         ),

            //         Container(
            //           margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            //           child: Row(
            //             mainAxisAlignment: MainAxisAlignment.center,
            //             crossAxisAlignment: CrossAxisAlignment.center,
            //             children: <Widget>[
            //               Icon(FlutterIcon.up, color: FsColor.green, size: FSTextStyle.h7size,),
            //               Text(
            //                 indiaRecoveredToday.toLowerCase(),
            //                 textAlign: TextAlign.center,
            //                 style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.green, fontFamily: 'Gilroy-SemiBold'),
            //               )
            //             ],
            //           ),
                     
            //         ),

            //       ],
            //       ),
            //     ),

            //   ],
            // ),

            SizedBox(height: 15),

            Container(
              margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Row(
                children: <Widget>[
                  Icon(FlutterIcon.minus, color: FsColor.primary, size: FSTextStyle.h6size,),
                  SizedBox(width: 10,),
                  Container(
                    child: Text(
                      "Important Safety Measures",
                      style: TextStyle(
                        color: FsColor.darkgrey, fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold',
                      ),
                    ),
                  )
                ],
              ),
            ),
            
            Container(
              
              decoration: BoxDecoration(
                color: FsColor.white,
                borderRadius: BorderRadius.circular(4.0),      
              ),
                child: CarouselSlider(
                  options: CarouselOptions(height: 200),
                  items: ['images/slider1.jpeg', 'images/slider2.jpg', 'images/slider3.jpg', 'images/slider4.jpg'].map((i) {
                    return Builder(
                      builder: (BuildContext context) {

                        
                      return Container(
                        height: 200,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: Card(
                          child: Image.asset(
                            i,
                            fit: BoxFit.fitWidth,
                            ),
                        ),
                      );
                            
                      },
                    );
                  }).toList(),
                ),
            ),

            SizedBox(height: 20,),

            Container(
              margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Row(
                children: <Widget>[
                  Icon(FlutterIcon.minus, color: FsColor.primary, size: FSTextStyle.h6size,),
                  SizedBox(width: 10,),
                  Container(
                    child: Text(
                      "Helpful Services",
                      style: TextStyle(
                        color: FsColor.darkgrey, fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold',
                      ),
                    ),
                  )
                ],
              ),
            ),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[

                Expanded(
                  child:  GestureDetector(
                    onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => CovidHelpline(),
                        ),
                      );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                     'images/icon-helpline.png',
                        fit: BoxFit.contain,
                        width: 30.0,
                        height: 30.0,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "Helpline Numbers".toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.darkgrey, fontFamily: 'Gilroy-SemiBold'),
                      ),
                    )
                  ],
                ),
                ),
                ),

                 Expanded(
                  child: GestureDetector(
                    onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => CovidNgo(),
                        ),
                      );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                     'images/icon-ngo.png',
                        fit: BoxFit.contain,
                        width: 30.0,
                        height: 30.0,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "NGOs & Other Official".toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.darkgrey, fontFamily: 'Gilroy-SemiBold'),
                      ),
                    )
                  ],
                ),
                ),               ),


                 Expanded(                  
                  child: GestureDetector(
                    onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => CovidDonate(),
                        ),
                      );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                     'images/icon-donate.png',
                        fit: BoxFit.contain,
                        width: 30.0,
                        height: 30.0,
                    ),
                    
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "Donate \n & Help".toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.darkgrey, fontFamily: 'Gilroy-SemiBold'),
                      ),
                    )
                  ],
                ),
                ),
                ),

                 Expanded(
                  

                  child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => CovidQuarantine(),
                        ),
                      );
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                     'images/icon-hospital.png',
                        fit: BoxFit.contain,
                        width: 30.0,
                        height: 30.0,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        "Quarantine Places".toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.darkgrey, fontFamily: 'Gilroy-SemiBold'),
                      ),
                    )
                  ],
                ),
                ),
                ),

                
                
              ],
            ),
            
            
            SizedBox(height: 20, ),

            Container(
              margin: EdgeInsets.fromLTRB(20, 15, 20, 15),
              child: Row(
                children: <Widget>[
                  Icon(FlutterIcon.minus, color: FsColor.primary, size: FSTextStyle.h6size,),
                  SizedBox(width: 10,),
                  Container(
                    child: Text(
                      "Government Mandates",
                      style: TextStyle(
                        color: FsColor.darkgrey, fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold',
                      ),
                    ),
                  )
                ],
              ),
            ),

            Container(
              height: 200,
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Card(
                child: Image.asset(
                  "images/covid-awareness.jpg",
                  fit: BoxFit.fitWidth,
                  ),
              ),
            ),

            SizedBox(height: 15),
        


        

          ],
        ),
      ),
    );

    }
    @override
    void initState() {
        // presenter = new CoronaPresenter(this);
        // getCoronaDetailsDetails();
      super.initState();
    }
    
    @override
    onError(context){}

    @override
    onFailure(failed) {
        // TODO: implement onFailure
        throw UnimplementedError();
      }
    
    @override
    onSuccess(result) {
    }
  }