class PlaceDetailsResponse {
  final String status;
  final Result result;

  PlaceDetailsResponse({this.status, this.result});

  factory PlaceDetailsResponse.fromJson(Map<String, dynamic> json) {
    return PlaceDetailsResponse(
        status: json['status'], result: Result.fromJson(json['result']));
  }
}

class Result {
  String name;
  String formattedAddress;
  Geometry geometry;

  Result({this.name, this.formattedAddress, this.geometry});

  factory Result.fromJson(data) {
    return Result(
        name: data['name'],
        formattedAddress: data['formatted_address'],
        geometry: Geometry.fromJson(data['geometry']));
  }
}

class Geometry {
  Location location;

  //Viewport viewport;

  Geometry({this.location});

  factory Geometry.fromJson(Map<String, dynamic> map) {
    return Geometry(location: Location.fromJson(map['location']));
  }
}

class Location {
  double lat;
  double lng;

  Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> map) {
    return Location(lat: map['lat'] as double, lng: map['lng'] as double);
  }
}
