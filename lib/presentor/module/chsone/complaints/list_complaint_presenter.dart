import 'complaint_view.dart';
import 'list_complaint_model.dart';

class ListComplaintPresenter {
  ComplaintListView complaintListView;

  ListComplaintPresenter(complaintView) {
    this.complaintListView = complaintView;
  }

  void getComplaintList(currentUnit, {String complaintType, String loadPage}) {
    ListComplaintModel model = new ListComplaintModel();
    model.listComplaints(currentUnit, complaintListView,
        complaintType: complaintType, loadPage: loadPage);
  }
}
