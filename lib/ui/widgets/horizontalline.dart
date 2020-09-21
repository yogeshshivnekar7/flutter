import 'package:flutter/material.dart';

class CommonWidgets {
  static Widget horizontalLine() =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          height: 1.0,
          width: 100,
          color: Colors.black26.withOpacity(.2),
        ),
      );
}