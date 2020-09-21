abstract class MeetingLoginView {
  static const String CALL_TYPE_MEETING_LOGIN = "MEETING_LOGIN";

  loginSuccess(success, {var societyId, var callingType});

  loginFailure(failed, {var callingType});

  loginError(error, {var callingType});
}