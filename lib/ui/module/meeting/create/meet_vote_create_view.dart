abstract class MeetVoteCreateView {
  static const CALL_TYPE_CREATE_MEETING = "CREATE_MEETING";

  createMeetVoteSuccess(success, {var callingType});

  createMeetVoteFailure(failed, {var callingType});

  createMeetVoteError(error, {var callingType});
}