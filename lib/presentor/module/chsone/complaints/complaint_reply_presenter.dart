import 'complaint_reply_model.dart';
import 'complaint_view.dart';

class ComplaintReplyPresenter {
  ComplaintReplyView complaintReplyView;

  ComplaintReplyPresenter(complaintReplyView) {
    this.complaintReplyView = complaintReplyView;
  }

  void getComplaintReplyist(complaintId) {
    ComplaintModel model = new ComplaintModel();
    model.getComplaintRepy(complaintId, complaintReplyView);
  }

// void getComplaintList(currentUnit, {String complaintType, String loadPage}) {
//   ListComplaintModel model = new ListComplaintModel();
//   model.listComplaints(currentUnit,complaintListView,complaintType:complaintType,loadPage:loadPage);
// }

}
