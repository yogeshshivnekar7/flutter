import 'package:sso_futurescape/presentor/module/chsone/receipt/receipt_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/receipt/receipt_view.dart';

class ReceiptPresenter /*extends ReceiptModelResponse*/ {
  ReceiptView _receiptView;
  ReceiptModel _model;

  ReceiptPresenter(ReceiptView receiptView) {
    _model = new ReceiptModel();
    _receiptView = receiptView;
  }

  void getReceipts(String unit_id,
      {String per_page, String page, String is_pagination}) {
    print(unit_id);
    _model.getReceiptList(_receiptView.onReceiptFound, _receiptView.onError,
        _receiptView.onFailure, unit_id,
        page: page, is_pagination: is_pagination, per_page: per_page);
  }
}
