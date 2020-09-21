import 'package:flutter/material.dart';

class StapperBody {
  String title = "";
  String description = "";
  Widget child;
  Function onPageChange;

  StapperBody({String title, String description, Widget child}) {
    this.title = title;
    this.description = description;
    this.child = child;
  }
}
