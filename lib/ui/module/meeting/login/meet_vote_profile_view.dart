abstract class MeetingProfileView {
  static const String CALL_TYPE_USER_PROFILE = "USER_PROFILE";

  profileSuccess(success, {var societyId, var callingType});

  profileFailure(failed, {var callingType});

  profileError(error, {var callingType});
}