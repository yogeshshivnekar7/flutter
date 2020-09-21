import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/ui/module/sso/profile/search_address/models/address_model.dart';
import 'package:sso_futurescape/ui/module/sso/profile/search_address/models/response_autocomplete.dart';
import 'package:sso_futurescape/ui/module/sso/profile/search_address/models/response_place_details.dart';
import 'package:sso_futurescape/ui/module/sso/profile/search_address/models/response_search.dart';

class LocationHelper {
  static String generatePreview(double latitude, double longitude) {
    return 'https://maps.googleapis.com/maps/api/staticmap?'
        'center=$latitude,$longitude'
        '&zoom=16'
        '&size=600x300'
        '&maptype=roadmap'
        '&markers=color:red%7Clabel:C%7C$latitude,$longitude'
        '&key=${FsString.MAP_API_KEY}';
  }

  static Future<List<Address>> searchPlacesByName(String place) async {
    List<Address> addressList = new List();
    String url =
        'https://maps.googleapis.com/maps/api/place/findplacefromtext/json?'
        'key=${FsString.MAP_API_KEY}'
        '&input=${place.replaceAll(new RegExp(r' '), "%20")}'
        '&inputtype=textquery'
        '&fields=name,geometry,formatted_address';
    print(url);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        //print(response.body);
        var decode = json.decode(response.body) as Map<String, dynamic>;
        var searchResultBody = SearchResultBody.fromJson(decode);
        var candidates = searchResultBody.candidates;
        if (candidates.length > 0) {
          candidates.forEach((data) {
            var location = data.geometry.location;
            print(
                "Name: ${data.name} ==> Location: ${location.lat} ${location.lng}");
            addressList.add(Address(
                address: data.name,
                formattedAddress: data.formattedAddress,
                lat: location.lat,
                long: location.lng));
          });
          /*if (addressList.length > 0) {
            searchPlaceByCoordinates(
                LatLng(addressList[0].lat, addressList[0].long));
          }*/
          return addressList;
        }
        //print(response.body);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      throw (e);
    }
    return addressList;
  }

  static Future<void> searchPlaceByCoordinates(LatLng latLng) async {
    String url = 'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
        'key=${FsString.MAP_API_KEY}'
        '&location=${latLng.latitude},${latLng.longitude}'
        //'&radius=200'
        '&keyword=name'
        '&rankby=distance';
    print(url);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        print(response.body);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print(error);
    }
  }

  static Future<List<Predictions>> placeAutoComplete(String query) async {
    String url = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
        'key=${FsString.MAP_API_KEY}'
        '&input=${query.replaceAll(new RegExp(r' '), "%20")}'
        '&components=country:in';
    print(url);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decode = json.decode(response.body) as Map<String, dynamic>;
        var searchResultBody = AutoCompleteResponse.fromJson(decode);
        return searchResultBody.predictions;
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print(error);
    }
    return [];
  }

  static Future<Address> getPlaceDetails({String placeID}) async {
    String url = 'https://maps.googleapis.com/maps/api/place/details/json?'
        'key=${FsString.MAP_API_KEY}'
        '&place_id=$placeID'
        '&fields=name,formatted_address,geometry';
    print(url);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var decode = json.decode(response.body) as Map<String, dynamic>;
        var placeDetailsResponse = PlaceDetailsResponse.fromJson(decode);
        return Address(
            address: placeDetailsResponse.result.name,
            formattedAddress: placeDetailsResponse.result.formattedAddress,
            lat: placeDetailsResponse.result.geometry.location.lat,
            long: placeDetailsResponse.result.geometry.location.lng);
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print(error);
    }
    return null;
  }
}
