import 'package:flutter/material.dart';

class FocusUtils {
  static void shiftFocus(BuildContext context, {FocusNode from, FocusNode to}) {
    if ((context == null) || (from == null) || (to == null)) {
      return;
    }
    from.unfocus();
    FocusScope.of(context).requestFocus(to);
  }
}
