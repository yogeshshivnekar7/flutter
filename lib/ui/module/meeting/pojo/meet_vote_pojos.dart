
class ApiData {
  dynamic _data;
  dynamic _metadata;
  Map _extras;
  bool _errorInDataLoad;
  String _dataLoadMsg;

  ApiData();

  String get dataLoadMsg => _dataLoadMsg;

  set dataLoadMsg(String value) {
    _dataLoadMsg = value;
  }

  bool get errorInDataLoad => _errorInDataLoad;

  set errorInDataLoad(bool value) {
    _errorInDataLoad = value;
  }

  Map get extras => _extras;

  set extras(Map value) {
    _extras = value;
  }

  dynamic get metadata => _metadata;

  set metadata(dynamic value) {
    _metadata = value;
  }

  dynamic get data => _data;

  set data(dynamic value) {
    _data = value;
  }
}

class StepData {

  dynamic _data;
  bool _dataError;
  String _errorMsg;

  dynamic get data => _data;

  set data(dynamic value) {
    _data = value;
  }

  bool get dataError => _dataError;

  set dataError(bool value) {
    _dataError = value;
  }

  String get errorMsg => _errorMsg;

  set errorMsg(String value) {
    _errorMsg = value;
  }
}