import 'package:sso_futurescape/presentor/module/chsone/complaints/add_complaint_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/complaints/complaint_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/complaints/complaint_reply_model.dart';
import 'package:sso_futurescape/presentor/module/chsone/complaints/list_complaint_model.dart';

import 'add_reply_model.dart';

// import 'package:sso_futurescape/presentor/module/chsone/complaints/model_response.dart';
abstract class ComplaintView extends RequestComplaintModelResponse {
  // onError(var error);

  // onFailure(var failed);

  // onSuccess(String response);
}

abstract class AddComplaintView extends RequestAddComplaintModelResponse {
  // onError(var error);

  // onFailure(var failed);

  // onSuccess(String response);
}

abstract class ComplaintListView extends ListComplaintModelResponse {}

abstract class ComplaintReplyView extends ComplaintReplyModelResponse {}

abstract class AddReplyView extends RequestAddReplyModelResponse {}
