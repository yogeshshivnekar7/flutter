import 'dart:collection';
import 'package:sso_futurescape/config/environment/environment.dart';
import 'package:sso_futurescape/ui/module/meeting/create/contacts_model.dart';
import 'package:sso_futurescape/ui/module/meeting/create/contacts_view.dart';
import 'package:sso_futurescape/ui/module/meeting/utils/meet_vote_utils.dart';

class ContactsPresenter {
  ContactsView _contactsView;
  ContactsModel _contactsModel;

  ContactsPresenter(ContactsView contactsView) {
    this._contactsView = contactsView;
    this._contactsModel = ContactsModel();
  }

  void loadContacts(data, callingType, {var societyId}) async {
    HashMap<String, String> params = HashMap<String, String>();

    societyId = await MeetVoteUtils.getDefaultSocietyIfInvalid(societyId);
    String accessToken = await MeetVoteUtils.getMeetingToken();

    params["company_id"] = societyId.toString();
    params["access_token"] = accessToken;
    params["app_id"] = Environment.config.meetingAppId.toString();

    _contactsModel.loadContacts(params, societyId,
        _contactsView.contactSuccess, _contactsView.contactFailure, _contactsView.contactError,
        callingType);
  }

  void addContact(data, callingType, {var societyId}) async {
    HashMap<String, String> params = HashMap<String, String>();

    societyId = await MeetVoteUtils.getDefaultSocietyIfInvalid(societyId);
    String accessToken = await MeetVoteUtils.getMeetingToken();

    params["company_id"] = societyId.toString();
    params["access_token"] = accessToken;
    params["app_id"] = Environment.config.meetingAppId.toString();
    params["name"] = data["name"];
    String mobile = data["mobile"];
    if (mobile != null && mobile.trim().isNotEmpty) {
      params["mobile"] = mobile;
    }
    String email = data["email"];
    if (email != null && email.trim().isNotEmpty) {
      params["email"] = email;
    }

    _contactsModel.addContact(params, societyId,
        _contactsView.contactSuccess, _contactsView.contactFailure, _contactsView.contactError,
        callingType);
  }
}