import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';

const _defaultProgressDialogTitle = FsString.MSG_TITLE_PROGRESS_DIALOG_DEFAULT;
final Widget _defaultProgressWidget = _circularProgressWidget;

final Widget _spinningCubeProgressWidget = SpinKitCubeGrid(
  color: FsColor.primary,
  size: 36.0,
);

final Widget _circularProgressWidget = CircularProgressIndicator(
  valueColor: AlwaysStoppedAnimation(FsColor.primaryvisitor),
);

CustomProgressDialog customLoadingDialog(BuildContext context, String title,
    {String subtitle, Widget progressWidget}) {
  CustomProgressDialog pr = CustomProgressDialog(context, title,
      subtitle: subtitle, progressWidget: progressWidget);
  return pr;
}

CustomProgressDialog customizedCustomLoadingDialog(
    BuildContext context, String title,
    {String subtitle, Widget progressWidget}) {
  CustomProgressDialog pr = customLoadingDialog(context, title,
      subtitle: subtitle, progressWidget: progressWidget);
  return pr;
}

CustomProgressDialog spinningCubeCustomLoadingDialog(
    BuildContext context, String title,
    {String subtitle}) {
  return customizedCustomLoadingDialog(context, title,
      subtitle: subtitle, progressWidget: _spinningCubeProgressWidget);
}

CustomProgressDialog circularCustomLoadingDialog(
    BuildContext context, String title,
    {String subtitle}) {
  return customizedCustomLoadingDialog(context, title,
      subtitle: subtitle, progressWidget: _circularProgressWidget);
}

void updateCustomLoadingDialog(
    CustomProgressDialog progressDialog, String title,
    {String subtitle, Widget progressWidget}) {
  progressDialog.updateDialog(title,
      subtitle: subtitle, progressWidget: progressWidget);
}

class CustomProgressDialog extends ProgressDialog {
  static GlobalKey<CustomProgressDialogContentState> _dialogContentStateKey =
      GlobalKey<CustomProgressDialogContentState>();

  CustomProgressDialog(BuildContext context, String title,
      {String subtitle, Widget progressWidget})
      : super(context,
            type: ProgressDialogType.Normal,
            isDismissible: false,
            showLogs: true,
            customBody: CustomProgressDialogContent.content(title,
                key: _dialogContentStateKey,
                subtitle: subtitle,
                progressWidget: progressWidget));

  void updateDialog(String title, {String subtitle, Widget progressWidget}) {
    _dialogContentStateKey.currentState
        .update(title, subtitle: subtitle, progressWidget: progressWidget);
  }
}

class CustomProgressDialogContent extends StatefulWidget {
  String _title;
  String _subtitle;
  Widget _progressWidget;

  @override
  CustomProgressDialogContentState createState() {
    return CustomProgressDialogContentState();
  }

  CustomProgressDialogContent({Key key}) : super(key: key);

  CustomProgressDialogContent.content(String title,
      {Key key, String subtitle, Widget progressWidget})
      : super(key: key) {
    this._title = title;
    this._subtitle = subtitle;
    this._progressWidget = progressWidget;
  }
}

class CustomProgressDialogContentState
    extends State<CustomProgressDialogContent> {
  CustomProgressDialogContentState();

  @override
  Widget build(BuildContext context) {
    return getProgressDialogContentWidget();
  }

  Widget getProgressDialogContentWidget() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
      child: Row(
        children: [
          widget._progressWidget ?? _defaultProgressWidget,
          SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget._title != null && widget._title.trim().isNotEmpty
                      ? widget._title
                      : _defaultProgressDialogTitle,
                  style: TextStyle(
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h5size,
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  widget._subtitle != null && widget._subtitle.trim().isNotEmpty
                      ? widget._subtitle
                      : "",
                  style: TextStyle(
                    color: FsColor.darkgrey,
                    fontFamily: 'Gilroy-Regular',
                    fontSize: FSTextStyle.h7size,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void update(String title, {String subtitle, Widget progressWidget}) {
    widget._title = title;
    widget._subtitle = subtitle;
    widget._progressWidget = progressWidget;

    setState(() {});
  }
}
