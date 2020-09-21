import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';

class MapSample extends StatefulWidget {
  var locationFound;
  var locationLoading;
  var long = 72.99283381551504;
  var lat = 19.067723278569392;
  Function gotoFuction;

  MapSample({this.gotoFuction,
    this.lat,
    this.long,
    this.locationFound,
    this.locationLoading});

  @override
  State<MapSample> createState() =>
      MapSampleState(
          this.gotoFuction, lat, long, this.locationFound,
          this.locationLoading);

  static Future<void> openMap(String latitude, String longitude) async {
    print("googleUrl2222");
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=${latitude
        .toString()},${longitude.toString()}';
    print("googleUrl");
    print(googleUrl);
    if (await AppUtils.canLaunchUrl(googleUrl)) {
      await AppUtils.launchUrl(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  static var lat = 19.067723278569392;
  static var long = 72.99283381551504;
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lat, long),
  );

  /* static final CameraPosition _kLake =
      CameraPosition(target: LatLng(19.0760, 72.8777), zoom: 18);*/
  //https://maps.googleapis.com/maps/api/place/nearbysearch/json?type=restaurant,locality&location=19.0760,73.000&radius=1500&key=AIzaSyDF3rUNxePYbKOO1sOS4MfhcZFRDyeaPo0
  Set<Marker> makerss = new Set();

  Function _gotoFuntion;

  MapSampleState(this._gotoFuntion, lat, long, this.locationFound,
      this.locationLoading) {
    if (_gotoFuntion != null) {
      this._gotoFuntion(this);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goToLocation(lat, long);
    _goToTheLake();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: Stack(
        children: <Widget>[
          GoogleMap(
            markers: makerss,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomGesturesEnabled: true,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            initialCameraPosition: _kGooglePlex,
            onTap: (lat) {},
            onCameraMove: _cameraMove,
            onCameraIdle: _cameraMoveIdel,
            onCameraMoveStarted: _cameraMoveStarted,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Center(
            /*child: Container(*/
            /* child: Center(*/
            /*child: SizedBox(

                height: 10,
                width: 10,*/
            child: Icon(
              FlutterIcon.location_1,
              color: FsColor.basicprimary,
              size: FSTextStyle.h1size,
            ),
            /*decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 1,
                        ))*/
          ),
          /*  ),*/
          /*  ),*/
          /*  height: 80,
              width: 80,*/
          /*decoration: BoxDecoration(
                  border: Border.all(
                width: 1,
              ))*/
          /*  ),*/
          /*  ),*/
          Positioned(
            bottom: 0,
            right: 0,
            child: GestureDetector(
                onTap: _goToTheLake,
                child: Container(
                  child: Icon(
                    Icons.my_location,
                    size: FSTextStyle.h2size,
                    color: FsColor.black.withOpacity(0.7),
                  ),
                  margin: EdgeInsets.fromLTRB(0, 0, 10, 30),
                  color: FsColor.white,
                  height: 35,
                  width: 35,
                  /*decoration: BoxDecoration(
                border: Border.all(
              width: 1,
            )),*/
                )),
          )
        ],
      ),
      /*floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),*/
    );
  }

  Future<void> _goToTheLake() async {
    var location = new Location();
    var a = await location.requestService();
    if (a) {
      location.getLocation().then((currentLocation) async {
        try {
          await goToLocation(
              currentLocation.latitude, currentLocation.longitude);
        } catch (e) {
          print(e);
        }
      });
    } else {}
  }

  Future goToLocation(double latitude, double longitude) async {
    print(latitude);
    print(longitude);
    final GoogleMapController controller = await _controller.future;
    var _kLake = CameraPosition(target: LatLng(latitude, longitude), zoom: 18);
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  Timer _timer = null;
  CameraPosition positionT;

  void _cameraMoveStarted() {
    print("_cameraMoveStarted");
    locationLoading(true);
  }

  void _cameraMoveIdel() {
    print("_cameraMoveIdel");
    _getLocation(positionT.target);
    /* print("position");
    print(position);
    const Duration oneSec = const Duration(seconds: 1);
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = new Timer(oneSec, () {
      if (position.target == positionT.target) {
        print("FFFFFFFFFFFFFFFFFFFFFFFFFFF");
        print(position);
        _getLocation(position.target);
      }
    });
    positionT = position;*/
  }

  void _cameraMove(CameraPosition position) {
    print("position");
    print(position);
    positionT = position;

    /* const Duration oneSec = const Duration(seconds: 1);
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = new Timer(oneSec, () {
      if (position.target == positionT.target) {
        print("FFFFFFFFFFFFFFFFFFFFFFFFFFF");
        print(position);
       // _getLocation(position.target);
      }
    });*/
  }

  void _getLocation(LatLng lat) {
    NetworkHandler _networkHandler = new NetworkHandler((success) {
      try {
        List result = jsonDecode(success)["results"];
        print(result);
        print(locationFound);
        locationFound(result, lat.latitude, lat.longitude);
      } catch (e) {
        print("derewrererr");
        print(e);
      }
    }, (success) {}, (success) {});
    Network network = new Network(_networkHandler);
    String latLog = "${lat.latitude},${lat.longitude}";

    network.getRequest(
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latLog&sensor=false&key=AIzaSyDF3rUNxePYbKOO1sOS4MfhcZFRDyeaPo0");
    network.excute();
  }

  var locationFound;
  var locationLoading;
}
