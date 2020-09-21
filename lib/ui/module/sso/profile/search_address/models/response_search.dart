class SearchResultBody {
  final String status;
  final List<Candidates> candidates;

  SearchResultBody({this.status, this.candidates});

  factory SearchResultBody.fromJson(Map<String, dynamic> json) {
    return SearchResultBody(
        status: json['status'], candidates: parseCandidates(json));
  }

  static List<Candidates> parseCandidates(jsonList) {
    var list = jsonList['candidates'] as List;
    List<Candidates> candidates =
        list.map((data) => Candidates.fromJson(data)).toList();
    return candidates;
  }
}

class Candidates {
  String name;
  String formattedAddress;
  Geometry geometry;

  Candidates({this.name, this.formattedAddress, this.geometry});

  factory Candidates.fromJson(Map<String, dynamic> data) {
    return Candidates(
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

/*class Viewport {
  Location northeast;
  Location southwest;
}*/
