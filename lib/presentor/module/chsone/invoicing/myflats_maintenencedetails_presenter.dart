
import 'package:sso_futurescape/presentor/module/chsone/invoicing/myFlatsMaintenenceDetails_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/invoicing/myFlatsMaintenenceDetails_view.dart';
import 'package:sso_futurescape/ui/module/chsone/maintenence_dues/maintenence_overdue.dart';

class MyFlatsMaintenencedetailsPresnter {
  MyFlatsMaintenenceDetailsView _myFlatsMaintenenceDetailView;

  MyFlatsMaintenencedetailsPresnter(
      MyFlatsMaintenenceDetailsView myFlatsMaintenenceDetailView) {
    _myFlatsMaintenenceDetailView = myFlatsMaintenenceDetailView;
  }

  void getInvoice(String invoiceNumber, BILLTYPE billType, unitId) {
    InvoiceModel _model = new InvoiceModel();
    print("***********************************************");
    print("print in duertype");
    print(unitId);
    print("***********************************************");
    if (billType == BILLTYPE.INCIDENTAL) {
      _model.getIncidentalDetails(
          _myFlatsMaintenenceDetailView.onInvoiceFound,
          _myFlatsMaintenenceDetailView.onError,
          _myFlatsMaintenenceDetailView.onFailure,
          invoiceNumber, unitId);
    } else if (billType == BILLTYPE.MAINTANCE) {
      _model.getInvoiceList(
          _myFlatsMaintenenceDetailView.onInvoiceFound,
          _myFlatsMaintenenceDetailView.onError,
          _myFlatsMaintenenceDetailView.onFailure,
          invoiceNumber, unitId);
    }
  }
}
