import 'add_reply_model.dart';

class ComplaintAddReplyPresenter {
  RequestAddReplyModelResponse complaintAddReplyView;

  ComplaintAddReplyPresenter(complaintReplyView) {
    this.complaintAddReplyView = complaintReplyView;
  }

  void addReply(
      String memberId, String reply, int complaintId, String compalint_status) {
    AddReplyModel model = new AddReplyModel();
    model.addReply(
        memberId, reply, complaintId, compalint_status, complaintAddReplyView);
  }
}
