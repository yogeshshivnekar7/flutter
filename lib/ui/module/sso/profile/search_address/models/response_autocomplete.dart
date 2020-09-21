class AutoCompleteResponse {
  String status;
  List<Predictions> predictions;

  AutoCompleteResponse({this.status, this.predictions});

  factory AutoCompleteResponse.fromJson(Map<String, dynamic> json) {
    return AutoCompleteResponse(
        status: json['status'], predictions: parsePredictions(json));
  }

  static List<Predictions> parsePredictions(json) {
    var list = json['predictions'] as List;
    List<Predictions> predictions =
        list.map((prediction) => Predictions.fromJson(prediction)).toList();
    return predictions;
  }
}

class Predictions {
  final String description;
  final String placeId;

  Predictions({this.description, this.placeId});

  factory Predictions.fromJson(prediction) {
    return Predictions(
        description: prediction['description'],
        placeId: prediction['place_id']);
  }
}
