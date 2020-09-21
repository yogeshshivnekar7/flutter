import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class FsBackButton extends StatelessWidget {
  Function backEvent;

  FsBackButton({Function backEvent}) {
    this.backEvent = backEvent;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, size: 18.0),
      color: FsColor.darkgrey,
      onPressed: () => {backClick(context)},
    );
  }

  backClick(context) {
    if (backEvent == null) {
      Navigator.of(context).pop();
    } else {
      backEvent(context);
    }
  }
}

class FsBackButtonlight extends StatelessWidget {
  Function backEvent;

  FsBackButtonlight({Function backEvent}) {
    this.backEvent = backEvent;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, size: 18.0),
      color: FsColor.white,
      onPressed: () => {backClick(context)},
    );
  }

  backClick(context) {
    if (backEvent == null) {
      Navigator.of(context).pop();
    } else {
      backEvent(context);
    }
  }
}
