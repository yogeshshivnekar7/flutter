import 'package:sso_futurescape/presentor/module/chsone/request_complex/complex_view.dart';
import 'package:sso_futurescape/presentor/module/chsone/request_complex/request_complex_model.dart';

class RequestComplexPresenter implements RequestComplexModelResponse {
  RequestComplexView requestcomplexView;

  RequestComplexModel _model;

  RequestComplexPresenter(RequestComplexView requestcomplexView) {
    this.requestcomplexView = requestcomplexView;
    _model = new RequestComplexModel(this);
  }

  requestComplex(String name, String complexName, String contact) {
    _model.addComplexRequest(name, complexName, contact);
  }

  void onSuccess(String response) {
    requestcomplexView.onSuccess(response);
  }

  @override
  onError(String error) {
    //requestcomplexView.hideProgress();
    requestcomplexView.onError(error);
  }

  @override
  void onFailure(String error) {
    requestcomplexView.onFailure(error);
  }
}
