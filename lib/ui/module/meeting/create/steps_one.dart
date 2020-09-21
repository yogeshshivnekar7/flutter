import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';

class StepsOne extends StatefulWidget {

  StepsOne({Key key}) : super(key: key);

  @override
  StepsOneState createState() => new StepsOneState();
}

class StepsOneState extends State<StepsOne> {
String selectedType = "Meeting";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [

          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
            child: Text('What would you like to create?', textAlign: TextAlign.center,
              style: TextStyle(fontSize: FSTextStyle.h5size, color: FsColor.secondarymeeting, fontFamily: 'Gilroy-SemiBold'),
            ),
          ),


          Column(
            children: <Widget>[
              _typeSelector(context: context, meetvotetype: "Meeting"),
              SizedBox(height: 15.0),
              _typeSelector(context: context,meetvotetype: "Voting"),
            ],
          ),
      
        ],
      ),
    );
  }

  Widget _typeSelector({BuildContext context, String meetvotetype,}){
    bool isActive = meetvotetype == selectedType;
    return
      AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? FsColor.primarymeeting : null,
          border: Border.all(width:1,
            color: isActive ? FsColor.primarymeeting : FsColor.darkgrey,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: 
        RadioListTile(
          dense: true,
          value: meetvotetype,
          activeColor: FsColor.white,
          groupValue: selectedType,
          onChanged: (String v) {
            setState(() {
              selectedType = v;
            });
          },
          title: Text(meetvotetype.toUpperCase(),
            style: TextStyle(fontSize: FSTextStyle.h6size, letterSpacing: 1, color: isActive ? FsColor.white : null, fontFamily: 'Gilroy-SemiBold'),
          ),
        ),
    );
  }

}
