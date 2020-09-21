import 'dart:collection';

import 'package:sso_futurescape/presentor/module/sso/unit_building_setup/building_model.dart';
import 'package:sso_futurescape/presentor/module/sso/unit_building_setup/building_view.dart';
import 'package:sso_futurescape/presentor/module/sso/unit_building_setup/building_vizlog_model.dart';

class BuildingPresenter {
  BuildingView _buildingView;

  BuildingModel _buildingModel;

  BuildingVizlogModel _buildingVizlogModel;

  BuildingPresenter(BuildingView buildingView) {
    _buildingView = buildingView;
    _buildingModel = new BuildingModel();
    _buildingVizlogModel = new BuildingVizlogModel();
  }

  void memberStatusFoundVizlog(data) {
    try {
      List allMembers = data["data"][0]["member"];
      // print("ssssssssssssss");
      List membres = [];
      //print("sssssssssssssssssssssssssssss");
      print(allMembers);
      for (var member in allMembers) {
        var visitor = member["visitors"];
        var primmary = member["member_type"] == "owner" ? true : false;
        var unitCustomDetails = {
          "is_primary": primmary,
          "member_type_id": member["member_type"] == "owner"
              ? 1
              : member["member_type"] == "family" ? 2 : 3,
//          "user_id": member["visitors"]["code"],
          "member_first_name": visitor["first_name"],
          "member_last_name": visitor["last_name"],
          "member_id": member["member_id"],
          "unit_id": member["unit_id"],
          "approved": member["status"],
          "user_id": member["auth_id"],
          /* "approved": unitStatus["approved"],*/
        };
        membres.add(unitCustomDetails);
        print(membres);
      }
      if (membres != null && membres.length > 0)
        _buildingView.onMemberStatusVizlog(membres);
      else
        _buildingView.onMemberStatusVizlog(null);
    } catch (e) {
      _buildingView.onMemberStatusVizlog(null);
    }
  }


  void getBuildings(String socId) {
    _buildingModel.getBuildings(socId, _buildingView.onBuildingFound,
        _buildingView.onError, _buildingView.onFailure);
  }

  void getMemberType(String socId) {
    _buildingModel.getMemberType(socId, _buildingView.onMemberTypeFound,
        _buildingView.onError, _buildingView.onFailure);
  }

  void memberStatusFound(memberStatusFound) {
    try {
      var memberUnitStatus = memberStatusFound["data"]["members"];
      List unitMemberStatus = [];
      for (var unitStatus in memberUnitStatus) {
//      print("------------------mernierineiefnini-------------------------------");
        var unitCustomDetails = {
          "is_primary": unitStatus["is_primary"],
          "member_type_id": unitStatus["member_type_id"],
          "user_id": unitStatus["user_id"],
          "member_first_name": unitStatus["member_first_name"],
          "member_last_name": unitStatus["member_last_name"],
          "member_id": unitStatus["id"],
          "unit_id": unitStatus["fk_unit_id"],
          "approved": unitStatus["approved"],

        };
        unitMemberStatus.add(unitCustomDetails);
      }
      _buildingView.onMemberStatus(unitMemberStatus);
    } catch (e) {
      _buildingView.onMemberStatus(null);
    }
  }
  void getUnits(String socId, String buildingId, String floorId) {
    _buildingModel.getUnits(
        socId,
        buildingId,
        floorId,
        _buildingView.onUnitFound,
        _buildingView.onError,
        _buildingView.onFailure);
  }

  void getMemberStatus(String socId, String unitId) {
    _buildingModel.getMemberStatus(socId, unitId, memberStatusFound,
        _buildingView.onError, _buildingView.onFailure);
  }

  void getMemberStatusVizLog(String socId, String unitId) {
    _buildingModel.getMemberStatusVizlog(socId, unitId, memberStatusFoundVizlog,
        _buildingView.onError, _buildingView.onFailure);
  }

  void sendUnitRequestChsone(HashMap<String, String> hashMap) {
    _buildingModel.sendUnitRequestChsone(hashMap, _buildingView.onRequestSent,
        _buildingView.onError, _buildingView.onFailure);
  }

  //region Vizlog Api
  void getVizlogBuildings(String socId) {
    _buildingVizlogModel.getBuildings(
        socId,
        _buildingView.onVizlogBuildingFound,
        _buildingView.onError,
        _buildingView.onFailure);
  }

  void getVizlogUnits(String socId, String buildingId, String floorId) {
    floorId;
    _buildingVizlogModel.getUnits(
        socId,
        buildingId,
        floorId,
        _buildingView.onVizlogUnitFound,
        _buildingView.onError,
        _buildingView.onFailure);
  }


  void sendUnitRequestVizlog(String socId, String buildingId, String unitId,
      HashMap<String, String> hashMap) {
    _buildingVizlogModel.sendUnitRequestVizlog(
        socId,
        buildingId,
        unitId,
        hashMap,
        _buildingView.onVizRequestSent,
        _buildingView.onError,
        _buildingView.onFailure);
  }

//endregion
}
