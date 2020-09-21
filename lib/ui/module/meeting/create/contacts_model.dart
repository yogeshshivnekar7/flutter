import 'dart:collection';
import 'dart:convert';
import 'package:sso_futurescape/ui/module/meeting/base/meeting_base_model.dart';
import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/meeting_api.dart';

class ContactsModel extends MeetingBaseModel {

  void loadContacts(HashMap<String, String> params, var societyId,
      onSuccess, onFailure, onError, callingType) {
    NetworkHandler networkHandler = NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()), societyId, callingType: callingType);
    }, (f) {
      var failure = jsonDecode(f);
      onFailure(errorDecoder(failure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    Network network = MeetingApiHandler.loadContacts(networkHandler, params);
    network.excute();
  }

  void addContact(HashMap<String, String> params, var societyId,
      onSuccess, onFailure, onError, callingType) {
    NetworkHandler networkHandler = NetworkHandler((s) {
      onSuccess(jsonDecode(s.toString()), societyId, callingType: callingType);
    }, (f) {
      var failure = jsonDecode(f);
      onFailure(errorDecoder(failure), callingType: callingType);
    }, (e) {
      onError(e, callingType: callingType);
    });
    Network network = MeetingApiHandler.addContact(networkHandler, params);
    network.excute();
  }
}
