import 'dart:ui';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_presenter.dart';
import 'package:sso_futurescape/presentor/module/online_order/online_order_view.dart';
import 'package:sso_futurescape/ui/module/orders/grocery_order-summary.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/sso/profile/add_new_address.dart';
import 'package:sso_futurescape/ui/module/sso/profile/address_list_widget.dart';
import 'package:sso_futurescape/ui/module/sso/profile/manage_address.dart';
import 'package:sso_futurescape/ui/module/sso/profile/select_current_location.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';

class GroceryBuyAnything extends StatefulWidget {
  var storeDetails;

  var businessAppMode;

  GroceryBuyAnything(this.storeDetails, this.businessAppMode);

  @override
  _GroceryBuyAnythingState createState() =>
      new _GroceryBuyAnythingState(storeDetails, businessAppMode);
}

class _GroceryBuyAnythingState extends State<GroceryBuyAnything>
    implements OnlineOrderView {
  TextEditingController userNameController = new TextEditingController();

  var storeDetails;

  var _userProfie;

  var addresses;

  var businessAppMode;

  var selectedAddress;

  OnlineOrderPresenter onlineOrderPresenter;

  List items = [

  ];

  var itemController = new TextEditingController();

  bool isLoading = false;

  String itemError = null;

  var deliveryRange;

  _GroceryBuyAnythingState(this.storeDetails, this.businessAppMode) {
    onlineOrderPresenter = new OnlineOrderPresenter(this);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("storeDetaills -------- $storeDetails");
    getProfile();
    getDeliveryRange();
//    companyApiCall();

  }


  void getDistance(List data) {
    for (int i = 0; data != null && i < data.length; i++) {
      if (data[i]["key"] == "GLOABL_DELIVERY_RANGE_DELIEVRY") {
        deliveryRange = data[i]["value"];
        break;
      }
    }
    setState(() {

    });
  }
  @override
  void dispose() {
    super.dispose();
  }

  void getProfile() {
    SsoStorage.getPreferredAddress().then((address1) {
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        addresses = _userProfie["addresses"];
        print("_userProfie_userProfie - $onValue");
        print("address1address1address1address1 - $address1");
        addresses = addresses
            .where((element) =>
        element["latitude"] != null && element["latitude"] != "null")
            .toList();
        if (address1 != null && address1["id"] != null && address1["id"]
            .toString()
            .length > 0) {
          setAddress(address1);
        } else {
          if (addresses != null) {
            if (addresses.length > 0) {
              setAddress(addresses[0]);
            }
          }
        }
        /*if (address1 == null) {
          if (addresses != null) {
            if (addresses.length > 0) {
              setAddress(addresses[0]);
            }
          }
//          hasAtLeastOneAddress();
        } else {
          if(addresses != null){
            setAddress(address1);
          }


        }*/
      });
    });
  }

  Map address;

  void setAddress(address1) {
    print("prfffered adresss ------------ $address1");
//    SsoStorage.setPreferredAddress(address1);

    address = address1;
    if (address != null) {
      selectedAddress = {

        "tag": address["address_tag"] != null &&
            address["address_tag"].length > 0
            ? address["address_tag"]
            : "others",
        "full_address": ManageAddress.getFullAddressWithoutLine(address),
        "latitude": address["latitude"],
        "longitude": address["longitude"],
      };
    }
    setState(() {

    });
  }

  void locationModalBottomSheet(context, {cancelable = true}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        isDismissible: cancelable ? false : true,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.75,
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Location',
                        style: TextStyle(
                          fontSize: FSTextStyle.h5size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.darkgrey,
                        ),
                      ),
                      address == null
                          ? Container(
                        width: 50,
                        height: 40,
                      )
                          : Container(
                        width: 50,
                        child: FlatButton(
                            onPressed: () {
                              if (cancelable == false &&
                                  address == null) {
                                Toasly.warning(
                                    context, "add at least one address");
                              } else {
                                Navigator.pop(context);
                              }
                            },
                            child: Icon(
                              FlutterIcon.cancel_1,
                              size: FSTextStyle.h6size,
                              color: FsColor.basicprimary,
                            )),
                      ),
                    ],
                  ),
                ),
                /* Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: FsColor.lightgrey.withOpacity(0.2)),
                        )),
                    // margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    height: 40,
                    child: FlatButton(
                      onPressed: () {
                        selectCurrentLocation(context, isPop: true);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.my_location,
                            size: FSTextStyle.h4size,
                            color: FsColor.primaryvisitor,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Use Current Location'.toLowerCase(),
                            style: TextStyle(
                                fontFamily: 'Gilroy-SemiBold',
                                fontSize: FSTextStyle.h5size,
                                color: FsColor.primaryvisitor),
                          ),
                        ],
                      ),
                    )),*/
                Container(
                    decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: FsColor.lightgrey.withOpacity(0.2)),
                        )),
                    // margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                    height: 40,
                    child: FlatButton(
                      onPressed: () {
                        addAddress(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            size: FSTextStyle.h3size,
                            color: FsColor.primaryvisitor,
                          ),
                          SizedBox(width: 15),
                          Text(
                            'add address'.toLowerCase(),
                            style: TextStyle(
                                fontFamily: 'Gilroy-SemiBold',
                                fontSize: FSTextStyle.h5size,
                                color: FsColor.primaryvisitor),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            AddresList(
                              null, _userProfie,
                              onAddressClick: (address1) {
//                    isLoading = true;
                                setState(() {
                                  setAddress(address1);
                                });
                                Navigator.pop(context);
                              },
//                      noAddressText:
//                      "add address to search ${getTypeNameFound()} you"
                            ),
                          ],
                        )))
              ],
            ),
          );
        });
  }

  /*void locationModalBottomSheet(context, {cancelable = true}) {
    print("sdsnonfono");
    showModalBottomSheet(
        context: context,
        isDismissible: cancelable ? false : true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(15, 0, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Location',
                          style: TextStyle(
                            fontSize: FSTextStyle.h5size,
                            fontFamily: 'Gilroy-SemiBold',
                            color: FsColor.darkgrey,
                          ),
                        ),
                        address == null
                            ? Container(
                          width: 50,
                          height: 40,
                        )
                            : Container(
                          width: 50,
                          child: FlatButton(
                              onPressed: () {
                                if (cancelable == false && address == null) {
                                  Toasly.warning(
                                      context, "add at least one address");
                                } else {
                                  Navigator.pop(context);
                                }
                              },
                              child: Icon(
                                FlutterIcon.cancel_1,
                                size: FSTextStyle.h6size,
                                color: FsColor.basicprimary,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                      height: 40,
                      child: FlatButton(
                        onPressed: () {
                          selectCurrentLocation(context, isPop: true);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.my_location,
                              size: FSTextStyle.h4size,
                              color: FsColor.primaryvisitor,
                            ),
                            SizedBox(width: 15),
                            Text(
                              'Use Current Location'.toLowerCase(),
                              style: TextStyle(
                                  fontFamily: 'Gilroy-SemiBold',
                                  fontSize: FSTextStyle.h5size,
                                  color: FsColor.primaryvisitor),
                            ),
                          ],
                        ),
                      )),
                  AddresList(
                    addresses, _userProfie, onAddressClick: (address1) {
//                    isLoading = true;
                    setState(() {
                      setAddress(address1);
                    });
                    Navigator.pop(context);
                  },
//                      noAddressText:
//                      "add address to search ${getTypeNameFound()} you"
                  ),
                ],
              ));
        });
  }*/

  Future<void> selectCurrentLocation(BuildContext context,
      {bool isPop = true}) async {
    var location = new Location();
    var hasPer = await location.hasPermission();
    if (hasPer == PermissionStatus.denied ||
        hasPer == PermissionStatus.deniedForever) {
      Toasly.error(context,
          "Location permission is denied for forever \n Please enable location from settings!");
      /* print("hasPer");
      print(hasPer);*/
      if (hasPer == PermissionStatus.denied) {}
//      isLoading = false;
      setState(() {});
      if (hasPer == PermissionStatus.deniedForever) {
        if (isPop) {
          //  Toasly.error(context, "Location permission is denied forever \n Please enable location from settings!");
        }
        return;
      }
      var reqPer = await location.requestPermission();
      if (reqPer == PermissionStatus.granted) {
        bool a = await location.serviceEnabled();
        if (!a) {
//          isLoading = false;
          setState(() {});
          bool b = await location.requestService();
          print("Permission for Location");
          print(b);
          if (b) {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      SelectCurrentLocation(
                          OnlineOrderWebViewState.backgroundColor(
                              businessAppMode))),
            );
            if (result != null && result.containsKey('selection')) {
              setAddress(result['selection']);
//              isTitleForEnable = false;
//              isTitleForDisable = false;
              setState(() {});
              if (isPop) {
                Navigator.pop(context);
              }
//              isTitleForEnable = false;
//              isTitleForDisable = false;
//              getRestoList();

/*
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
          }
          }
      });
*/
            } else {
//              isTitleForEnable = false;
//              isTitleForDisable = false;
//              isLoading = false;
              setState(() {});
            }
          } else {
//            isLoading = false;
            setState(() {});
          }
        } else {
          var result = await Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SelectCurrentLocation(
                        OnlineOrderWebViewState.backgroundColor(
                            businessAppMode))),
          );
          if (result != null && result.containsKey('selection')) {
            setAddress(result['selection']);
//            isTitleForEnable = false;
//            isTitleForDisable = false;
            setState(() {});
            if (isPop) {
              Navigator.pop(context);
            }
//            isTitleForEnable = false;
//            isTitleForDisable = false;
//            getRestoList();

/*
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
          }
          }
      });
*/
          } else {
//            isTitleForEnable = false;
//            isTitleForDisable = false;
//            isLoading = false;
            setState(() {});
          }
        }
      }
      return;
    }
    bool a = await location.serviceEnabled();
    if (!a) {
//      isLoading = false;
      setState(() {});
      bool b = await location.requestService();
      print("Permission for Location");
      print(b);
      if (b) {
        var result = await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SelectCurrentLocation(
                      OnlineOrderWebViewState.backgroundColor(
                          businessAppMode))),
        );
        if (result != null && result.containsKey('selection')) {
          setAddress(result['selection']);
//          isTitleForEnable = false;
//          isTitleForDisable = false;
          setState(() {});
          if (isPop) {
            Navigator.pop(context);
          }
//          isTitleForEnable = false;
//          isTitleForDisable = false;
//          getRestoList();

/*
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
          }
          }
      });
*/
        } else {
//          isTitleForEnable = false;
//          isTitleForDisable = false;
//          isLoading = false;
          setState(() {});
        }
      } else {
//        isLoading = false;
        setState(() {});
      }
    } else {
      var result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                SelectCurrentLocation(
                    OnlineOrderWebViewState.backgroundColor(businessAppMode))),
      );
      if (result != null && result.containsKey('selection')) {
        setAddress(result['selection']);
//        isTitleForEnable = false;
//        isTitleForDisable = false;
        setState(() {});
        if (isPop) {
          Navigator.pop(context);
        }
//        isTitleForEnable = false;
//        isTitleForDisable = false;
//        getRestoList();

/*
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
          }
          }
      });
*/
      } else {
//        isTitleForEnable = false;
//        isTitleForDisable = false;
//        isLoading = false;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        backgroundColor: FsColor.primarygrocery,
        elevation: 0.0,
        title: new Text(
          'Buy anything'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              _howitworksModalBottomSheet(context);
            },
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Text('How it Works ?',
              style: TextStyle(fontSize: FSTextStyle.h6size,
                  color: FsColor.white, fontFamily: 'Gilroy-SemiBold'),
            ),
          ),
          SizedBox(width: 5),
        ],
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            children: <Widget>[
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    border: Border.all(
                      width: 1.0,
                      color: FsColor.lightgrey,
                    )),
                margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child:
                      /*Image.network(
                      "https://scx1.b-cdn.net/csz/news/800/2017/thegrocerant.jpg",
                      height: 76,
                      width: 76,
                      fit: BoxFit.cover,
                    )*/
                      storeDetails["image"] == null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          storeDetails["default_image"],
                          height: 48,
                          width: 48,
                          fit: BoxFit.cover,
                        ),
                      )
                          : FadeInImage(
                          image: NetworkImage(
                              storeDetails["image"]),
                          placeholder: AssetImage(
                            storeDetails["default_image"],),
                          height: 48,
                          width: 48,
                          fit: BoxFit.cover),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    child: Text(
                                      storeDetails["company_name"],
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h5size,
                                          color: FsColor.basicprimary,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    )),
                                /*Container(
                                  height: 24,
                                  child: FlatButton(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Text(
                                      'Change',
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h7size,
                                          color: FsColor.primarygrocery,
                                          fontFamily: 'Gilroy-SemiBold'),
                                    ),
                                    onPressed: () {

                                    },
                                  ),
                                ),*/
                              ],
                            ),
                          ),
                          SizedBox(height: 3),
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              storeDetails["address"]
                                  .toLowerCase(),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: FSTextStyle.h7size,
                                  color: FsColor.lightgrey,
                                  fontFamily: 'Gilroy-SemiBold'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              addressWidget(addressTag: false),
              Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Make a list of items'.toLowerCase(),
                    style: TextStyle(
                        fontSize: FSTextStyle.h5size,
                        color: FsColor.basicprimary,
                        fontFamily: 'Gilroy-SemiBold'),
                  )),

              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 10),

                child: SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 230.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          height: 60,
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),

                          child: TextField(
                            controller: itemController,
                            maxLines: 1,
                            style: TextStyle(fontSize: FSTextStyle.h6size,
                                color: FsColor.basicprimary,
                                fontFamily: 'Gilroy-Regular'),
                            decoration: InputDecoration(
                              errorText: itemError,
                              hintText: "Add items".toLowerCase(),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: FsColor.primarygrocery)),
                              suffix: Container(
                                width: 30, height: 30,
                                alignment: Alignment.center,
                                child: RaisedButton(
                                  padding: EdgeInsets.all(0),
                                  color: FsColor.primarygrocery,
                                  onPressed: () {
                                    itemAdd();
                                  },
                                  child: Icon(
                                    FlutterIcon.plus, color: FsColor.white,
                                    size: FSTextStyle.h6size,),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        ListView.builder(
                          primary: false,
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: items == null
                              ? 0
                              : items.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map place = items[index];
                            return Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        width: 1.0,
                                        color: FsColor.lightgrey.withOpacity(
                                            0.5),
                                      ))),
                              child: Container(
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        child: ListView(
                                          primary: false,
                                          physics:
                                          NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          children: <Widget>[
                                            Container(
                                                alignment:
                                                Alignment.centerLeft,
                                                child: Text(
                                                  '${place["item"]}',
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'Gilroy-SemiBold',
                                                    fontSize:
                                                    FSTextStyle.h6size,
                                                    color: FsColor.darkgrey,
                                                  ),
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            height: 24,
                                            width: 24,
                                            child: FlatButton(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Icon(FlutterIcon.minus,
                                                  color:
                                                  FsColor.primarygrocery,
                                                  size: FSTextStyle.h6size),
                                              onPressed: () {
                                                quantityUpdate(
                                                    place, plus: false);
                                              },
                                            ),
                                          ),
                                          SizedBox(width: 5),
                                          Text(
                                            '${place["quantity"]}',
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                color: FsColor.basicprimary,
                                                fontFamily:
                                                'Gilroy-SemiBold'),
                                          ),
                                          SizedBox(width: 5),
                                          Container(
                                            height: 24,
                                            width: 24,
                                            child: FlatButton(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 0, 0),
                                              child: Icon(FlutterIcon.plus,
                                                  color:
                                                  FsColor.primarygrocery,
                                                  size: FSTextStyle.h6size),
                                              onPressed: () {
                                                quantityUpdate(place);
                                              },
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
//addressWidget(),
              SizedBox(height: 50),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: <Widget>[

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child:
                      isLoading ?
                      SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              FsColor.white),
                          strokeWidth: 3.0,
                        ),
                      ) : Text('Continue Order',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold')),
                      onPressed: () {
                        !isLoading ? proceed() : null;
                      },
                      color: FsColor.primarygrocery,
                      textColor: FsColor.white,
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> addAddress(BuildContext context) async {
    var result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddNewAddress(_userProfie["addresses"])),
    );
    if (result != null) {
      SsoStorage.getUserProfile().then((onValue) {
        _userProfie = onValue;
        if (_userProfie["addresses"] != null) {
          List addresses = _userProfie["addresses"];
          if (addresses.length > 0) {
            address = addresses[addresses.length - 1];
            setAddress(address);
          }
          setState(() {});
//          Navigator.pop(context);
        }
      });
    }
  }

  @override
  error(error, {var callingType}) {
    print("error company-api ---------------- $error");
    if (callingType == "post_order") {
      Toasly.error(context, error.toString());
      isLoading = false;
      setState(() {

      });
    }
  }

  @override
  failure(failed, {var callingType}) {
    print("failed company-api ---------------- $failed");
    if (callingType == "post_order") {
      Toasly.error(context, failed.toString());
      isLoading = false;
      setState(() {

      });
    }
  }

  @override
  success(success, {var callingType}) {
    if (callingType == "post_order") {
      Navigator.of(context).pop();
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) {
            var response = success["data"];
//            SsoStorage.getPastOrderDetails(
//                storeDetails["company_id"].toString()).then((orderDetails) {
//              List orders = [];
//              if (orderDetails != null) {
//                orders = orderDetails;
//              }
//              print("orderDetailspast -------------------------- $orders");
//
//              var orderDetail = {
//                "order_id": response["id"],
//                "order_no": response["order_no"],
//                "status": "requested"
//              };
//              orders.insert(0, orderDetail);
////              SsoStorage.setPastOrderDetails(
////                  storeDetails["company_id"].toString(), orders);
//            });
            storeDetails["order_id"] = response["id"];
            return GroceryOrderSummary(
                _userProfie, storeDetails, businessAppMode);
          },

        ),

      );

