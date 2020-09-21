import 'package:sso_futurescape/ui/module/meeting/login/member_type_presenter.dart';
import 'package:sso_futurescape/ui/module/meeting/login/member_type_view.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_parser.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'meet_vote_profile_view.dart';

class MemberTypeHandler implements MemberTypeView {

  static MemberTypeHandler _mInstance;

  MemberTypeHandler() {}

  static MemberTypeHandler getInstance() {
    if (_mInstance == null) {
      _mInstance = MemberTypeHandler();
    }
    return _mInstance;
  }

  void loadMemberTypeForMeeting(int meetingId, callingType, {MemberTypeView view}) {
    MemberTypePresenter presenter = MemberTypePresenter((view ?? _mInstance));
    presenter.loadMemberTypeForMeeting(meetingId, callingType);
  }

  void loadMemberTypeForSociety(callingType, {var societyId, MemberTypeView view}) {
    MemberTypePresenter presenter = MemberTypePresenter((view ?? _mInstance));
    presenter.loadMemberTypeForSociety(callingType, societyId: societyId);
  }

  @override
  memberTypeError(error, {callingType}) {}

  @override
  memberTypeFailure(failed, {callingType}) {}

  @override
  memberTypeSuccess(success, var id, int type, {callingType}) {}
}