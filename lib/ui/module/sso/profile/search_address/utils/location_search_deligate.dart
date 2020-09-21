import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/profile/search_address/models/address_model.dart';
import 'package:sso_futurescape/ui/module/sso/profile/search_address/models/response_autocomplete.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

import 'location_helper.dart';

class LocationSearchDelegate extends SearchDelegate<List<Address>> {
  final bool gotoNext;

  Function clickEvent;

//  var businessAppMode;

  LocationSearchDelegate({this.gotoNext, this.clickEvent});

  @override
  Widget buildSuggestions(BuildContext context) {
    return provideSuggestions();
  }

  @override
  String get searchFieldLabel => 'Search by address/pin code'.toLowerCase();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return searchResultByName();
  }

  FutureBuilder<List<Predictions>> provideSuggestions() {
    return FutureBuilder(
      future: LocationHelper.placeAutoComplete(query),
      builder: (context, snapshot) {
        if (snapshot != null) {
          List<Predictions> list = snapshot.data;
          if (list != null) {
            return list.length == 0
                ? Center(child: Text(""))
                : ListView.builder(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: list == null ? 0 : list.length,
              itemBuilder: (BuildContext context, int index) {
                Predictions place = list[index];
                      return InkWell(
                        onTap: () {
                          fetchDetailsAndNavigateToMap(
                              context: context, placeId: list[index].placeId);
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                  width: 1.0,
                                  color: FsColor.lightgrey.withOpacity(0.5),
                                )),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Icon(FlutterIcon.location_1,
                                        color: FsColor.darkgrey,
                                        size: FSTextStyle.h3size),
                                    SizedBox(height: 5),
//                          Text('${place["distance"]}',
//                            style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.lightgrey, fontFamily: 'Gilroy-SemiBold'),
//                          ),
                                  ],
                                ),
                              ),
//                    SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${place.description}',
                                      style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        color: FsColor.basicprimary,
                                        fontFamily: 'Gilroy-SemiBold',
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(height: 5),
                                    /*Text('${place.formattedAddress}',
                                style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.darkgrey.withOpacity(0.65), fontFamily: 'Gilroy-SemiBold'),
                              ),*/
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  FutureBuilder<List<Address>> searchResultByName() {
    return FutureBuilder(
      future: LocationHelper.searchPlacesByName(query),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          print("dsishdisndisidnisndins");
          print(snapshot.data);
          List<Address> list = snapshot.data;
          return list.length == 0
              ? Center(child: Text("No Matches Found"))
              : ListView.builder(
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: list == null ? 0 : list.length,
            itemBuilder: (BuildContext context, int index) {
              Address place = list[index];
              return InkWell(
                onTap: () {
                  navigate(context, list[index]);
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(
                          width: 1.0,
                          color: FsColor.lightgrey.withOpacity(0.5),
                        )),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Icon(FlutterIcon.location_1,
                                color: FsColor.darkgrey,
                                size: FSTextStyle.h3size),
                            SizedBox(height: 5),
//                          Text('${place["distance"]}',
//                            style: TextStyle(fontSize: FSTextStyle.h7size, color: FsColor.lightgrey, fontFamily: 'Gilroy-SemiBold'),
//                          ),
                          ],
                        ),
                      ),
//                    SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${place.address}',
                              style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.basicprimary,
                                fontFamily: 'Gilroy-SemiBold',
                                letterSpacing: 1,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${place.formattedAddress}',
                              style: TextStyle(
                                  fontSize: FSTextStyle.h7size,
                                  color:
                                  FsColor.darkgrey.withOpacity(0.65),
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Future<void> fetchDetailsAndNavigateToMap(
      {BuildContext context, String placeId}) async {
    LocationHelper.getPlaceDetails(placeID: placeId).then((value) {
      print(value.formattedAddress);
      navigate(context, value);
    });
  }

  void navigate(BuildContext context, Address address) {
    if (gotoNext) {
//      Navigator.of(context).pushNamed(MapScreen.routeName, arguments: {
//        'address': address,
//      });
    } else {
      if (clickEvent != null) {
        clickEvent(address);
      }
      Navigator.of(context).pop();
    }
  }
}
