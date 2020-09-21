import 'dart:collection';

import 'package:sso_futurescape/config/environment/environment.dart';

import 'api_handler.dart';


class MeetingApiHandler {

  static Network autoLoginIntoMeetingModule(NetworkHandler networkHandler, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "users/login",
        params);
    return network;
  }

  static Network loadUserProfile(NetworkHandler networkHandler, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "users/profile",
        params);
    return network;
  }

  static Network loadMemberType(NetworkHandler networkHandler, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "isadmin",
        params);
    return network;
  }

  static Network loadMeetingDetails(NetworkHandler networkHandler,
      int meetingId, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "meetings/detail/$meetingId");
    return network;
  }

  static Network loadMeetingOrVotingList(NetworkHandler networkHandler, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "meetings",
        params);
    return network;
  }

  static Network createMeetingOrVoting(NetworkHandler networkHandler, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "meeting",
        params);
    return network;
  }

  static Network loadContacts(NetworkHandler networkHandler, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.getRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "contact",
        params);
    return network;
  }

  static Network addContact(NetworkHandler networkHandler, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "contact",
        params);
    return network;
  }

  static Network addSuggestion(NetworkHandler networkHandler,
      String agendaId, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.postRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "agendas/$agendaId/suggestions",
        params);
    return network;
  }

  static Network deleteSuggestion(NetworkHandler networkHandler,
      String agendaId, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.deleteRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "agendas/$agendaId/suggestions",
        params);
    return network;
  }

  static Network startOrCloseVotingForSuggestion(NetworkHandler networkHandler,
      String agendaId, String suggestionId, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.putRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "agendas/$agendaId/suggestions/$suggestionId",
        params);
    return network;
  }

  static Network markVoteForSuggestion(NetworkHandler networkHandler,
      String agendaId, String suggestionId, HashMap<String, String> params) {
    Network network = new Network(networkHandler);
    network.setErrorReporting(true);
    network.setRequestDebug(true);
    network.putRequest(
        Environment()
            .getCurrentConfig()
            .meetingBaseUrl +
            "agendas/$agendaId/suggestions/$suggestionId/votes",
        params);
    return network;
  }
}