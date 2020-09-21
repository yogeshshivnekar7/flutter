abstract class RequestComplaintModelResponse {
  void onSuccessHelpTopics(response);

  void onError(String response);

  void onFailure(String response);
}

abstract class RequestAddComplaintModelResponse {
  void onSuccessAddComplaint(response);

  void onError(String response);

  void onFailure(String response);
}
