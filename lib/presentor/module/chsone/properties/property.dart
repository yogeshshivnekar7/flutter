import 'dart:collection';

import 'package:sso_futurescape/utils/network/api_handler.dart';
import 'package:sso_futurescape/utils/network/chsone_api.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class MyPropertyPresenter {
  MyPropertyView myPropertyView;

  MyPropertyPresenter(this.myPropertyView);

  void getmySocietyProperty() {
    SocietyProperty model = new SocietyProperty();
    print("getmySocietyProperty");
    model.getProperties(
        myPropertyView.onSuccessProperies, myPropertyView.onFailedProperties);
  }

  void acceptMemberRequest(
    currentUnit,
    int memberId,
  ) {
    SocietyProperty model = new SocietyProperty();
    print("acceptMemberRequest");
    model.acceptMemberRequest(
        currentUnit,
        memberId,
        myPropertyView.onActionSuccessProperies,
        myPropertyView.onActionFailedProperties);
  }

  void rejectMemberRequest(
    currentUnit,
    int memberId,
  ) {
    SocietyProperty model = new SocietyProperty();
    print("rejectMemberRequest");
    model.rejectMemberRequest(
        currentUnit,
        memberId,
        myPropertyView.onActionSuccessProperies,
        myPropertyView.onActionFailedProperties);
  }

  void deactivateMember(
    currentUnit,
    int memberId,
  ) {
    SocietyProperty model = new SocietyProperty();
    print("deactivateMember");
    model.deactivateMember(
        currentUnit,
        memberId,
        myPropertyView.onActionSuccessProperies,
        myPropertyView.onActionFailedProperties);
  }
}

class SocietyProperty {
  void getProperties(onSuccessProperies, onFailedProperties) {
    /*   String url = AppConstants.APP_URL + AppConstants.GET_MY_PROPERTIES_URL;
        Map<String, String> getMyPropertiesParams = new HashMap<String, String>();*/
    /*  print(token);*/
    ChsoneStorage.getAccessToken().then((token) {
      print(token);
      HashMap<String, String> hashTable = new HashMap();
      hashTable["token"] = token;

      NetworkHandler networkHandler = new NetworkHandler(
          onSuccessProperies, onFailedProperties, onFailedProperties);
      var properties =
          CHSONEAPIHandler.getProperties(networkHandler, hashTable);
      properties.excuteRequest();
    });
  }

  void acceptMemberRequest(currentUnit, memberId, onActionSuccessProperies,
      onActionFailedProperties) {
    /*   String url = AppConstants.APP_URL + AppConstants.GET_MY_PROPERTIES_URL;
        Map<String, String> getMyPropertiesParams = new HashMap<String, String>();*/
    /*  print(token);*/
    ChsoneStorage.getAccessToken().then((token) {
      print(token);
      HashMap<String, String> hashTable = new HashMap();
      hashTable["token"] = token;
      hashTable["member_id"] = memberId.toString();
      hashTable["unit_id"] = currentUnit['unit_id'];
      hashTable["soc_id"] = currentUnit['soc_id'];
      NetworkHandler netwrkHandler = new NetworkHandler(
          (response) => onActionSuccessProperies(response),
          (response) => onActionFailedProperties(response),
          (response) => onActionFailedProperties(response));

      Network networkt =
          CHSONEAPIHandler.acceptMemberRequest(netwrkHandler, hashTable);
      networkt.excute();
    });
  }

  void rejectMemberRequest(currentUnit, memberId, onActionSuccessProperies,
      onActionFailedProperties) {
    /*   String url = AppConstants.APP_URL + AppConstants.GET_MY_PROPERTIES_URL;
        Map<String, String> getMyPropertiesParams = new HashMap<String, String>();*/
    /*  print(token);*/
    ChsoneStorage.getAccessToken().then((token) {
      print(token);
      HashMap<String, String> hashTable = new HashMap();
      hashTable["token"] = token;
      hashTable["member_id"] = memberId.toString();
      hashTable["unit_id"] = currentUnit['unit_id'];
      hashTable["soc_id"] = currentUnit['soc_id'];
      NetworkHandler netwrkHandler = new NetworkHandler(
          (response) => onActionSuccessProperies(response),
          (response) => onActionFailedProperties(response),
          (response) => onActionFailedProperties(response));

      Network networkt =
          CHSONEAPIHandler.rejectMemberRequest(netwrkHandler, hashTable);
      networkt.excute();
    });
  }

  void deactivateMember(currentUnit, memberId, onActionSuccessProperies,
      onActionFailedProperties) {
    /*   String url = AppConstants.APP_URL + AppConstants.GET_MY_PROPERTIES_URL;
        Map<String, String> getMyPropertiesParams = new HashMap<String, String>();*/
    /*  print(token);*/
    ChsoneStorage.getAccessToken().then((token) {
      print(token);
      HashMap<String, String> hashTable = new HashMap();
      hashTable["token"] = token;
      hashTable["member_id"] = memberId.toString();
      hashTable["unit_id"] = currentUnit['unit_id'];
      hashTable["soc_id"] = currentUnit['soc_id'];
      NetworkHandler netwrkHandler = new NetworkHandler(
          (response) => onActionSuccessProperies(response),
          (response) => onActionFailedProperties(response),
          (response) => onActionFailedProperties(response));

      Network networkt =
          CHSONEAPIHandler.deactivateMember(netwrkHandler, hashTable);
      networkt.excute();
    });
  }
}

abstract class MyPropertyView {
  void onSuccessProperies(var successs);

  void onActionSuccessProperies(var successs);

  void onFailedProperties(var failed);

  void onActionFailedProperties(var failed);
}
