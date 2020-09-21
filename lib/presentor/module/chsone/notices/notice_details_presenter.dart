import 'notice_detail_model.dart';
import 'notice_view.dart';

class NoticeDetailPresenter {
  NoticeDetailsView noticeDetailsView;

  NoticeDetailPresenter(this.noticeDetailsView);

  void getNoticeDetail(noticeId) {
    NoticeDetailModel model = new NoticeDetailModel();
    model.noticeDetails(noticeId, noticeDetailsView);
  }
}
