import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class StepsFour extends StatefulWidget {

  StepsFour({Key key}) : super(key: key);

  @override
  StepsFourState createState() => new StepsFourState();
}

class StepsFourState extends State<StepsFour> {

List participanttext = [
  {
    "name": "Brendan Howells",
    "mobile": "9876543210",
    "email": "-"
  },
  {
    "name": "Diogo Hussain",
    "mobile": "9876543210",
    "email": "diogo@email.com"
  },
  {
    "name": "Halima Kearns",
    "mobile": "9876543210",
    "email": "halima@email.com"
  },
  {
    "name": "Nigel Melendez",
    "mobile": "9876543210",
    "email": "nigel_m@gmail.com"
  },
  {
    "name": "Dexter Walters",
    "mobile": "9876543210",
    "email": "dexter_wal@email.com"
  },
  {
    "name": "Halima Kearns",
    "mobile": "9876543210",
    "email": "halima@email.com"
  },
  {
    "name": "Nigel Melendez",
    "mobile": "9876543210",
    "email": "nigel_m@gmail.com"
  },
  {
    "name": "Dexter Walters",
    "mobile": "9876543210",
    "email": "dexter_wal@email.com"
  },
];

List<String> _participant = [
  'Shaun Allen',
  'Rhiann King',
  'Macaulay Mercer',
  'Maria Snyder',
  'Lukasz Evans',
  'Aiden Lugo',
  'Lee Bouvet',
  'Jez Prosser',
  'Alesha Moore',
  'Zi Zamora',
  'Caitlyn Pearce',
  'Daanyaal Bevan',
  'Lincoln Wilson',
  'Garry Case',
  'Ahsan Reid',
  'Tomas Haigh',
  'Kenan Kearney',
  'William Yates',
  'Santa Rosas',
  'Alexandre Connor',
  'Koa Kaiser',
  'Scarlett-Rose Keith',
  'Shakira Cartwright',
  'Aria Tyson',
  'Aaryan Ball',
]; 
  String _selectedParticipant;

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    return 
    SingleChildScrollView(
    child: Column(
        children: [

          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
            child: Text('some line add participant lorem', textAlign: TextAlign.center,
              style: TextStyle(fontSize: FSTextStyle.h5size, color: FsColor.secondarymeeting, fontFamily: 'Gilroy-SemiBold'),
            ),
          ),


          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(4.0),),
              border: Border.all(width: 1.0, color: FsColor.primarymeeting.withOpacity(0.2),),
            ),
            child: Column(
              children: [
          
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: FsColor.primarymeeting.withOpacity(0.2)),
                    ),
                    color: FsColor.primarymeeting.withOpacity(0.1),
                  ),
                  child: Column(
                    children: [
                    searchTextField = AutoCompleteTextField<String>(
                      key: key,
                      clearOnSubmit: false,
                      suggestions: _participant,
                      style: TextStyle(fontSize: FSTextStyle.h6size, color: FsColor.basicprimary, fontFamily: 'Gilroy-Regular'),
                      decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 5, right: 0,),
                      labelText: 'Add Participant'.toLowerCase(),
                      labelStyle: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey.withOpacity(0.75)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: FsColor.primarymeeting)),
                      suffix:  Container(
                        width: 40, height: 40,
                        alignment: Alignment.center,
                        child: RaisedButton(
                          padding: EdgeInsets.all(0),
                          color: FsColor.primarymeeting,
                          onPressed: (){},
                          child: Icon(Icons.add, color: FsColor.white, size: FSTextStyle.h4size,),
                        ),
                          ),
                      ),
                      itemFilter: (item, query) {
                        return item.toLowerCase().startsWith(query.toLowerCase());
                      },
                      itemSorter: (a, b) {
                        return a.compareTo(b);
                      },
                      itemSubmitted: (item) => setState(() {
                        _selectedParticipant = item;
                      }),
                      itemBuilder: (context, item) {
                        // ui for the autocomplete row
                        return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(                          
                              bottom: BorderSide(width: 1, color: FsColor.darkgrey.withOpacity(0.2)),
                            )
                          ),
                          child: Text(item,style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.basicprimary),),
                        );
                      },
                    ),
                    ],
                  ),
                ),




                ListView.builder(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: participanttext == null ? 0 : participanttext.length,
                  itemBuilder: (BuildContext context, int index) {
                    Map place = participanttext[index];
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: BoxDecoration(
                          // color: FsColor.red,
                          border: Border(                          
                            bottom: BorderSide(width: 1, color: FsColor.darkgrey.withOpacity(0.2)),
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${place["name"]}', textAlign: TextAlign.left,
                                  style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.primarymeeting),
                                ),
                                SizedBox(height: 3),
                                Text('${place["mobile"]}',textAlign: TextAlign.left,
                                  style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.lightgrey),
                                ),
                                SizedBox(height: 3),
                                Text('${place["email"]}',textAlign: TextAlign.left,
                                  style: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                                ),
                              ],
                            ),
                            Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              child: FlatButton(
                              padding: EdgeInsets.all(0),
                              onPressed: (){},
                              child: Icon(Icons.clear, color: FsColor.red, size: 22,)
                              ),
                            ),

                          ],
                        ),
                      );

                    // return AnimatedContainer(
                    //   duration: Duration(milliseconds: 200),
                    //   curve: Curves.easeInOut,
                    //   padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    //   decoration: BoxDecoration(
                    //     // color: FsColor.red,
                    //     border: Border(                          
                    //       bottom: BorderSide(width: 1, color: FsColor.darkgrey.withOpacity(0.2)),
                    //     )
                    //   ),
                    //   child: Container(
                    //     child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: [
                    //       Container(
                    //         child: Column(
                    //           children: [

                    //             Text('${place["name"]}',
                    //               style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.primarymeeting),
                    //             ),
                    //             SizedBox(height: 3),
                    //             Text('${place["mobile"]}',
                    //               style: TextStyle(fontFamily: 'Gilroy-SemiBold', fontSize: FSTextStyle.h6size, color: FsColor.lightgrey),
                    //             ),
                    //             SizedBox(height: 3),
                    //             Text('${place["email"]}',
                    //               style: TextStyle(fontFamily: 'Gilroy-Regular', fontSize: FSTextStyle.h6size, color: FsColor.darkgrey),
                    //             ),

                    //           ],
                    //         ),
                    //       ),
                    //       Container(
                    //         width: 32,
                    //         height: 32,
                    //         alignment: Alignment.center,
                    //         child: FlatButton(
                    //         padding: EdgeInsets.all(0),
                    //         onPressed: (){},
                    //         child: Icon(Icons.cancel_outlined, color: FsColor.red, size: 22,)
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    //   )
                    // ); 




                  },
                ),

                




              ],
            ),
          ),

          
        ],
      ),
    );
  }
}
