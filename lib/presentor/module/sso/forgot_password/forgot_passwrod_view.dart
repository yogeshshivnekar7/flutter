abstract class ForgotPasswordView {
  void onUserAccountFound(var accounts);

  void onErrorUserAccount(var error);

  void onFailureUserAccount(var failed);
}
