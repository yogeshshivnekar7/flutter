import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';

class GroceryList extends VezaShopList /*StatefulWidget*/ {
  var type;

  /*@override
  _GroceryListState createState() => new _GroceryListState(type: type);

  */
  GroceryList({this.type, businessAppMode})
      :super(businessAppMode: businessAppMode);
}

/*class _GroceryListState extends State<GroceryList>
    implements PageLoadListener, RestaurantView {
  String type;


  _GroceryListState({this.type});

  FsListState listListner;
  final TextEditingController _searchControl = new TextEditingController();
  RestaurantPresenter _restaurantPresenter;
  List groceryShopList;
  bool isLoading = true;
  var _userProfie;

  @override
  void initState() {
    // TODO: implement initState
    SsoStorage.getUserProfile().then((onValue) => _userProfie = onValue);
    _restaurantPresenter = new RestaurantPresenter(this);
    _restaurantPresenter.getGrocery();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text(
          'Grocery'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 1.0,
        backgroundColor: FsColor.primarygrocery,
        leading: FsBackButtonlight(),
      ),
      body: isLoading
          ? PageLoader()
          : ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Text(
              "search with your pincode or grocery name",
              style: TextStyle(
                fontSize: FSTextStyle.h5size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.darkgrey,
                height: 1.2,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 15.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey[50],
                borderRadius: BorderRadius.all(
                  Radius.circular(5.0),
                ),
              ),
              child: TextField(
                style: TextStyle(
                  fontSize: 15.0,
                  color: FsColor.darkgrey,
                ),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: FsColor.primarygrocery,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  hintText: "e.g: pincode/grocery name",
                  prefixIcon: Icon(
                    Icons.search,
                    color: FsColor.primarygrocery.withOpacity(0.3),
                  ),
                  hintStyle: TextStyle(
                    fontSize: 15.0,
                    color: FsColor.primarygrocery.withOpacity(0.7),
                  ),
                ),
                maxLines: 1,
                controller: _searchControl,
                onChanged: (text) => {searchGroceryShop(text)},
              ),
            ),
          ),
          groceryShopList == null || groceryShopList.isEmpty
              ? FsNoData()
              : Padding(
            padding: EdgeInsets.all(15),
            child: ListView.builder(
              primary: false,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: groceryShopList == null
                  ? 0
                  : groceryShopList.length,
              itemBuilder: (BuildContext context, int index) {
                Map place = groceryShopList[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 15.0),
                  child: InkWell(
                      child: Container(
                        padding: EdgeInsets.only(
                          bottom: 5.0,
                          top: 5.0,
                        ),
                        child: Row(
                          children: <Widget>[
                            getRestoImage(place) == null
                                ? ClipRRect(
                              borderRadius:
                              BorderRadius.circular(5),
                              child: Image.asset(
                                "images/default_grocery.png",
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover,
                              ),
                            )
                                : FadeInImage(
                                image: NetworkImage(
                                    getRestoImage(place)),
                                placeholder: AssetImage(
                                    "images/default_grocery.png"),
                                height: 90,
                                width: 90,
                                fit: BoxFit.cover),
                            */ /*ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.asset(
                                          "${place["img"]}",
                                          height: 48,
                                          width: 48,
                                          fit: BoxFit.cover,
                                        ),
                                      ),*/ /*
                            SizedBox(width: 15),
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
                                      child: RichText(
                                          text: TextSpan(
                                              style:
                                              Theme
                                                  .of(context)
                                                  .textTheme
                                                  .body1,
                                              children: [
                                                TextSpan(
                                                  text:
                                                  "${AppUtils.capitalize(
                                                      getBrandCompanyName(
                                                          place))}",
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'Gilroy-SemiBold',
                                                    fontSize:
                                                    FSTextStyle
                                                        .h6size,
                                                    color:
                                                    FsColor.black,
                                                  ),
                                                ),
                                              ])),
                                    ),
                                    getLocation(place) == null
                                        ? Container()
                                        : Row(
                                      children: <Widget>[
                                        Icon(
                                          Icons.location_on,
                                          size: 13,
                                          color: FsColor
                                              .lightgrey,
                                        ),
                                        SizedBox(width: 2),
                                        Container(
                                          alignment: Alignment
                                              .centerLeft,
                                          child: Text(
                                            "${getLocation(place)}",
                                            style: TextStyle(
                                              fontFamily:
                                              'Gilroy-SemiBold',
                                              fontSize: 13,
                                              color: FsColor
                                                  .lightgrey,
                                            ),
                                            maxLines: 1,
                                            textAlign:
                                            TextAlign
                                                .left,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    place["offer"] == null
                                        ? Container()
                                        : Container(
                                      child: Text(
                                          '${place["offer"]}',
                                          style: TextStyle(
                                              fontSize:
                                              FSTextStyle
                                                  .h6size,
                                              fontFamily:
                                              'Gilroy-SemiBold',
                                              color: FsColor
                                                  .brown)),
                                    ),
                                    SizedBox(height: 2),
                                    place["minorder"] == null
                                        ? Container()
                                        : Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Min Order : '
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize:
                                              FSTextStyle
                                                  .h6size,
                                              fontFamily:
                                              'Gilroy-Regular',
                                              color: FsColor
                                                  .darkgrey),
                                          children: <
                                              TextSpan>[
                                            TextSpan(
                                                text:
                                                '${place["minorder"]}',
                                                style: TextStyle(
                                                    fontSize:
                                                    FSTextStyle
                                                        .h6size,
                                                    fontFamily:
                                                    'Gilroy-Regular',
                                                    color: FsColor
                                                        .darkgrey)),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 2),
                                    place['min_delivery_time'] !=
                                        null
                                        ? Container(
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Delivery Time : '
                                              .toLowerCase(),
                                          style: TextStyle(
                                              fontSize:
                                              FSTextStyle
                                                  .h6size,
                                              fontFamily:
                                              'Gilroy-Regular',
                                              color: FsColor
                                                  .darkgrey),
                                          children: <
                                              TextSpan>[
                                            TextSpan(
                                                text:
                                                '${place['min_delivery_time']}min',
                                                style: TextStyle(
                                                    fontSize:
                                                    FSTextStyle
                                                        .h6size,
                                                    fontFamily:
                                                    'Gilroy-Regular',
                                                    color: FsColor
                                                        .darkgrey)),
                                          ],
                                        ),
                                      ),
                                    )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        if (place['pos_enabled'].toString() !=
                            null ||
                            place['pos_enabled'] == 'yes') {
                          grocery_click(place, context);
                        } else {
                          Toasly.error(context,
                              'Currently not accepting order from CubeOne App portal!');
                        }
                      }
                    */ /*onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return GroceryCategory();
                          },
                        ),
                      );
                    },*/ /*
                  ),
                );
              },
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: Text("request listing now",
                style: TextStyle(
                    fontSize: FSTextStyle.h6size,
                    color: FsColor.lightgrey,
                    fontFamily: 'Gilroy-SemiBold')),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            child: GestureDetector(
              child: RaisedButton(
                child: Text('Click Here',
                    style: TextStyle(
                        fontSize: FSTextStyle.h6size,
                        fontFamily: 'Gilroy-SemiBold')),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(4.0),
                ),
                color: FsColor.primarygrocery,
                textColor: FsColor.white,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            RequestListingPage('Grocery', 'business')
                      */ /*OnlineOrderWebView(
                                  "grocery", "list now", Environment()
                                  .getCurrentConfig()
                                  .account_url)*/ /*
                    ),
                  );
                  //RestaurantsList.list_resto(context);
                },
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(4.0),
                ),
                side: BorderSide(
                    color: FsColor.lightgrey.withOpacity(0.2),
                    width: 1.0),
              ),
              elevation: 0.0,
              child: Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: Text("to recommend a shop",
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.lightgrey,
                            fontFamily: 'Gilroy-SemiBold'))
                    ),
                    GestureDetector(
                      child: RaisedButton(
                        child: Text('Click Now',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        color: FsColor.primarygrocery,
                        textColor: FsColor.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    RequestListingPage(
                                        'Grocery', 'favourite place')),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getLocation(Map place) {
    if (place['city'] != null && place['state'] != null) {
      return place['city'] + "," + place['state'];
    } else {
      return null;
    }
  }

*/ /* http://subscription.vezaone.com*/ /*

  void grocery_click(Map place, BuildContext context) {
    SsoStorage.getUserProfile().then((profile) {
      var resto_any_details = place['company_id'].toString();
      var userName = profile['username'];
      var sessionToken = profile['session_token'];
      var url2;

      if (type == null) {
        String con = Environment()
            .getCurrentConfig()
            .vezaPlugInUrl;
        url2 = con +
            "vz-main?session_token=$sessionToken&username=$userName&companyId=$resto_any_details&source=cubeone";
      } else if (type == "daily") {
        String con = Environment()
            .getCurrentConfig()
            .subscriptionPlugInUrl;

        url2 = con +
            "vz-main?session_token=$sessionToken&username=$userName&companyId=$resto_any_details&source=cubeone";
      }

      try {
        if ((Platform.isAndroid != null && Platform.isAndroid) ||
            (Platform.isIOS != null && Platform.isIOS)) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                print(Platform.isAndroid);
                return OnlineOrderWebView(
                    'grocery', getBrandCompanyName(place), url2);
              },
            ),
          );
        } else {
          print("1");
          // html.window.open(url2, "Resto");
        }
      } catch (e) {
        print("2");
      }
    });
  }

  @override
  lastPage(int page) {
    // TODO: implement lastPage
  }

  String getBrandCompanyName(Map place) {
    print(place);
    String company_name;
    if (place['brand_name'] == null || place['brand_name']
        .toString()
        .isEmpty) {
      company_name = place['company_name'];
    } else {
      company_name = place['brand_name'];
    }
    print(company_name);
    return company_name;
  }

  String getRestoImage(Map place) {
    if (place == null || place['details'] == null) {
      return null;
    } else {
      List list = place['details'];
      if (list != null && list.length > 0) {
        for (int i = 0; i < list.length; i++) {
          if (list[i]['company_key'] == 'Restaurant_Logo_Url') {
            return list[i]['company_value'];
          }
        }
      } else {
        return null;
      }
    }
  }

  @override
  loadNextPage(String page) {
    // TODO: implement loadNextPage
  }

  @override
  clearList() {
    if (groceryShopList != null) groceryShopList.clear();
    // TODO: implement clearList
  }

  @override
  onError(error) {
    Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => ErrorNoInternetPage()),
    );
    print(error);
    Toasly.error(context, AppUtils.errorDecoder(error));
  }

  @override
  onFailure(failure) {
    print(failure);
    Toasly.error(context, AppUtils.errorDecoder(failure));
    setState(() {
      isLoading = false;
      if (groceryShopList != null) {
        groceryShopList.clear();
      }
    });
  }

  @override
  onRestaurantFound(groceryShopList1, {bool isLastRequest}) {
    print('----------------Grocery-------------------');
    print(groceryShopList1);
    setState(() {
      groceryShopList = groceryShopList1["data"] */ /*["results"]*/ /*;
      isLoading = false;
      print(groceryShopList);
    });
  }

  searchGroceryShop(String text) {
    Logger.log("Change Text --" + text);
    _restaurantPresenter.getGrocery(search: text);
  }

  @override
  onRestaurantURLFound(restaurant, {String company_name}) {
    // TODO: implement onRestaurantURLFound
    return null;
  }

  @override
  void addressDeleted(success) {
    // TODO: implement addressDeleted
  }

  @override
  void addressDeletionFailed(failed) {
    // TODO: implement addressDeletionFailed
  }
}
}*/
