import 'dart:io';

import 'package:jitsi_meet/feature_flag/feature_flag_enum.dart';
import 'package:jitsi_meet/jitsi_meeting_listener.dart';
import 'package:jitsi_meet/jitsi_meet.dart';

class ConferenceHandler {

  static ConferenceHandler _mInstance;

  ConferenceHandler() {}

  static ConferenceHandler getInstance() {
    if (_mInstance == null) {
      _mInstance = ConferenceHandler();
    }
    return _mInstance;
  }

  Map<FeatureFlagEnum, bool> _getDefaultJitsiMeetFeatures() {
    Map<FeatureFlagEnum, bool> defaultFeatures = {
      FeatureFlagEnum.WELCOME_PAGE_ENABLED : false,
    };

    if (Platform.isIOS) {
      defaultFeatures[FeatureFlagEnum.PIP_ENABLED] = false;
    }

    defaultFeatures[FeatureFlagEnum.CALL_INTEGRATION_ENABLED] = false;
    defaultFeatures[FeatureFlagEnum.ADD_PEOPLE_ENABLED] = false;
    defaultFeatures[FeatureFlagEnum.CALENDAR_ENABLED] = false;
    defaultFeatures[FeatureFlagEnum.CHAT_ENABLED] = true;
    defaultFeatures[FeatureFlagEnum.INVITE_ENABLED] = false;
    defaultFeatures[FeatureFlagEnum.LIVE_STREAMING_ENABLED] = false;
    defaultFeatures[FeatureFlagEnum.IOS_RECORDING_ENABLED] = false;
    defaultFeatures[FeatureFlagEnum.MEETING_PASSWORD_ENABLED] = false;
    defaultFeatures[FeatureFlagEnum.RECORDING_ENABLED] = false;
    defaultFeatures[FeatureFlagEnum.MEETING_PASSWORD_ENABLED] = false;

    return defaultFeatures;
  }

  JitsiMeetingOptions _getDefaultJitsiMeetOptions(String roomName, String subject,
      String userName, String userEmail) {
    var defaultOptions = JitsiMeetingOptions()
      ..room = roomName?.trim()
      ..serverURL = null
      ..subject = subject?.trim()
      ..userDisplayName = userName?.trim()
      ..userEmail = userEmail?.trim()
      ..audioOnly = true
      ..audioMuted = true
      ..videoMuted = true
      ..featureFlags.addAll(_getDefaultJitsiMeetFeatures());

    return defaultOptions;
  }

  void joinMeeting(String meetingId, String meetingTitle, String userName, String userEmail,
      {Function({Map<dynamic, dynamic> message}) onWillJoin,
        Function({Map<dynamic, dynamic> message}) onJoined,
        Function({Map<dynamic, dynamic> message}) onTerminated}) async {
    try {
      await JitsiMeet.joinMeeting(
            _getDefaultJitsiMeetOptions(meetingId, meetingTitle, userName, userEmail),
            listener: JitsiMeetingListener(onConferenceWillJoin: onWillJoin,
                onConferenceJoined: onJoined,
                onConferenceTerminated: onTerminated),
          );
    } catch (e) {
      print(e);
    }
  }

}