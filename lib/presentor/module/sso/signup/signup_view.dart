abstract class SignUpResponseView {
  void onSuccess();

  void onError(String error);

  void showProgress();

  void hideProgress();
}
