import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

/*class MyPropertyPresenter {
  MyPropertyView myPropertyView;

  MyPropertyPresenter(this.myPropertyView);
}*/

class ParkingWidget extends StatelessWidget {
  var parkingDetail;

  ParkingWidget(this.parkingDetail);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: parkingDetail == null ? 0 : parkingDetail.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = parkingDetail[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: FsColor.darkgrey.withOpacity(0.2),
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  top: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: ListView(
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${place["parkingnumber"]}',
                                style: TextStyle(
                                    fontFamily: 'Gilroy-SemiBold',
                                    fontSize: FSTextStyle.h6size,
                                    color: FsColor.basicprimary),
                              ),
                            ),
                            SizedBox(height: 7),
                            Wrap(
                              children: <Widget>[
                                Text(
                                  'Status : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.lightgrey),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '${place["status"]}'.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class VehicleWidget extends StatelessWidget {
  var vehiclesDetail;

  VehicleWidget(this.vehiclesDetail);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: vehiclesDetail == null ? 0 : vehiclesDetail.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = vehiclesDetail[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: FsColor.darkgrey.withOpacity(0.2),
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  top: 10.0,
                ),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        color: Colors.tealAccent,
                        child: SizedBox(
                          width: 48,
                          height: 48,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: ListView(
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                '${place["vehiclenumber"]}',
                                style: TextStyle(
                                    fontFamily: 'Gilroy-SemiBold',
                                    fontSize: FSTextStyle.h6size,
                                    color: FsColor.basicprimary),
                              ),
                            ),
                            SizedBox(height: 7),
                            Wrap(
                              children: <Widget>[
                                Text(
                                  'Batch No. : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.lightgrey),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  '${place["batchnumber"]}'.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MemberWidget extends StatelessWidget {
  var memberDetails;
  var parentWidget;

  MemberWidget(this.memberDetails, this.parentWidget) {
    print(memberDetails);
    print(parentWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: (memberDetails.length == null) ? 0 : memberDetails.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = memberDetails[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 0.0),
            child: InkWell(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.0,
                      color: FsColor.darkgrey.withOpacity(0.2),
                    ),
                  ),
                ),
                padding: const EdgeInsets.only(
                  bottom: 10.0,
                  top: 10.0,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.asset(
                        "images/default.png",
                        height: 48,
                        width: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: ListView(
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    getFullName(place),
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.basicprimary),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    // border: Border.all( width: 1.0, color: FsColor.lightgrey),
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: (place["approved"] != 1)
                                        ? Colors.orange.withOpacity(0.2)
                                        : FsColor.green.withOpacity(0.2),
                                  ),
                                  child: Text(
                                    (place["approved"] != 1)
                                        ? "new request"
                                        : "existing",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: FSTextStyle.h7size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      letterSpacing: 0.5,
                                      color: (place["approved"] != 1)
                                          ? Colors.orange
                                          : FsColor.green,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            // SizedBox(height: 7),
                            Wrap(
                              children: <Widget>[
                                Text(
                                  'Role : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.lightgrey),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  place['member_type_name'].toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Wrap(
                              children: <Widget>[
                                Text(
                                  'Mobile : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.lightgrey),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  place["member_mobile_number"]
                                      .toString()
                                      .toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 3),
                            Wrap(
                              children: <Widget>[
                                Text(
                                  'Email : '.toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.lightgrey),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  place["member_email_id"].toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey),
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                            SizedBox(height: 7),
                            (place["approved"] != 1 &&
                                    place['member_type_name'].toLowerCase() !=
                                        'primary' &&
                                    parentWidget.isUserPrimary)
                                ?
                                // Container(
                                //   child:
                                //   // RichText(
                                //   //   text: TextSpan(
                                //   //     children: <TextSpan>[
                                //   //       TextSpan(text: 'Your member is requested for '.toLowerCase(),style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey)),
                                //   //       TextSpan(text: ' ${place["role"]} Role '.toUpperCase(),style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.primaryflat)),
                                //   //       TextSpan(text: 'Please Accept the request to add'.toLowerCase(),style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey))
                                //   //     ],
                                //   //   ),
                                //   // )
                                //   // Text('Please accept your Member request to add to your unit'.toLowerCase(),
                                //   // style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.darkgrey),
                                //   // ),
                                // ),
                                Row(
                                    children: [
                                      Container(
                                        height: 28,
                                        child: RaisedButton(
                                          color: FsColor.green,
                                          onPressed: () {
                                            parentWidget.acceptMemberRequest(
                                                place["id"]);
                                          },
                                          child: Text('Accept',
                                              style: TextStyle(
                                                  fontSize: FSTextStyle.h6size,
                                                  fontFamily: 'Gilroy-SemiBold',
                                                  color: FsColor.white)),
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Container(
                                        height: 28,
                                        child: RaisedButton(
                                          color: FsColor.red,
                                          onPressed: () {
                                            parentWidget.rejectMemberRequest(
                                                place["id"]);
                                          },
                                          child: Text('Reject',
                                              style: TextStyle(
                                                  fontSize: FSTextStyle.h6size,
                                                  fontFamily: 'Gilroy-SemiBold',
                                                  color: FsColor.white)),
                                        ),
                                      ),
                                    ],
                                  )
                                : ((place['member_type_name'].toLowerCase() !=
                                'primary' &&
                                parentWidget.isUserPrimary)
                                    ? Row(
                                        children: [
                                          Container(
                                            height: 28,
                                            child: OutlineButton(
                                                child: Text("Remove",
                                                    style: TextStyle(
                                                        fontSize:
                                                            FSTextStyle.h6size,
                                                        fontFamily:
                                                            'Gilroy-SemiBold',
                                                        color: FsColor.red)),
                                                onPressed: () {
                                                  parentWidget
                                                      .deleteMemberDialog(
                                                          getFullName(place),
                                                          place["id"]);
                                                },
                                                highlightedBorderColor:
                                                    Colors.red,
                                                borderSide: BorderSide(
                                                    color: Colors.red,
                                                    width: 2),
                                                // shape: StadiumBorder(),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4.0))),
                                            // RaisedButton(
                                            // color: FsColor.red,
                                            // onPressed: (){},
                                            // child: Text('Delete',
                                            //   style: TextStyle(fontSize: FSTextStyle.h6size, fontFamily: 'Gilroy-SemiBold', color: FsColor.white)),
                                            // ),
                                          ),
                                        ],
                                      )
                                    : Container()),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
    // return ListTile(
    //   leading: ClipRRect(
    //     borderRadius: BorderRadius.circular(25),
    //     child: Image.asset(
    //       "images/default.png",
    //       height: 48,
    //       width: 48,
    //       fit: BoxFit.cover,
    //     ),
    //   ),
    //   title: Container(
    //     padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
    //     decoration: BoxDecoration(
    //         border: Border(
    //             bottom: BorderSide(
    //                 width: 1, color: FsColor.lightgrey.withOpacity(0.2)))),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: <Widget>[
    //         Container(
    //           alignment: Alignment.topLeft,
    //           child: Text(
    //             getFullName(),
    //             style: TextStyle(
    //                 fontSize: FSTextStyle.h5size,
    //                 fontFamily: 'Gilroy-SemiBold',
    //                 color: FsColor.basicprimary),
    //           ),
    //         ),
    //         SizedBox(height: 7),
    //         Wrap(
    //           children: <Widget>[
    //             Text(
    //               'Role : '.toLowerCase(),
    //               style: TextStyle(
    //                   fontSize: FSTextStyle.h6size,
    //                   fontFamily: 'Gilroy-SemiBold',
    //                   color: FsColor.lightgrey),
    //               textAlign: TextAlign.left,
    //             ),
    //             Text(
    //               memberDetails["member_type_name"].toString().toLowerCase(),
    //               style: TextStyle(
    //                   fontSize: FSTextStyle.h6size,
    //                   fontFamily: 'Gilroy-SemiBold',
    //                   color: FsColor.darkgrey),
    //               textAlign: TextAlign.left,
    //             ),
    //           ],
    //         ),
    //         Wrap(
    //           children: <Widget>[
    //             Text(
    //               'Mobile : '.toLowerCase(),
    //               style: TextStyle(
    //                   fontSize: FSTextStyle.h6size,
    //                   fontFamily: 'Gilroy-SemiBold',
    //                   color: FsColor.lightgrey),
    //               textAlign: TextAlign.left,
    //             ),
    //             Text(
    //               memberDetails["member_mobile_number"]
    //                   .toString()
    //                   .toLowerCase(),
    //               style: TextStyle(
    //                   fontSize: FSTextStyle.h6size,
    //                   fontFamily: 'Gilroy-SemiBold',
    //                   color: FsColor.darkgrey),
    //               textAlign: TextAlign.left,
    //             ),
    //           ],
    //         ),
    //         Wrap(
    //           children: <Widget>[
    //             Text(
    //               'Email : '.toLowerCase(),
    //               style: TextStyle(
    //                   fontSize: FSTextStyle.h6size,
    //                   fontFamily: 'Gilroy-SemiBold',
    //                   color: FsColor.lightgrey),
    //               textAlign: TextAlign.left,
    //             ),
    //             Text(
    //               memberDetails["member_email_id"].toLowerCase(),
    //               style: TextStyle(
    //                   fontSize: FSTextStyle.h6size,
    //                   fontFamily: 'Gilroy-SemiBold',
    //                   color: FsColor.darkgrey),
    //               textAlign: TextAlign.left,
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    //   // trailing: Text('trailing Text'),
    // );
  }

  String getFullName(memberDetail) {
    var firstName = "";
    var lastName = "";
    if (memberDetail["member_first_name"] != null) {
      firstName = memberDetail["member_first_name"];
    }
    if (memberDetail["member_last_name"] != null) {
      lastName = memberDetail["member_last_name"];
    }
    print("ccccccccccccccccccccccccc");
    print(firstName);
    print(lastName);
    return (firstName + " " + lastName).trim().toLowerCase();
  }
}
