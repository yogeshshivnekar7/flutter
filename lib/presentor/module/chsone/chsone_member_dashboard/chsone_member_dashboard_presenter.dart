import 'dart:collection';

import 'package:sso_futurescape/presentor/module/chsone/chsone_member_dashboard/chsone_member_dashboard_view.dart';

import 'chsone_member_dashboard_model.dart';

class DashboardPresenter extends RequestDashboardModelResponse {
  DashboardView dashboardView;

  DashboardPresenter(dashboardView) {
    this.dashboardView = dashboardView;
  }

  void getMyFlatDashboardDetails(HashMap<String, String> hashMap) {
    DashboardModel model = new DashboardModel(this);
    model.getMyFlatDashboardDetails(hashMap);
  }

  @override
  void onError(String error) {
    dashboardView.onError(error);
  }

  @override
  void onFailure(String error) {
    dashboardView.onFailure(error);
  }

  @override
  void onSuccess(String response) {
    dashboardView.onSuccess(response);
  }
}
