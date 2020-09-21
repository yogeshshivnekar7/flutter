import 'package:sso_futurescape/model/vizlog/vizlog.dart';
import 'package:sso_futurescape/ui/module/sso/dashboard/society_card.dart';
import 'package:sso_futurescape/utils/app_constant.dart';

class SwitchComplexPresentor {
  IUnitsDetails _iUnitsDetails;

  List _chsonUnitList;

  List _vizLogUnitList;

  void getAllChsoneUnits(IUnitsDetails _switchComplexView) {
    ChsoneModel model = new ChsoneModel();
    model.getAllComplexUnits(_switchComplexView.unitSuccess,
        _switchComplexView.unitFailed, _switchComplexView.unitError);
  }

  void getAllVizlogUnits(IUnitsDetails _switchComplexView) {
    VizLogModel model = new VizLogModel();
    model.getAllComplexUnits(_switchComplexView.unitSuccess,
        _switchComplexView.unitFailed, _switchComplexView.unitError);
  }

  void getCombineUnits(IUnitsDetails iUnitsDetails) {
    _iUnitsDetails = iUnitsDetails;
    vizLogCall = false;
    ChsoneModel model = new ChsoneModel();
    model.getAllComplexUnits(chsoneUnit, unitFailed, unitError);
  }

  bool vizLogCall;

  chsoneUnit(List data) {
    print(
        "---------------------chsoneUnits-------------------------------$data");
    _chsonUnitList = data;
    vizLogCall = true;
    callVizlog();
  }

  void callVizlog() {
    VizLogModel model = new VizLogModel();
    model.getAllComplexUnits(vizlogSuccess, unitFailed, unitError);
  }

  unitFailed(var data) {
    print("unitFailedunitFailedunitFailed");
    if (!vizLogCall) {
      vizLogCall = true;
      callVizlog();
    } else {
      _iUnitsDetails.unitFailed(data);
    }
  }

  unitError(var data) {
    print("unitErrorunitErrorunitError");
    if (!vizLogCall) {
      vizLogCall = true;
      callVizlog();
    } else {
      _iUnitsDetails.unitError(data);
    }
  }

  vizlogSuccess(List data) {
    _vizLogUnitList = data;
    print(
        "---------------------vizlogSuccess-------------------------------$data");
    if (_chsonUnitList == null || _chsonUnitList.length <= 0) {
      print(
          "---------------------vizlogSuccess-----------------------sdsdasd");
      _iUnitsDetails.unitSuccess(_vizLogUnitList, from: AppConstant.VIZLOG);
    } else {
      _iUnitsDetails.unitSuccess(_chsonUnitList, from: AppConstant.CHSONE);
    }
  }
}

abstract class IUnitsDetails {
  void unitSuccess(var data, {String from});

  void unitFailed(var data);

  void unitError(var data);
}
