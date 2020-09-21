import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FsNavigator {
  static push(context, page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }
}
