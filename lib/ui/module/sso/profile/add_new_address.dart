import 'dart:collection';
import 'dart:convert';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_model.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/sso/profile/map/simple_map.dart';
import 'package:sso_futurescape/ui/module/sso/profile/search_address/utils/location_search_deligate.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/focus_utils.dart';
import 'package:sso_futurescape/utils/validation_utils.dart';

import 'country.dart';

// enum SingingCharacter { lafayette, jefferson }

class AddNewAddress extends StatefulWidget {
  var addressList;

  AddNewAddress(this.addressList);

  @override
  _AddNewAddressState createState() => new _AddNewAddressState(addressList);
}

class _AddNewAddressState extends State<AddNewAddress>
    implements ProfileResponseView, ProfileModelResponse {
  var address;
  bool isLocation = false;
  ProfilePresenter profilePresenter;

  List<String> _stateNames = [];
  String _selectedStateName;
  double long;
  double lat;

  List<Country> _countriesObj = [];
  List<String> _countryNames = [];
  String _selectedCountryName;
  Country _selectedCountryObj;
  bool isRequired = false;
  String _addTag;
  REQUEST_TYPE request_type;
  TextEditingController flatHouseController = new TextEditingController();
  TextEditingController addressController = new TextEditingController();
  TextEditingController landmarkController = new TextEditingController();
  TextEditingController localityController = new TextEditingController();
  TextEditingController zipcodeController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController tagController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  TextEditingController countryController = new TextEditingController();

  FocusNode _flatHouseNode;
  FocusNode _addressNode;
  FocusNode _landmarkNode;
  FocusNode _localityNode;
  FocusNode _zipcodeNode;
  FocusNode _cityNode;

  GlobalKey<FormState> _formKey;
  bool _autoValidate = false;
  bool _isLoading = true;

  String shortAddress = "";

  var addressList;

  _AddNewAddressState(this.addressList);

  void _addressTag(String value) {
    setState(() {
      _addTag = value;
    });
  }

  @override
  void initState() {
    print("initState");
    getCountryApiCall();
    initializevalue();
    _flatHouseNode = new FocusNode();
    _addressNode = new FocusNode();
    _landmarkNode = new FocusNode();
    _localityNode = new FocusNode();
    _zipcodeNode = new FocusNode();
    _cityNode = new FocusNode();
    _formKey = new GlobalKey<FormState>();

    if (checkAlreadyUsedTag('home') && checkAlreadyUsedTag('work')) {
      _addTag = 'other';
    }
    super.initState();
  }

  bool isShowMap = true;

  @override
  void dispose() {
    _flatHouseNode.dispose();
    _addressNode.dispose();
    _landmarkNode.dispose();
    _localityNode.dispose();
    _zipcodeNode.dispose();
    _cityNode.dispose();
    super.dispose();
  }

  void showCloseAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.fromLTRB(24.0, 16.0, 24.0, 16.0),
            backgroundColor: Colors.white,
            title: new Text("Address not saved?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey)),
            shape: new RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: new BorderRadius.circular(7.0),
            ),
            content: new Text(
                "Are you sure you want to continue without saving ?",
                textAlign: TextAlign.start,
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h6size,
                    color: Colors.grey[600])),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                },
                child: Text(
                  "No",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop('dialog');
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Yes",
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColorStepper.active),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final Color color1 = Color(0xff404040);
    final Color color2 = Color(0xff999999);
    final _media = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () {
        showCloseAlertDialog(context);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: new AppBar(
            backgroundColor: Colors.white,
            elevation: 0.0,
            title: Text(
              "Add New Address".toLowerCase(),
              style: FSTextStyle.appbartext,
            ),
            leading: FsBackButton(
              backEvent: (context) {
                showCloseAlertDialog(context);
              },
            ),
            actions: <Widget>[
              buildSearchWidget(context),
            ]),
        body: _isLoading
            ? PageLoader()
        /* */
            : /*true? Container(child: MapSample(),):*/ /* new Builder(builder: (context) {*/
        /*return*/
        Column(
          children: <Widget>[
            SizedBox(
              height: isShowMap ? 300 : 0,
              child: Container(
                child: MapSample(gotoFuction: (map) {
                  _mapSample = map;
                }, locationFound:
                    (var result, double latitude, double longitude) {
                  /*print("hhhhhhhhhhhhhhhhhhhhhhhhh");*/
                  print(result);
                  /*  print(latitude);*/
                  this.long = longitude;
                  this.lat = latitude;
                  /*print(longitude);
                  print("hhhhhhhhhhhhhhhhhhhhhhhhh");*/
                  List addresses = result[0]["address_components"];
                  try {
                    flatHouseController.text = "";
                    addressController.text = "";
                    landmarkController.text = "";
                    localityController.text = "";
                    zipcodeController.text = "";
                    cityController.text = "";
                    tagController.text = "";
                    stateController.text = "";
                    countryController.text = "";

                    for (int a = 0; a < addresses.length; a++) {
                      var address = addresses[a];

                      List types = address["types"];
                      for (int b = 0; b < types.length; b++) {
                        String type = types[b].toString();
                        print(localityController.text.isNotEmpty);
                        print(type);

                        /*if (type == "premise") {
                                      flatHouseController.text =
                                          address["long_name"].toString();
                                      print("flatHouseController" +
                                          address["long_name"]);
                                      break;
                                    } else*/
                        if (type == "postal_code") {
                          zipcodeController.text =
                              address["long_name"].toString();
                          print("zipcodeController.text" +
                              address["long_name"]);
                          break;
                        } else if (type == "sublocality" &&
                            localityController.text.isEmpty) {
                          localityController.text =
                              address["long_name"].toString();
                          print("localityController.text" +
                              address["long_name"]);

                          break;
                        } else if (type == "sublocality_level_2") {
                          addressController.text =
                              (addressController.text +
                                  " " +
                                  address["long_name"].toString())
                                  .trim();
                          print("addressController.text" +
                              address["long_name"]);
                          break;
                        } else if (type.contains("sublocality_level_1")) {
                          addressController.text =
                              addressController.text +
                                  address["long_name"].toString();
                          print("addressController.text" +
                              address["long_name"]);
                          break;
                        } else if (type == "locality") {
                          cityController.text =
                              address["long_name"].toString();
                          print("cityController.text" +
                              address["long_name"]);
                          break;
                        } else if (type ==
                            "administrative_area_level_1") {
                          stateController.text =
                              address["long_name"].toString();
                          print("stateController.text" +
                              address["long_name"]);

                          break;
                        } else if (type == "country") {
                          countryController.text =
                              address["long_name"].toString();
                          _selectedCountryName = countryController.text;
                          print("countryController.text" +
                              address["long_name"]);
                          for (Country stateName in _countriesObj) {
                            /*print(countryController.text);*/
                            if (_selectedCountryName == stateName.name) {
                              _selectedCountryName =
                                  countryController.text;
                              _selectedCountryObj = stateName;
                              getStateApiCall(stateName.id);
                              break;
                            }
                          }
                          break;
                        }
                      }
                    }

                    print("shortAddress");
                    if (localityController.text
                        .trim()
                        .isEmpty) {
                      shortAddress =
                      "${cityController.text}, ${stateController
                          .text}, ${countryController.text}, ${zipcodeController
                          .text}";
                    } else if (cityController.text
                        .trim()
                        .isEmpty) {
                      shortAddress =
                      "${stateController.text}, ${countryController.text}";
                    } else {
                      shortAddress =
                      "${localityController.text}, ${cityController
                          .text}, ${stateController.text}, ${countryController
                          .text}, ${zipcodeController.text}";
                    }
                    print(shortAddress);
                  } catch (e) {
                    //print("ssssssssssssssssssssssss");
                    print(e);
                  }
                  setState(() {});
                }),
              ),
            ),
            Expanded(
              child:
              /* Container(
                      child:*/ /*Column(
                children: <Widget>[*/
              /*  Container(
                            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              children: <Widget>[
                                */
              /* Container(child: SizedBox(
                           */ /* */
              /* child: MapSample(),*/ /* */ /*
                            height: 200,
                          ),),*/
              /*

                                SizedBox(height: 10),
                                isLocation
                                    ? ListTile(
                                        title: Text(
                                          "Vashi",
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Regular',
                                          ),
                                        ),
                                        subtitle: Text(
                                          "1905, cyber one, sector 30A, vashi, navi mumbai.",
                                          style: TextStyle(
                                              fontFamily: 'Gilroy-Regular',
                                              color: const Color(0xff404040)),
                                        ),
                                        leading: Icon(Icons.place),
                                      )
                                    : Container(),
                                isLocation
                                    ? Container(
                                        padding: EdgeInsets.all(5),
                                        margin: EdgeInsets.fromLTRB(67, 0, 0, 0),
                                        child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              new FlatButton(
                                                child: new Text("Change",
                                                    style: TextStyle(
                                                      fontSize:
                                                          FSTextStyle.h6size,
                                                      fontFamily:
                                                          'Gilroy-SemiBold',
                                                      color: FsColor.darkgrey,
                                                    )),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ManageAddress(null)),
                                                  );
                                                },
                                              ),
                                            ]),
                                      )
                                    : Container(),

                                */ /* MapSample(),*/ /*
                              ],
                            ),
                          ),*/
              Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: ListView(
                  children: <Widget>[
                    FlatButton(
                      onPressed: () {
                        isShowMap = true;
                        setState(() {});
                        /*  flatHouseController.clear();
                                          landmarkController.clear();
                                          tagController.clear();*/
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Padding(
                          padding: EdgeInsets.fromLTRB(2, 8, 2, 0),
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color:
                                      FsColor.lightgrey.withOpacity(0.6)),
                                )),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Your Location",
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        shortAddress == null ||
                                            shortAddress.isEmpty
                                            ? ""
                                            : shortAddress,
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-SemiBold',
                                          fontSize: FSTextStyle.h5size,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                isShowMap
                                    ? Container()
                                    : Container(
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.my_location,
                                        size: FSTextStyle.h4size,
                                        color:
                                        FsColor.primaryvisitor,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        'Change',
                                        style: TextStyle(
                                            fontFamily:
                                            'Gilroy-SemiBold',
                                            fontSize:
                                            FSTextStyle.h5size,
                                            color: FsColor
                                                .primaryvisitor),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),
                    ListTile(
                      subtitle: TextFormField(
                        onTap: () {
                          isShowMap = false;
                          setState(() {});
                        },
                        textInputAction: TextInputAction.next,
                        focusNode: _flatHouseNode,
                        onEditingComplete: () {
                          FocusUtils.shiftFocus(context,
                              from: _flatHouseNode, to: _addressNode);
                        },
                        autovalidate: _autoValidate,
                        validator: (value) {
                          if (ValidationUtils.isValueNullOrEmpty(value)) {
                            return 'Need the name/number of building, flat or office';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                        ),
                        controller: flatHouseController,
                        decoration: InputDecoration(
                            errorText: null,
                            errorMaxLines: 3,
                            errorStyle: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              color: FsColor.red,
                            ),
                            labelText: 'Flat/Building/Office *'),
                      ),
                    ),
                    /*ListTile(
                            subtitle: TextFormField(
                              */ /*onTap: () {
                                          _formKey.currentState.reset();
                                        },*/ /*
                              textInputAction: TextInputAction.next,
                              focusNode: _addressNode,
                              onEditingComplete: () {
                                FocusUtils.shiftFocus(context,
                                    from: _addressNode, to: _landmarkNode);
                              },
                              autovalidate: _autoValidate,
                              validator: (value) {
                                if (ValidationUtils.isValueNullOrEmpty(value)) {
                                  return 'Primary address line is needed';
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                              ),
                              minLines: 1,
                              maxLines: 4,
                              controller: addressController,
                              decoration: InputDecoration(
                                  errorText: null,
                                  errorMaxLines: 3,
                                  errorStyle: TextStyle(
                                    fontFamily: 'Gilroy-Regular',
                                    color: FsColor.red,
                                  ),
                                  labelText: 'Address'),
                            ),
                          ),*/
                    !isRequired
                        ? Container()
                        : ListTile(
                      subtitle: TextFormField(
                        /*onTap: () {
                                          _formKey.currentState.reset();
                                        },*/
                        textInputAction: TextInputAction.next,
                        focusNode: _localityNode,
                        onEditingComplete: () {
                          FocusUtils.shiftFocus(context,
                              from: _localityNode, to: _cityNode);
                        },
                        autovalidate: _autoValidate,
                        validator: (value) {
                          /*if (ValidationUtils.isValueNullOrEmpty(
                                              value)) {
                                            return 'Need the name of the locality';
                                          }*/
                          return null;
                        },
                        style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                        ),
                        controller: localityController,
                        decoration: InputDecoration(
                            errorText: null,
                            errorMaxLines: 3,
                            errorStyle: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              color: FsColor.red,
                            ),
                            labelText: 'Locality'),
                      ),
                    ),
                    ListTile(
                      subtitle: TextFormField(
                        onTap: () {
                          isShowMap = false;
                          setState(() {});
                        },
                        textInputAction: TextInputAction.next,
                        focusNode: _landmarkNode,
                        onEditingComplete: () {
                          FocusUtils.shiftFocus(context,
                              from: _landmarkNode, to: _localityNode);
                        },
                        autovalidate: _autoValidate,
                        validator: (value) {
                          /*if (ValidationUtils.isValueNullOrEmpty(
                                              value)) {
                                            return 'Need a prominent landmark for the address';
                                          }*/
                          return null;
                        },
                        style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                        ),
                        controller: landmarkController,
                        decoration: InputDecoration(
                            errorText: null,
                            errorMaxLines: 3,
                            errorStyle: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              color: FsColor.red,
                            ),
                            labelText: 'Landmark'),
                      ),
                    ),

                    /* !isRequired
                        ? Container()
                        :*/

                    !isRequired
                        ? Container()
                        : ListTile(
                      subtitle: TextFormField(
                        /*onTap: () {
                                          _formKey.currentState.reset();
                                        },*/
                        textInputAction: TextInputAction.next,
                        focusNode: _cityNode,
                        onEditingComplete: () {
                          FocusUtils.shiftFocus(context,
                              from: _cityNode, to: _zipcodeNode);
                        },
                        autovalidate: _autoValidate,
                        validator: (value) {
                          if (ValidationUtils.isValueNullOrEmpty(
                              value)) {
                            return 'City name is needed';
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                        ),
                        controller: cityController,
                        decoration: InputDecoration(
                            errorText: null,
                            errorMaxLines: 3,
                            errorStyle: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              color: FsColor.red,
                            ),
                            labelText: 'City'),
                      ),
                    ),
                    !isRequired
                        ? Container()
                        : ListTile(
                      subtitle: TextFormField(
                        /*onTap: () {
                                          _formKey.currentState.reset();
                                        },*/
                        textInputAction: TextInputAction.done,
                        focusNode: _zipcodeNode,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        autovalidate: _autoValidate,
                        validator: (value) {
                          if (ValidationUtils.isValueNullOrEmpty(
                              value)) {
                            return 'Zip code is needed';
                          }

                          if (!ValidationUtils.isZipcodeValid(
                              value, 6)) {
                            return 'Zip code must be exactly of 6 digits';
                          }

                          return null;
                        },
                        style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                        ),
                        controller: zipcodeController,
                        decoration: InputDecoration(
                            errorText: null,
                            errorMaxLines: 3,
                            errorStyle: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              color: FsColor.red,
                            ),
                            labelText: 'Zipcode'),
                      ),
                    ),
                    /* SizedBox(height: 12),*/
                    !isRequired
                        ? Container()
                        : ListTile(
                      title: Text(
                        "State",
                        style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: 12,
                          color: const Color(0xFF7b7b7b),
                        ),
                      ),
                      subtitle: new Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: DropdownButton(
                                hint: Text(
                                  'Choose your state',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Regular',
                                  ),
                                ),
                                value: _selectedStateName,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedStateName = newValue;
                                  });
                                },
                                items: _stateNames.map((state) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      state,
                                      style: TextStyle(
                                        fontFamily:
                                        'Gilroy-Regular',
                                      ),
                                    ),
                                    value: state,
                                  );
                                }).toList(),
                              ),
                            ),
                          ]),
                    ),
                    !isRequired
                        ? Container()
                        : ListTile(
                      title: Text(
                        "Country",
                        style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: 12,
                          color: const Color(0xFF7b7b7b),
                        ),
                      ),
                      subtitle: new Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: DropdownButton(
                                hint: Text(
                                  'Choose your country',
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Regular',
                                  ),
                                ),
                                value: _selectedCountryObj,
                                onChanged: (newValue) {
                                  setState(() {
                                    _selectedCountryName =
                                        newValue.name;
                                    _selectedCountryObj = newValue;
                                  });
                                  getStateApiCall(newValue.id);
                                },
                                items: _countriesObj.map((country) {
                                  return DropdownMenuItem(
                                    child: new Text(
                                      country.name,
                                      style: TextStyle(
                                        fontFamily:
                                        'Gilroy-Regular',
                                      ),
                                    ),
                                    value: country,
                                  );
                                }).toList(),
                              ),
                            ),
                          ]),
                    ),
                    /*SizedBox(height: 10),*/
                    Container(
                      /* title: Text(
                              "Saved As",
                              style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                fontSize: 12,
                                color: const Color(0xFF7b7b7b),
                              ),
                            ),
                            subtitle:*/
                      child: Column(
                        children: <Widget>[
                          new Row(children: <Widget>[
                            checkAlreadyUsedTag('home')
                                ? Container()
                                : new Radio(
                              value: "home",
                              activeColor: const Color(0xFF545454),
                              groupValue: _addTag,
                              onChanged: (String value) {
                                _addressTag(value);
                                address_tag_validator = true;
                                isShowMap = false;
                                setState(() {});
                              },
                            ),
                            /*title:*/ checkAlreadyUsedTag('home')
                                ? Container()
                                : new Text(
                              "Home",
                              style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                              ),
                            ),
                            checkAlreadyUsedTag('work')
                                ? Container()
                                : new Radio(
                              value: "work",
                              activeColor: const Color(0xFF545454),
                              groupValue: _addTag,
                              onChanged: (String value) {
                                isShowMap = false;
                                address_tag_validator = true;
                                setState(() {});
                                _addressTag(value);
                              },
                            ),
                            /*title:*/ checkAlreadyUsedTag('work')
                                ? Container()
                                : new Text(
                              "Work",
                              style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                              ),
                            ),
                            new Radio(
                              value: "other",
                              activeColor: const Color(0xFF545454),
                              groupValue: _addTag,
                              onChanged: (String value) {
                                _addressTag(value);
                                isShowMap = false;
                                address_tag_validator = true;
                                setState(() {});
                              },
                            ),
                            /*title:*/ new Text(
                              "Other",
                              style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                              ),
                            ),
                          ]),
                          address_tag_validator
                              ? Container()
                              : Container(
                            margin:
                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Please choose an address type",
                              style: TextStyle(
                                color: FsColor.red,
                                fontFamily: 'Gilroy-Regular',
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    /*ListTile(*/
                    /*title: */ _addTag == "other"
                        ? Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                      alignment: Alignment.center,
                      child:
                      /*,
                                    subtitle:*/
                      TextFormField(
                        /*onTap: () {
                                              _formKey.currentState.reset();
                                            },*/

                        onTap: () {
                          isShowMap = false;
                          setState(() {});
                        },
                        textInputAction: TextInputAction.done,
                        maxLength: 10,
                        autovalidate: _autoValidate,
                        validator: (value) {
                          if (_addTag == 'other') {
                            if (ValidationUtils.isValueNullOrEmpty(
                                value)) {
                              return 'Please specify the address type';
                            }
                          }
                          return null;
                        },
                        style: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                        ),
                        /*initialValue: "",*/
                        controller: tagController,
                        decoration: InputDecoration(
                          errorText: null,
                          errorMaxLines: 3,
                          errorStyle: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            color: FsColor.red,
                          ),
                          labelText: "e.g DadsOffice",
                        ),
                      ),
                    )
                        : Container(),
                    //),
                    /* ListTile(
                            title:*/
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      /*padding:
                                  EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),*/
                      child: GestureDetector(
                        child: RaisedButton(
                          child: Text('Save And Proceed',
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold')),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(4.0),
                          ),
                          color: const Color(0xFF404040),
                          textColor: FsColor.white,
                          onPressed: () {
                            addNewAddressAPICall(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    )
                    // )
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
      ),
    );
  }

  bool address_tag_validator = true;

  addNewAddressAPICall(BuildContext context) {
    request_type = REQUEST_TYPE.ADD_NEW_ADDRESS;
    print("addNewAddressAPICall");
    //bool isValid = checkValidity();
    if (!_formKey.currentState.validate()) {
      return;
    }
    /*else {
      Toasly.warning(context, "Please fill all details",
          duration: Duration.SHORT, gravity: Gravity.BOTTOM);
    }*/

    String address = flatHouseController.text + " " + addressController.text;
    if (address.length < 10) {
      showSnackbar(
          context, "Flat/Building/Office must be of atleast 10 characters");
      return;
    }

    if (ValidationUtils.isValueNullOrEmpty(_selectedStateName)) {
      showSnackbar(context,
          "Looks like we can't pin point your location on the map. Please try again..");
      return;
    }

    if (ValidationUtils.isValueNullOrEmpty(_selectedCountryName)) {
      showSnackbar(context,
          "Looks like we can't pin point your location on the map. Please try again..");
      return;
    }

    if (ValidationUtils.isValueNullOrEmpty(_addTag)) {
      print("AAAAAAA");
      address_tag_validator = false;
      setState(() {});
      //showSnackbar(context, "Please choose an address type (Home, Work or Other)");
      return;
    }

    profilePresenter = new ProfilePresenter(this);
    HashMap<String, String> param = prepareData();
    print("address " + param.toString());
    profilePresenter.addNewAddress(param);
    _isLoading = true;
    setState(() {});
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

  getCountryApiCall() {
    print("getCountryApiCall");
    request_type = REQUEST_TYPE.GET_COUNTRY;
    profilePresenter = new ProfilePresenter(this);
    profilePresenter.getCountry();
  }

  getStateApiCall(int countryId) {
    request_type = REQUEST_TYPE.GET_STATES;
    profilePresenter = new ProfilePresenter(this);
    profilePresenter.getStates(countryId.toString());
  }

  bool checkValidity() {
    if (flatHouseController.text == null ||
        flatHouseController.text
            .trim()
            .isEmpty) {
      return false;
    }
    if (addressController.text == null ||
        addressController.text
            .trim()
            .isEmpty) {
      return false;
    }
    if (landmarkController.text == null ||
        landmarkController.text
            .trim()
            .isEmpty) {
      return false;
    }
    if (localityController.text == null ||
        localityController.text
            .trim()
            .isEmpty) {
      return false;
    }
    if (zipcodeController.text == null ||
        zipcodeController.text
            .trim()
            .isEmpty) {
      return false;
    }
    if (cityController.text == null || cityController.text
        .trim()
        .isEmpty) {
      return false;
    }

    if ((_selectedCountryName == null) || _selectedCountryName
        .trim()
        .isEmpty) {
      return false;
    }

    if ((_selectedStateName == null) || _selectedStateName
        .trim()
        .isEmpty) {
      return false;
    }

    if ((_addTag == null) || _addTag
        .trim()
        .isEmpty) {
      return false;
    }

    if ((_addTag == "other") &&
        ((tagController.text == null) || (tagController.text
            .trim()
            .isEmpty))) {
      return false;
    }
    /* if (_addTag != null && _addTag == "other") {
      if (tagController.text.trim() == null ||
          tagController.text.trim().isEmpty) {
        isValid = true;
      }
    } else if (_addTag == null) {
      isValid = true;
    } else if (_addTag == "home" || _addTag == "office") {
      _addTag = null;
    }*/

    /*if (_selectedState == null ||
        _selectedState.isEmpty) {
      isValid = true;
    }
    if (_selectedCountry == null ||
        _selectedCountry.isEmpty) {
      isValid = true;
    }*/
    return true;
  }

  @override
  void hideProgress() {
    // TODO: implement hideProgress
  }

  @override
  void onError(String error) {
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((error))),
        duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
    //showSnackbar(context, "Looks like we can't pin point your location on the map. Please try again..");
    _isLoading = false;
    setState(() {});
  }

  @override
  void onFailure(String failure) {
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((failure))));

    _isLoading = false;
    setState(() {});
  }

  @override
  void onSuccess(String success) {
    print("Success " + success);
    if (request_type == REQUEST_TYPE.GET_COUNTRY) {
      Country selectedCountryObj;
      int selectedCountryId = -1;
      String selectedCountryName;
      String selectedCountryCode;
      var responseObj = json.decode(success);
      var dataArr = responseObj['data'];
      for (int i = 0; i < dataArr.length; i++) {
        var dataObj = dataArr[i];
        String countryCode = dataObj['country_code'];
        String countryName = dataObj['name'];
        int countryId = dataObj['country_id'];

        _countryNames.add(countryName);

        Country countryObj = new Country(countryId, countryCode, countryName);
        _countriesObj.add(countryObj);

        /*if (countryCode == 'IN') {
          selectedCountryName = countryName;
          selectedCountryId = countryId;
          selectedCountryCode = countryCode;

          selectedCountryObj = countryObj;
        }*/

      }

      if (selectedCountryId != -1) {
        getStateApiCall(selectedCountryId);
      }
      setState(() {
        //_country =
        if ((selectedCountryName != null) &&
            (selectedCountryName
                .trim()
                .isNotEmpty)) {
          this._selectedCountryName = selectedCountryName;
        }

        if (selectedCountryObj != null) {
          this._selectedCountryObj = selectedCountryObj;
        }

        _isLoading = false;
      });
    } else if (request_type == REQUEST_TYPE.GET_STATES) {
      setState(() {
        var responseObj = json.decode(success);
        List<String> states = [];
        var dataArr = responseObj['data'];
        bool isFound = false;
        for (int i = 0; i < dataArr.length; i++) {
          var dataObj = dataArr[i];
          String stateName = dataObj['name'];
          states.add(stateName);
          if (stateController.text == stateName) {
            isFound = true;
          }
        }
        setState(() {
          if (!isFound) {
            if (states == null || states.length == 0) {
              states = [];
            }
            states.add(stateController.text);
          }
          print("My Stateeeeeeeeeeeeeeeeeeeeeeeeeeeee");
          print(states);
          this._stateNames = states;
          _selectedStateName = stateController.text;
        });
      });
    } else if (request_type == REQUEST_TYPE.ADD_NEW_ADDRESS) {
      /*Navigator.pop(
        context,
        MaterialPageRoute(builder: (context) => ProfileView()),
      );*/

      //Navigator.of(context).pop({'selection': success});

      /*Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ProfileView()));*/
      FsFacebookUtils.callCartClick(FsString.ADD_ADDRESS, "Address");
      _isLoading = false;
      ProfileRepoSaver(context).excute();
    }
  }

  @override
  void showProgress() {
    // TODO: implement showProgress
  }

  prepareData() {
    HashMap<String, String> param = new HashMap();
    param["address"] = flatHouseController.text + " " + addressController.text;
    param["landmark"] = landmarkController.text;
    param["locality"] = localityController.text;
    param["zipcode"] = zipcodeController.text;
    if (cityController.text != null && cityController.text.length > 0) {
      param["city"] = cityController.text;
    }
    param["address_tag"] = _addTag;
    param["state"] = _selectedStateName;
    param["country"] = _selectedCountryName;
    param["tag"] = tagController.text;
    param["latitude"] = lat.toString();
    param["longitude"] = long.toString();
    if (_addTag == "other") {
      //param["tag"] = tagController.text;
      param["address_tag"] = tagController.text;
    } else {
      param["address_tag"] = _addTag;
    }

    //param["address_tag"] = _addTag;
    //param["locality"] = "abc";
    //param["state"] = "maha";
    //param["country"] = "India";

    /*param["state"] = address["state"];
      param["country"] = address["country"];*/

    return param;
  }

  void initializevalue() {
    flatHouseController.text = "";
    addressController.text = "";
    landmarkController.text = "";
    localityController.text = "";
    zipcodeController.text = "";
    cityController.text = "";
    tagController.text = "";
    /*stateController.text = "";
    CountryController.text = "";*/
  }

  @override
  void onProfileProgress(String success) {
    // TODO: implement onProfileProgress
  }

  bool checkAlreadyUsedTag(String tagName) {
    print("tagName");
    print(tagName);
    print("addressList");
    print(addressList);
    if (addressList == null) {
      return false;
    } else {
      bool status = false;
      for (Map address in addressList) {
        if (address["address_tag"].toString().toUpperCase() ==
            tagName.toUpperCase()) {
          status = true;
          break;
        }
      }
      return status;
    }
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
                  _mapSample.goToLocation(address.lat, address.long);
                }));
      },
    );
  }
}

class ProfileRepoSaver extends ProfileModelResponse {
  var context;

  ProfileRepoSaver(this.context);

  void excute() {
    ProfileModel model = new ProfileModel(this);
    model.getUserProfile();
  }

  @override
  void onError(String error) {
    // TODO: implement onError
    Navigator.pop(context, {});
    Toasly.success(context, "Address Saved Successfully",
        duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
  }

  @override
  void onFailure(String failure) {
    // TODO: implement onFailure
    Navigator.pop(context, {});
    Toasly.success(context, "Address Saved Successfully",
        duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
  }

  @override
  void onProfileProgress(String success) {
    // TODO: implement onProfileProgress
    /*  Navigator.pop(context);*/
  }

  @override
  void onSuccess(String success) {
    Navigator.pop(context, {});
    Toasly.success(context, "Address Saved Successfully",
        duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
  }
}

enum REQUEST_TYPE { GET_COUNTRY, GET_STATES, ADD_NEW_ADDRESS }
