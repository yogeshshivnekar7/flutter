import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class LoadingErrorView extends StatelessWidget {

  static const _DEFAULT_ERROR_MSG_RETRY = "Failed to load data. Please try again";
  static const _DEFAULT_ERROR_MSG = "Failed to load data";
  static const _DEFAULT_RETRY_TEXT = "try again";
  String errorMsg;
  String retryText;
  bool shouldRetry;
  VoidCallback onRetryPressed;

  LoadingErrorView({this.errorMsg,
    this.retryText,
    this.shouldRetry,
    this.onRetryPressed
  });

  @override
  Widget build(BuildContext context) {
    return getErrorWidget();
  }

  String getDefaultErrorMsg() =>
      shouldRetry ? _DEFAULT_ERROR_MSG_RETRY : _DEFAULT_ERROR_MSG;

  String getDefaultRetryText() => _DEFAULT_RETRY_TEXT;

  String getErrorMsg() =>
      (errorMsg == null || errorMsg.trim().isEmpty) ?
  getDefaultErrorMsg() : errorMsg.trim();

  String getRetryText() =>
      (retryText == null || retryText.trim().isEmpty) ?
          getDefaultRetryText() : retryText.trim();

  Widget getErrorWidget() {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          getErrorTextWidget(),
          shouldRetry ? getErrorButtonWidget() : getEmptyWidget()
        ],
      ),
    );
  }

  Widget getErrorTextWidget() {
    return Text(getErrorMsg(),
      textAlign: TextAlign.center,
      style: TextStyle(
          fontFamily: 'Gilroy-Regular',
          letterSpacing: 1.0,
          height: 1.5,
          fontSize: FSTextStyle.h4size,
          color: FsColor.darkgrey),
    );
  }

  Widget getErrorButtonWidget() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: RaisedButton(
        textColor: FsColor.white,
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(4.0),
        ),
        onPressed: onRetryPressed,
        child: Text(getRetryText(),
            style: TextStyle(
              color: FsColor.white,
              fontSize: FSTextStyle.h6size,
              fontFamily: 'Gilroy-SemiBold',
            )),
        color: FsColor.basicprimary,
      ),
    );
  }

  Widget getEmptyWidget() {
    return SizedBox(
      height: 0,
      width: 0,
    );
  }
}