//      Toasly.success(context, "successfully added");
      isLoading = false;
      setState(() {

      });
    }
    if (callingType == "delivery_range") {
      getDistance(success["data"]);
    }
    print("success company-api ---------------- $success");

  }

  void proceed() {
    if (isValid()) {
      isLoading = true;

      onlineOrderPresenter.orderContinue(
          items, _userProfie, address, "post_order");
      setState(() {

      });
    }
  }

  void itemAdd() {
    if (itemController.text
        .trim()
        .length <= 0) {
      itemError = "please add item";
    } else if (itemController.text
        .trim()
        .length < 3) {
      itemError = "please insert valid item name";
    } else {
      itemError = null;
      print(itemController.text);
      var item = {
        "item": itemController.text.toString(),
        "quantity": 1
      };
//      items.add(item);
      items.insert(0, item);
      itemController.clear();

    }

    setState(() {

    });
  }

  void quantityUpdate(var place, {bool plus = true}) {
    if (plus) {
      place["quantity"] = place["quantity"] + 1;
    } else {
      if (place["quantity"] > 1) {
        place["quantity"] = place["quantity"] - 1;
      } else {
        items.remove(place);
      }
    }
    setState(() {

    });
  }

  bool isValid() {
    print("selectedAddress -- $selectedAddress");


    if (items.length <= 0) {
      itemError = "please add item";
      setState(() {

      });
//      Toasly.error(context, "please add items");
      return false;
    }
    if (selectedAddress == null) {
      Toasly.error(context, "please select delivery address");
      return false;
    }
    if (!isDeliverableArea()) {
      Toasly.error(context, "out of delivery area");
      return false;
    }

    return true;
  }

  bool isDeliverableArea() {
    double distance = AppUtils.calculateDistance(
        storeDetails["com_latitude"], storeDetails["com_longitude"],
        double.parse(selectedAddress["latitude"].toString()),
        double.parse(selectedAddress["longitude"].toString()));
    print("distance ----------$distance");

    print("deliveryRange ----------$deliveryRange");
    if (deliveryRange != null && distance != null) {
      if (distance > double.parse(deliveryRange)) {
        return false;
      } else {
        return true;
      }
    }
    return false;
  }
  void _howitworksModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
                    padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text('How it Works',
                          style: TextStyle(fontSize: FSTextStyle.h5size,
                            fontFamily: 'Gilroy-SemiBold',
                            color: FsColor.basicprimary,),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    child: Column(
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(width: 1.0,
                                    color: FsColor.lightgrey.withOpacity(0.5),)
                              )
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: FsColor.primarygrocery.withOpacity(
                                        0.2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                  child: Icon(FlutterIcon.list_numbered,
                                    size: FSTextStyle.h4size,
                                    color: FsColor.primarygrocery,)
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Text(
                                    'make a list of items and place an order without any payment',
                                    style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey,),
                                  )
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(width: 1.0,
                                    color: FsColor.lightgrey.withOpacity(0.5),)
                              )
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: FsColor.primarygrocery.withOpacity(
                                        0.2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                  child: Icon(FlutterIcon.list_alt,
                                    size: FSTextStyle.h4size,
                                    color: FsColor.primarygrocery,)
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Text(
                                    'receive an estimated bill for the order',
                                    style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey,),
                                  )
                              ),
                            ],
                          ),
                        ),

                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(width: 1.0,
                                    color: FsColor.lightgrey.withOpacity(0.5),)
                              )
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                  padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: FsColor.primarygrocery.withOpacity(
                                        0.2),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25.0),
                                    ),
                                  ),
                                  child: Icon(
                                    FlutterIcon.money, size: FSTextStyle.h4size,
                                    color: FsColor.primarygrocery,)
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                  child: Text(
                                    'confirm the items and make a payment',
                                    style: TextStyle(
                                      fontSize: FSTextStyle.h6size,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.darkgrey,),
                                  )
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),


                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.0),
                    child: GestureDetector(
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        child: Text('Proceed',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: FsColor.primarygrocery,
                        textColor: FsColor.white,
                      ),
                    ),
                  ),


                ],
              ),
            ),
          );
        }
    );
  }

  void getDeliveryRange() {
    onlineOrderPresenter.getDeliveryRange("delivery_range");
  }

  Widget checkForDelivery() {
    return !isDeliverableArea() ? Column(
      children: <Widget>[
        SizedBox(height: 3),
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            deliveryRange == null ? "Checking for delivery..".toLowerCase() :
            "Out of delivery area".toLowerCase(),
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                fontSize: deliveryRange == null
                    ? FSTextStyle.h6size
                    : FSTextStyle.h4size,
                color: deliveryRange != null ? FsColor.red : FsColor.darkgrey,
                fontFamily: 'Gilroy-SemiBold'),
          ),
        ),
      ],
    ) : Container();
  }

  Widget addressWidget({bool addressTag = true}) {
    return Column(
      children: <Widget>[
        addressTag ? Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              'Address'.toLowerCase(),
              style: TextStyle(
                  fontSize: FSTextStyle.h5size,
                  color: FsColor.basicprimary,
                  fontFamily: 'Gilroy-SemiBold'),
            )) : Container(),
        Container(

          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(4.0),
              ),
              border: Border.all(
                width: 1.0,
                color: FsColor.lightgrey,
              )),
          margin: EdgeInsets.fromLTRB(10, 5, 10, 10),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),

          child: Row(
            children: <Widget>[
              Image.asset(
                "images/location.png",
                height: 36,
                width: 36,
                color: FsColor.basicprimary,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 5),
              address == null ?
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Container(

                      child: FlatButton(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text(
                          'add address',
                          style: TextStyle(
                              fontSize: FSTextStyle.h7size,
                              color: FsColor.primarygrocery,
                              fontFamily: 'Gilroy-SemiBold'),
                        ),
                        onPressed: () {
                          addAddress(context);
                        },
                      ),
                    ),
                  ],
                ),
              ) :
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment
                            .spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              child: Text(
                                selectedAddress["tag"],
                                style: TextStyle(
                                    fontSize: FSTextStyle.h5size,
                                    color: isDeliverableArea() ? FsColor
                                        .basicprimary : FsColor.lightgrey,
                                    fontFamily: 'Gilroy-SemiBold'),
                              )),
                          Container(
                            height: 24,
                            child: FlatButton(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              child: Text(
                                'Change',
                                style: TextStyle(
                                    fontSize: FSTextStyle.h7size,
                                    color: FsColor.primarygrocery,
                                    fontFamily: 'Gilroy-SemiBold'),
                              ),
                              onPressed: () {
                                locationModalBottomSheet(context);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 3),
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(

                        selectedAddress["full_address"].toLowerCase(),
                        maxLines: 1,

                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(

                            fontSize: FSTextStyle.h7size,
                            color: FsColor.lightgrey,
                            fontFamily: 'Gilroy-SemiBold'),
                      ),
                    ),
                    checkForDelivery(),
                  ],
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }
}


