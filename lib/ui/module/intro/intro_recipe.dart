import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class IntroRecipe extends StatefulWidget {
  @override
  _IntroRecipeState createState() => new _IntroRecipeState();
}

class _IntroRecipeState extends State<IntroRecipe> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
            child: RaisedButton(
              color: FsColor.basicprimary,
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Got it",
                  style: TextStyle(
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.white,
                      fontFamily: 'Gilroy-Bold')),
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
                child: Image.asset(
                  "images/intro_recipe.png",
                  height: 250.0,
                ),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Find & Share Amazing Recipe's".toLowerCase(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontFamily: 'Gilroy-Bold',
                          fontSize: FSTextStyle.h3size,
                          height: 1,
                          letterSpacing: 1.0,
                          color: FsColor.basicprimary),
                    ),
                    SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.chevron_right,
                            size: FSTextStyle.h6size,
                            color: FsColor.basicprimary,
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            'provides user flexibility to search, share & save recipes for people who love to cook and try out new recipes'
                                .toLowerCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                fontSize: FSTextStyle.h4size,
                                height: 1,
                                letterSpacing: 1.0,
                                color: FsColor.basicprimary),
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
                          child: Icon(
                            Icons.chevron_right,
                            size: FSTextStyle.h6size,
                            color: FsColor.basicprimary,
                          ),
                        ),
                        SizedBox(width: 5),
                        Flexible(
                          child: Text(
                            'Recipe Book will turn your phone into a pocket sous chef'
                                .toLowerCase(),
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                fontSize: FSTextStyle.h4size,
                                height: 1,
                                letterSpacing: 1.0,
                                color: FsColor.basicprimary),
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
