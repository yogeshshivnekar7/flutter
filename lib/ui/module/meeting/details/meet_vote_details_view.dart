abstract class MeetVoteDetailsView {
  static const String CALL_TYPE_MEETING_DETAILS = "MEETING_DETAILS";

  success(success, {var callingType});

  failure(failed, {var callingType});

  error(error, {var callingType});
}