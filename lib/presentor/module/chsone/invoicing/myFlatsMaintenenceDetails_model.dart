import 'dart:convert';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/sso_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class InvoiceModel {
  Future<void> getInvoiceList(onInvoiceFound, onError, onFailure,
      String invoiceNumber, unitId) async {
    print('in getinvoice');
    NetworkHandler a = new NetworkHandler((s) {
      onInvoiceFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    var token = await ChsoneStorage.getAccessToken();
    Network network = SSOAPIHandler.getInvoice(a, token, invoiceNumber, unitId);
    network.excute();
  }

  void getIncidentalDetails(onInvoiceFound, onError, onFailure,
      String invoiceNumber, unitId) async {
    print('in incecntal invoice');
    NetworkHandler a = new NetworkHandler((s) {
      onInvoiceFound(jsonDecode(s.toString()));
    }, (f) {
      var userFalure = jsonDecode(f);
      onFailure(userFalure);
    }, (e) {
      onError(e);
    });
    var token = await ChsoneStorage.getAccessToken();
    Network network = SSOAPIHandler.getIncidentalInvoice(
        a, token, invoiceNumber, unitId);
    network.excute();
  }
}

abstract class InvoiceModelResponse {
  void onSuccess(String success);

  void onLoadingStart();

  void onFailure(String failure);

  void onError(String error);
}
