import 'notice_list_model.dart';
import 'notice_view.dart';

class ListNoticePresenter {
  NoticeView noticeListView;

  ListNoticePresenter(noticeListView) {
    this.noticeListView = noticeListView;
  }

  void getNoticeList(currentUnit, {noticeType, page}) {
    ListNoticeModel model = new ListNoticeModel();
    model.listNotice(currentUnit, noticeListView,
        noticeType: noticeType, page: page);
  }

// void getComplaintList(currentUnit, {String complaintType, String loadPage}) {
//   ListComplaintModel model = new ListComplaintModel();
//   model.listComplaints(currentUnit,complaintListView,complaintType:complaintType,loadPage:loadPage);
// }

}
