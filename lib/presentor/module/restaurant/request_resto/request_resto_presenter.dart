import 'package:sso_futurescape/presentor/module/restaurant/request_resto/request_resto_model.dart';
import 'package:sso_futurescape/presentor/module/restaurant/request_resto/resto_view.dart';

class RequestRestoPresenter implements RequestRestoModelResponse {
  RequestRestoView requestRestoView;

  RequestRestoModel _model;

  RequestRestoPresenter(RequestRestoView requestRestoView) {
    this.requestRestoView = requestRestoView;
    _model = new RequestRestoModel(this);
  }

  requestResto(String name, String complexName, String contact, String email,
      String pageTitle) {
    print(contact);
    _model.addResto(name, complexName, contact, email, pageTitle);
  }

  void onSuccess(String response) {
    requestRestoView.onSuccess(response);
  }

  @override
  onError(String error) {
    //requestRestoView.hideProgress();
    requestRestoView.onError(error);
  }

  @override
  void onFailure(String error) {
    requestRestoView.onFailure(error);
  }
}
