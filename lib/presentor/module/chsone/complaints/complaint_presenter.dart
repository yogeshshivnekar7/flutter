import 'dart:io';

import 'add_complaint_model.dart';
import 'complaint_model.dart';
import 'complaint_view.dart';

class ComplaintPresenter {
  ComplaintView complaintView;
  AddComplaintView addComplaintView;

  ComplaintPresenter(complaintView) {
    this.complaintView = complaintView;
    this.addComplaintView = complaintView;
  }

  void getHelpdeskComplaintTopic(String socId) {
    ComplaintModel model = new ComplaintModel();
    model.getHelpdeskTopic(socId, complaintView);
  }

  void addComplait(String detail, String subject, currentUnit, String topic,
      {File file}) {
    AddComplaintModel model = new AddComplaintModel();
    print("ddddddddddddddddddddddd");
    model.addComplaint(
        detail, subject, currentUnit, topic, addComplaintView, file);
  }
}
