import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class IntroShopping extends StatefulWidget { 
  @override
  _IntroShoppingState createState() => new _IntroShoppingState();
}

class _IntroShoppingState extends State<IntroShopping> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: RaisedButton(
                color: FsColor.basicprimary,  
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Got it", 
                style: TextStyle(fontSize: FSTextStyle.h5size, color: FsColor.white, fontFamily: 'Gilroy-Bold')
                ),
            ),
          ),
        ],
      ),
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Image.asset("images/intro_shopping.png", height: 250.0,),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Find places in your neighbourhood'.toLowerCase(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                        fontFamily: 'Gilroy-Bold', fontSize: FSTextStyle.h3size, height: 1, letterSpacing: 1.0, color: FsColor.basicprimary),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          alignment: Alignment.center,
                          child: Icon(Icons.chevron_right, size: FSTextStyle.h6size, color: FsColor.basicprimary,),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text('Easily find groceries, fruits & vegetables shops in your neighbourhood'.toLowerCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                            fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h4size, height: 1, letterSpacing: 1.0, color: FsColor.basicprimary),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          alignment: Alignment.center,
                          child: Icon(Icons.chevron_right, size: FSTextStyle.h6size, color: FsColor.basicprimary,),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text('Engage, contact, connect with local shops nearby'.toLowerCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                            fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h4size, height: 1, letterSpacing: 1.0, color: FsColor.basicprimary),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
