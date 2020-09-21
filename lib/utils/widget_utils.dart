import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/loading_error_widget.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';

class WidgetUtils {
  static Widget getEmptyWidget() {
    return SizedBox(
      height: 0,
      width: 0,
    );
  }

  static Widget getLoaderWidget() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: PageLoader(),
    );
  }

  static Widget getPageLoaderWidget(Color loaderColor) {
    return Align(
      child: new Container(
        color: Colors.transparent,
        width: 45.0,
        height: 45.0,
        child: new Padding(
            padding: const EdgeInsets.all(5.0),
            child: new Center(
                child: new CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(loaderColor),
            ))),
      ),
      alignment: FractionalOffset.bottomCenter,
    );
  }

  static Widget getErrorWidget(
      {String errorMsg,
      String retrytext,
      bool shouldRetry,
      VoidCallback onRetryPressed}) {
    return LoadingErrorView(
      errorMsg: errorMsg,
      retryText: retrytext,
      shouldRetry: shouldRetry,
      onRetryPressed: onRetryPressed,
    );
  }

  static Widget getMeetingCircularProgressWidget() {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(FsColor.primarymeeting),
    );
  }
}
