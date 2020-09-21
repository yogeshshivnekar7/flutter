import 'dart:collection';
import 'package:sso_futurescape/ui/module/meeting/details/meet_vote_details_model.dart';
import 'package:sso_futurescape/ui/module/meeting/details/meet_vote_details_view.dart';

class MeetVoteDetailsPresenter {
  MeetVoteDetailsView _meetVoteDetailsView;
  MeetVoteDetailsModel _meetVoteDetailsModel;

  MeetVoteDetailsPresenter(MeetVoteDetailsView meetVoteDetailsView) {
    this._meetVoteDetailsView = meetVoteDetailsView;
    this._meetVoteDetailsModel = MeetVoteDetailsModel();
  }

  void loadMeetingDetails(int meetingId, callingType) {
      _meetVoteDetailsModel.loadMeetingDetails(meetingId, HashMap<String, String>(),
          _meetVoteDetailsView.success, _meetVoteDetailsView.failure, _meetVoteDetailsView.error,
          callingType);
  }
}