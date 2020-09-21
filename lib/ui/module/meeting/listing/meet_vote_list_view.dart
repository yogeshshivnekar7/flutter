abstract class MeetVoteListView {
  static const String CALL_TYPE_MEETING_LIST = "MEETINGS";
  success(int page, success, {var callingType});

  failure(int page, failed, {var callingType});

  error(int page, error, {var callingType});
}