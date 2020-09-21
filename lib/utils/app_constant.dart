import 'package:intl/intl.dart';
import 'package:sso_futurescape/config/environment/environment.dart';

class AppConstant {
  static final String SIGNUP = "sign_up";

  static final String VIZLOG = "vizlog";

  static final String CHSONE = "chsone";

  static final int VIZLOG_ACCESS = 100;

  static final int CHSONE_ACCESS = 200;

  static final int BOTH = 2323;
  static DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

  static int NOT_MOBILEUSER = 2103;

  static int MOBILEUSER = 3233;

  static int VALID_MOBILEUSER = 340434
  ;

  static int INVALID_MOBILEUSER = 4389;

  static String SEEN = "seen";

  static const String SCHEME_HTTP = "http";
  static const String SCHEME_HTTPS = "https";
  static String URL_TEMPLATE_JOIN_MEETING_HTTP = "$SCHEME_HTTP://${Environment.config.meetingDomain}/connect/{meeting_id}";
  static String URL_TEMPLATE_JOIN_MEETING_HTTPS = "$SCHEME_HTTPS://${Environment.config.meetingDomain}/connect/{meeting_id}";

  static const int START_SUGGESTION_VOTING = 1;
  static const int CLOSE_SUGGESTION_VOTING = 2;
  static const String VOTE_AGREE = "accept";
  static const String VOTE_DISAGREE = "reject";

  static const int TYPE_SOCIETY = 1;
  static const int TYPE_MEETING = 2;
}
