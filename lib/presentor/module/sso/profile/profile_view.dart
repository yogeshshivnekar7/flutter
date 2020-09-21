abstract class ProfileResponseView {
  void onSuccess(String success);

  void onProfileProgress(String success);

  void onFailure(String failure);

  void onError(String error);

  void showProgress();

  void hideProgress();
/*void addressDeleted(var success);

  void addressDeletionFailed(var failed);*/
}
