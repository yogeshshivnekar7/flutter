import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/config/colors/color.dart';

const _defaultProgressDialogTitle = FsString.MSG_TITLE_PROGRESS_DIALOG_DEFAULT;
final Widget _defaultProgressWidget = _circularProgressWidget;

final Widget _spinningCubeProgressWidget = SpinKitCubeGrid(
  color: FsColor.primary,
  size: 36.0,
);

final Widget _circularProgressWidget = CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation(FsColor.primaryvisitor),
);


ProgressDialog loadingDialog(BuildContext context) {
  final ProgressDialog pr = ProgressDialog(
    context,
    type: ProgressDialogType.Normal,
    isDismissible: false,
    showLogs: true,
  );

  pr.style(
    message: 'Please Wait',
    borderRadius: 10.0,
    backgroundColor: Colors.white,
    elevation: 10.0,
    insetAnimCurve: Curves.easeInOut,
    progress: 0.0,
    progressWidgetAlignment: Alignment.center,
    maxProgress: 100.0,
    progressTextStyle: TextStyle(
        color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
    messageTextStyle: TextStyle(
        color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
  );

  return pr;
}

ProgressDialog customizedLoadingDialog(BuildContext context, String message,
    {Widget progressWidget}) {
  ProgressDialog progressDialog = loadingDialog(context);

  progressDialog.style(
    message: message != null && message.trim().isNotEmpty
        ? message
        : _defaultProgressDialogTitle,
    progressWidget:
    progressWidget ?? _defaultProgressWidget,
    messageTextStyle: TextStyle(
      color: FsColor.darkgrey,
      fontFamily: 'Gilroy-SemiBold',
      fontSize: FSTextStyle.h6size,
    ),
  );

  return progressDialog;
}

ProgressDialog spinningCubeLoadingDialog(BuildContext context, String message) {
  return customizedLoadingDialog(context, message,
      progressWidget: Center(child: _spinningCubeProgressWidget));
}

ProgressDialog circularLoadingDialog(BuildContext context, String message) {
  return customizedLoadingDialog(context, message,
      progressWidget: Center(child: _circularProgressWidget));
}

void updateLoadingDialog(ProgressDialog progressDialog, String message) {
  progressDialog.update(
    message: message != null && message.trim().isNotEmpty
        ? message
        : _defaultProgressDialogTitle,
  );
}

