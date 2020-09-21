import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';

class VotingList extends StatefulWidget {
  @override
  _VotingListState createState() => new _VotingListState();
}

class _VotingListState extends State<VotingList> {

  List _votingList;
  bool _enableVoting = false;

@override
  Widget build(BuildContext context) {
    return _enableVoting ? ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: ListView.builder(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _votingList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    Map voting = _votingList[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5.0),
                      child: Card(
                        elevation: 1.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0),),
                          // side: BorderSide(color: 
                          //   voting['status']=='ongoing'?
                          //   FsColor.green.withOpacity(0.5)
                          //   :
                          //   voting['status']=='upcoming'?
                          //   FsColor.orange.withOpacity(0.5)
                          //   :
                          //   FsColor.red.withOpacity(0.5),
                          // ),
                        ),
                        child: InkWell(
                          child: Container(
                            

                            child: Column(
                              children: <Widget>[

                                Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.fromLTRB(0.0, 5.0, 0, 5.0),
                                  decoration: BoxDecoration(
                                    color: 
                                    voting['status']=='ongoing'?
                                    FsColor.green.withOpacity(0.1)
                                    :
                                    voting['status']=='upcoming'?
                                    FsColor.orange.withOpacity(0.1)
                                    :
                                    FsColor.red.withOpacity(0.1),
                                  ),
                                  child: Text('${voting["status"]}'.toUpperCase(), textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: FSTextStyle.h7size, letterSpacing: 3, fontFamily: 'Gilroy-SemiBold', 
                                    color: 
                                    voting['status']=='ongoing'?
                                    FsColor.green
                                    :
                                    voting['status']=='upcoming'?
                                    FsColor.orange
                                    :
                                    FsColor.red
                                  ),
                                  ),
                                ),

                                // Container(
                                //   width: double.infinity,
                                //   padding: EdgeInsets.fromLTRB(0.0, 5.0, 0, 5.0),
                                //   decoration: BoxDecoration(
                                //     color: 
                                //     voting['status']=='ongoing'?
                                //     FsColor.green.withOpacity(0.1)
                                //     :
                                //     voting['status']=='upcoming'?
                                //     FsColor.orange.withOpacity(0.1)
                                //     :
                                //     FsColor.red.withOpacity(0.1),
                                //   ),
                                //   child: Stack(
                                //     alignment: Alignment.center,
                                //     children: [
                                //       Text('${voting["status"]}'.toUpperCase(), textAlign: TextAlign.center,
                                //   style: TextStyle(fontSize: FSTextStyle.h7size, letterSpacing: 3, fontFamily: 'Gilroy-SemiBold', 
                                //     color: 
                                //     voting['status']=='ongoing'?
                                //     FsColor.green
                                //     :
                                //     voting['status']=='upcoming'?
                                //     FsColor.orange
                                //     :
                                //     FsColor.red
                                //   ),
                                //   ),

                                //   Positioned(
                                //     right: 5, top: 0, bottom: 0,
                                //     child: Container(
                                //       padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                //       // decoration: BoxDecoration(
                                //       //   color: FsColor.darkgrey,
                                //       //   borderRadius: BorderRadius.circular(10),
                                //       // ),
                                //       child: Row(
                                //         crossAxisAlignment: CrossAxisAlignment.center,
                                //         children: [
                                //           Text('${voting["votingstatus"]}'.toLowerCase(),
                                //             style: TextStyle(fontSize: FSTextStyle.h7size, fontFamily: 'Gilroy-SemiBold', letterSpacing: 0.5, color: FsColor.basicprimary),
                                //           ),
                                //         ],
                                //       )
                                //     ),
                                //   )

                                //     ],
                                //   )
                                  
                                // ),
                                
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  child: Column(
                                    children: [
                                      
                                      
                                      
                                      

                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text('${voting["votingtitle"]}'.toLowerCase(),
                                              style: TextStyle(fontSize: FSTextStyle.h5size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),

                                      Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                child: Text(
                                                  "Date : ".toLowerCase(),
                                                  style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.lightgrey),
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "${voting["startdate"]}".toLowerCase(),
                                                      style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                      child: Text(
                                                      "to".toLowerCase(),
                                                        style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${voting["enddate"]}".toLowerCase(),
                                                      style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      SizedBox(height: 5),

                                      Container(
                                          child: Row(
                                            children: [
                                              Container(
                                                child: Text(
                                                  "Time : ".toLowerCase(),
                                                  style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.lightgrey),
                                                ),
                                              ),
                                              Container(
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "${voting["starttime"]}".toLowerCase(),
                                                      style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey),
                                                    ),
                                                    Container(
                                                      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                                      child: Text(
                                                      "to".toLowerCase(),
                                                        style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                                                      ),
                                                    ),
                                                    Text(
                                                      "${voting["endtime"]}".toLowerCase(),
                                                      style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        
                                    ],
                                  ),
                                ),

                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                  Container(
                                  padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                                  margin: EdgeInsets.only(bottom: 5, right: 5),
                                  decoration: BoxDecoration(
                                    // color: FsColor.darkgrey.withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(width: 1.0, color: FsColor.basicprimary.withOpacity(0.2)),
                                    // border: Border(
                                    //   top: BorderSide(width: 1.0, color: FsColor.basicprimary.withOpacity(0.2)),
                                    //   left: BorderSide(width: 1.0, color: FsColor.basicprimary.withOpacity(0.2)),
                                    // )
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('${voting["votingstatus"]}'.toLowerCase(),
                                        style: TextStyle(fontSize: FSTextStyle.h7size, fontFamily: 'Gilroy-SemiBold', letterSpacing: 0.5, color: FsColor.darkgrey),
                                      ),
                                      SizedBox(width: 2),
                                      voting['votingstatus']=='voted'?
                                      Icon(Icons.check_circle_outline, size: 20, color: FsColor.green)
                                      :
                                      voting['votingstatus']=='not voted'?
                                      Icon(Icons.cancel, size: 20, color: FsColor.red)
                                      :
                                      Icon(Icons.access_time, size: 20, color: FsColor.orange)
                                    ],
                                  )
                                ),
                                  ],
                                ),
                                


                                Container(
                                  decoration: BoxDecoration(
                                  border: Border(
                                    top: BorderSide(width: 1.0, color: FsColor.basicprimary.withOpacity(0.2)),
                                  )
                                  ),
                                  padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
                                  child: Column(
                                  children: [

                                  voting['status']=='ongoing'?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FlatButton(
                                        onPressed: (){},
                                        //height: 32, minWidth: 80,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          side: BorderSide(color: FsColor.primarymeeting),
                                        ),
                                        child: Text('View Result',
                                          style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.primarymeeting),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      FlatButton(
                                        onPressed: (){},
                                        //height: 32, minWidth: 80,
                                        color: FsColor.primarymeeting,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text('Join Voting',
                                          style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.white),
                                        ),
                                      ),
                                    ],
                                  )
                                  :
                                  voting['status']=='upcoming'?
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FlatButton(
                                        onPressed: (){},
                                        //height: 32, minWidth: 64,
                                        child: Text('Edit',
                                          style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.primarymeeting),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      FlatButton(
                                        onPressed: (){},
                                        //height: 32, minWidth: 64,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          side: BorderSide(color: FsColor.red)
                                        ),
                                        splashColor: FsColor.red.withOpacity(0.2),
                                        child: Text('Cancel',
                                          style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.red),
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      FlatButton(
                                        onPressed: (){},
                                        //height: 32, minWidth: 80,
                                        color: FsColor.primarymeeting,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text('Send',
                                          style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.white),
                                        ),
                                      ),

                                    ],
                                  )
                                  :
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      FlatButton(
                                        onPressed: (){},
                                        //height: 32, minWidth: 80,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(4),
                                          side: BorderSide(color: FsColor.primarymeeting),
                                        ),
                                        child: Text('View Result',
                                          style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.primarymeeting),
                                        ),
                                      ),
                                    ],
                                  ),

                                  ],
                                ),
                                ),
                              

                              ],
                            ),
                          ),
                          onTap: null,
                          
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          )
        ],
      ) : getComingSoonWidget();

  }

  Widget getComingSoonWidget() {
  return Center(
    child: Text(FsString.MSG_FEATURE_COMING_SOON,
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Gilroy-Regular',
          letterSpacing: 1.0,
          height: 1.5,
          fontSize: FSTextStyle.h4size,
          color: FsColor.darkgrey),
    ),
  );
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
