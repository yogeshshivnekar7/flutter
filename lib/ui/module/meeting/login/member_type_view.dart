abstract class MemberTypeView {
  memberTypeSuccess(success, var id, int type, {var callingType});

  memberTypeFailure(failed, {var callingType});

  memberTypeError(error, {var callingType});
}