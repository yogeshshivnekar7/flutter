import 'package:sso_futurescape/presentor/module/sso/complex_list/complex_model.dart';
import 'package:sso_futurescape/presentor/module/sso/complex_list/complex_view.dart';

class ComplexPresenter {
  ComplexView _complexView;

  ComplexModel _model;

  ComplexPresenter(ComplexView complexView) {
    _complexView = complexView;
    _model = new ComplexModel();
  }

  searchComplex(String search) {
    _model.searchComplex(search, _complexView.onComplexFound,
        _complexView.onError, _complexView.onFailure, _complexView.clearList);
  }
}
