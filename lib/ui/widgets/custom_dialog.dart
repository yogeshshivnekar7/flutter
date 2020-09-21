import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class CustomDialog extends StatefulWidget {
  String content = "Are you sure ?";

  String title;

  _MyDialogState _myStateDailog;

  CustomDialogListener customDialogListener;

  CustomDialog(this.customDialogListener, {this.title, this.content});

  void dismiss() {
    _myStateDailog.dismiss();
  }

  @override
  _MyDialogState createState() {
    _myStateDailog =
        new _MyDialogState(this.title, this.content, customDialogListener);
    return _myStateDailog;
  }

  void loadingDone() {
    _myStateDailog.loadingDone();
  }
}

abstract class CustomDialogListener {
  void onClick();
}

class _MyDialogState extends State<CustomDialog> {
  bool isLoading = false;

  String title;

  String content;

  CustomDialogListener customDialogListener;

  _MyDialogState(this.title, this.content, this.customDialogListener);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title != null
          ? new Text(title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  fontSize: FSTextStyle.h4size,
                  color: FsColor.darkgrey))
          : Container(),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(7.0),
      ),
      content: Padding(
        padding: const EdgeInsets.all(0.0),
        child: new Text(
          content,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gilroy-SemiBold',
              fontSize: FSTextStyle.h5size,
              color: FsColor.darkgrey),
        ),
      ),
      actions: <Widget>[
        new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new FlatButton(
                child: isLoading
                    ? Container()
                    : new Text("No",
                        style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.darkgrey,
                        )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                padding: EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(4.0),
                ),
                child: isLoading
                    ? SizedBox(
                        height: 20.0,
                        width: 20.0,
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(FsColor.white),
                          strokeWidth: 3.0,
                        ),
                      )
                    : Text('Yes',
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-SemiBold')),
                onPressed: () {
                  positiveClicked();
                },
                color: FsColor.basicprimary,
                textColor: FsColor.white,
              ),
            ]),
      ],
    );
  }

  void positiveClicked() {
    if (!isLoading) {
      isLoading = true;
      setState(() {});
      customDialogListener.onClick();
    }
  }

  void loadingDone() {
    isLoading = false;
    setState(() {});
  }

  void dismiss() {
    Navigator.of(context).pop();
  }
}
