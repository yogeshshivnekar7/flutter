import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sso_futurescape/config/environment/environment.dart';

String url = Environment().getCurrentConfig().iplUrl;

Future fetchTodayQuiz(int userid) async {
  final response = await http.get('${url}todays-quiz?user_id=$userid');

  if (response.statusCode == 200) {
    final decode = json.decode(response.body);
    return decode;
  } else {
    return null;
  }
}

Future fetchIplUser(
    String firstname, String lastname, int userid, String mobile) async {
  final response = await http.get(
      '${url}user-details?first_name=$firstname&last_name=$lastname&user_id=$userid&mobile=$mobile');

  if (response.statusCode == 200) {
    final decode = json.decode(response.body);
    return decode;
  } else {
    return null;
  }
}

Future fetchTeamQuiz(int userid) async {
  final response = await http.get('${url}team-quiz?user_id=$userid');

  if (response.statusCode == 200) {
    final decode = json.decode(response.body);
    return decode;
  } else {
    return null;
  }
}

Future postTodaysQuiz(int userid, int questionid, int optionid) async {
  final response = await http.post(
      '${url}todays-quiz?user_id=$userid&question_id=$questionid&option_id=$optionid');
  final decode = json.decode(response.body);
  return decode;
}

Future postTeamQuiz(int userid, int questionid, int optionid) async {
  var url2 =
      '${url}team-quiz?user_id=$userid&question_id=$questionid&option_id=$optionid';
  print(url2);
  final response = await http.post(url2);
  final decode = json.decode(response.body);
  print(decode);
  return decode;
}

Future fetchLeaderboard(int userid) async {
  final response = await http.get('${url}leaderboard?user_id=$userid');

  if (response.statusCode == 200) {
    final decode = json.decode(response.body);
    return decode;
  } else {
    return null;
  }
}

Future fetchIplMainCardData(int userid) async {
  var url1 = '${url}todays-matches?user_id=$userid';
  final response = await http.get(url1);
  if (response.statusCode == 200) {
    final decode = json.decode(response.body);
    return decode;
  } else {
    return null;
  }
}
