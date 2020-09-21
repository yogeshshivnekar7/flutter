import 'package:sso_futurescape/presentor/module/vizlog/my_visitor_setting/my_visitor_track_domestic_model.dart';

class MyVisitorTrackDomesticPresentor {
  MyVisitorTrackDomesticView myVisitorTrackDomesticView;

  MyVisitorTrackDomesticPresentor(this.myVisitorTrackDomesticView);

  void geDemesticHelpTrackingList(companyId, unitId) {
    MyVisitorTrackDomesticModel model = new MyVisitorTrackDomesticModel();
    model.getDemesticHelpStaff(myVisitorTrackDomesticView, companyId, unitId);
  }

  void getTrackDemesticHelpStaff(trackBy, trackTo, success, failed) {
    MyVisitorTrackDomesticModel model = new MyVisitorTrackDomesticModel();
    model.getTrackDemesticHelpStaff(success, failed, trackBy, trackTo);
  }
}

abstract class MyVisitorTrackDomesticView implements IDomesticHelpList {}
