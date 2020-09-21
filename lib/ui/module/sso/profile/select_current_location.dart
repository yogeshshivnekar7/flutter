import 'dart:collection';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/profile/map/simple_map.dart';
import 'package:sso_futurescape/ui/module/sso/profile/search_address/utils/location_search_deligate.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

// enum SingingCharacter { lafayette, jefferson }

class SelectCurrentLocation extends StatefulWidget {
  Color primary_color;

  SelectCurrentLocation([this.primary_color]);

  @override
  _SelectCurrentLocationState createState() =>
      new _SelectCurrentLocationState(primary_color);
}

class _SelectCurrentLocationState extends State<SelectCurrentLocation> {
  var address;
  bool isLocation = false;
  double long;
  double lat;
  Color primary_color = Colors.black;

  REQUEST_TYPE request_type;
  bool _isLoading = false;

  String shortAddress = "";

  String flatHouseController;
  String tagController;
  String addressController;
  String landmarkController;
  String localityController;
  String zipcodeController;
  String cityController;
  String stateController;
  String countryController;

  _SelectCurrentLocationState([this.primary_color]);

  @override
  void initState() {
    print("initState");
    initializevalue();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color1 = Color(0xff404040);
    final Color color2 = Color(0xff999999);
    final _media = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: new AppBar(

        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Select Location".toLowerCase(),
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(),
          actions: <Widget>[
            buildSearchWidget(context),
          ]
      ),
      body: /*true? Container(child: MapSample(),):*/ /* new Builder(builder: (context) {*/
          /*return*/
          Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Container(
              child: MapSample(
                gotoFuction: (map) {
                  print("mappppppppppppppppppppppppppp");
                  _mapSample = map;
                },
                locationFound: (var result, double latitude, double longitude) {
                  /*print("hhhhhhhhhhhhhhhhhhhhhhhhh");*/
                  print(result);
                  /*  print(latitude);*/
                  this.long = longitude;
                  this.lat = latitude;
                  /*print(longitude);
                print("hhhhhhhhhhhhhhhhhhhhhhhhh");*/
                  List addresses = result[0]["address_components"];
                  try {
                    flatHouseController = "";
                    addressController = "";
                    landmarkController = "";
                    localityController = "";
                    zipcodeController = "";
                    cityController = "";
                    stateController = "";
                    countryController = "";
                    tagController = "";

                    for (int a = 0; a < addresses.length; a++) {
                      var address = addresses[a];

                      List types = address["types"];
                      for (int b = 0; b < types.length; b++) {
                        String type = types[b].toString();
                        print(localityController.isNotEmpty);
                        print(type);

                        if (type == "premise") {
                          flatHouseController = address["long_name"].toString();
                          print("flatHouseController" + address["long_name"]);
                          break;
                        } else if (type == "postal_code") {
                          zipcodeController = address["long_name"].toString();
                          print(
                              "zipcodeController.text" + address["long_name"]);
                          break;
                        } else if (type == "sublocality" &&
                            localityController.isEmpty) {
                          localityController = address["long_name"].toString();
                          print(
                              "localityController.text" + address["long_name"]);

                          break;
                        } else if (type == "sublocality_level_2") {
                          addressController = (addressController +
                              " " +
                              address["long_name"].toString())
                              .trim();
                          print(
                              "addressController.text" + address["long_name"]);
                          break;
                        } else if (type.contains("sublocality_level_1")) {
                          addressController = addressController +
                              address["long_name"].toString();
                          print(
                              "addressController.text" + address["long_name"]);
                          break;
                        } else if (type == "locality") {
                          cityController = address["long_name"].toString();
                          print("cityController.text" + address["long_name"]);
                          break;
                        } else if (type == "administrative_area_level_1") {
                          stateController = address["long_name"].toString();
                          print("stateController.text" + address["long_name"]);

                          break;
                        } else if (type == "country") {
                          countryController = address["long_name"].toString();
                          print(
                              "countryController.text" + address["long_name"]);
                          break;
                        }
                      }
                    }
                    print(addressController + "My Address");
                    if (addressController.trim().isEmpty) {
                      print(addressController + " In loop");
                      if (cityController.trim().isEmpty) {
                        addressController = stateController;
                        shortAddress =
                        "${stateController}, ${countryController}, ${zipcodeController}";
                      } else {
                        addressController = cityController;
                        shortAddress =
                        "${cityController}, ${stateController}, ${countryController}, ${zipcodeController}";
                      }
                    } else {
                      print(addressController + " Out loop");
                      shortAddress = "${localityController}, "
                          "${addressController}, "
                          "${cityController}, ${stateController}, ${countryController}, ${zipcodeController}";
                    }
                    print("shortAddress");
                    print(shortAddress);
                  } catch (e) {
                    //print("ssssssssssssssssssssssss");
                    print(e);
                  }
                  _isLoading = false;
                  setState(() {});
                },
                locationLoading: (bool a) {
                  _isLoading = true;
                  shortAddress = "";
                  setState(() {});
                },
              ),
            ),
          ),
          Expanded(
            flex: 3, //
            child: Form(
              child: ListView(
                children: <Widget>[
                  ListTile(
                      title: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Icon(
                              FlutterIcon.location_1,
                              size: FSTextStyle.h2size,
                              color: FsColor.lightgrey,
                            ),
                          ),
                          _isLoading
                              ? Text(
                            "Loading...",
                            style: TextStyle(
                                fontFamily: 'Gilroy-SemiBold',
                                fontSize: FSTextStyle.h4size,
                                color: FsColor.basicprimary),
                          )
                              : Text(
                            addressController,
                            style: TextStyle(
                                fontFamily: 'Gilroy-SemiBold',
                                fontSize: FSTextStyle.h4size,
                                color: FsColor.basicprimary),
                          )
                        ],
                      ),
                      subtitle: shortAddress == null || shortAddress.isEmpty
                          ? Container()
                          : Container(
                        margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: Text(
                          shortAddress,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.basicprimary),
                        ),
                      )),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                    child: GestureDetector(
                      child: RaisedButton(
                        child: Text('Confirm Location',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        color: _isLoading ? Colors.grey : primary_color,
                        textColor: FsColor.white,
                        onPressed: () {
                          if (_isLoading) {
                            return;
                          }
                          Navigator.of(context)
                              .pop({'selection': prepareData()});
                          //  addNewAddressAPICall(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
/*
              ],
              */ /*   ),*/ /*
            ),*/
          )
        ],
      ),

      /* ],
                ),*/
      //  )
      /*})*/
    );
  }

  prepareData() {
    HashMap<String, String> param = new HashMap();
    param["address"] = addressController;
    param["landmark"] = landmarkController;
    param["locality"] = localityController;
    param["zipcode"] = zipcodeController;
    param["city"] = cityController;
    param["address_tag"] = addressController;
    param["state"] = stateController;
    param["country"] = countryController;
    param["latitude"] = lat.toString();
    param["longitude"] = long.toString();
    //param["address_tag"] = _addTag;
    //param["locality"] = "abc";
    //param["state"] = "maha";
    //param["country"] = "India";

    /*param["state"] = address["state"];
      param["country"] = address["country"];*/

    return param;
  }

  showSnackbar(BuildContext context, String msg) {
    /*SnackBar snackBar = SnackBar(

        behavior: SnackBarBehavior.fixed,
        content: Text(msg,
            style: TextStyle(
                color: FsColor.white,
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold')));
    Scaffold.of(context).showSnackBar(snackBar);*/
    Toasly.error(context, msg);
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
  }

  void initializevalue() {
    flatHouseController = "";
    addressController = "";
    landmarkController = "";
    localityController = "";
    zipcodeController = "";
    cityController = "";
    tagController = "";
    /*stateController.text = "";
    CountryController.text = "";*/
  }

  @override
  void onProfileProgress(String success) {
    // TODO: implement onProfileProgress
  }

  MapSampleState _mapSample;

  IconButton buildSearchWidget(BuildContext context) {
    return IconButton(
      color: FsColor.black,
      icon: Icon(Icons.search),
      onPressed: () {
        showSearch(
            context: context,
            delegate: LocationSearchDelegate(
                gotoNext: false,
                clickEvent: (address) {
                  print("selected address ------------ ");
                  print(address.lat);
                  print(address.long);
                  print(_mapSample);
                  _mapSample.goToLocation(address.lat, address.long);
                }));
      },
    );
  }
}

enum REQUEST_TYPE { GET_COUNTRY, GET_STATES, ADD_NEW_ADDRESS }
