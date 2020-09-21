abstract class ContactsView {
  static const CALL_TYPE_LOAD_CONTACTS = "LOAD_CONTACTS";
  static const CALL_TYPE_ADD_CONTACT = "ADD_CONTACT";

  contactSuccess(success, var societyId, {var callingType});

  contactFailure(failed, {var callingType});

  contactError(error, {var callingType});
}