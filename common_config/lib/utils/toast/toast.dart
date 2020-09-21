import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

class Toasly {
  static void error(context, message,
      {DurationToast duration, Gravity gravity}) {
    var dur = Toast.LENGTH_LONG;
    if (duration == DurationToast.SHORT) {
      dur = Toast.LENGTH_SHORT;
    } else if (duration == DurationToast.LONG) {
      dur = Toast.LENGTH_LONG;
    }
    var grav = Toast.CENTER;
    if (gravity == Gravity.BOTTOM) {
      grav = Toast.BOTTOM;
    } else if (gravity == Gravity.CENTER) {
      grav = Toast.CENTER;
    } else if (gravity == Gravity.TOP) {
      grav = Toast.TOP;
    }
    Toast.show(message, context,
        duration: dur, gravity: grav, backgroundColor: Colors.red);
  }

  static void success(context, message,
      {DurationToast duration, Gravity gravity}) {
    var dur = Toast.LENGTH_LONG;
    if (duration == DurationToast.SHORT) {
      dur = Toast.LENGTH_SHORT;
    } else if (duration == DurationToast.LONG) {
      dur = Toast.LENGTH_LONG;
    }
    var grav = Toast.CENTER;
    if (gravity == Gravity.BOTTOM) {
      grav = Toast.BOTTOM;
    } else if (gravity == Gravity.CENTER) {
      grav = Toast.CENTER;
    } else if (gravity == Gravity.TOP) {
      grav = Toast.TOP;
    }
    Toast.show(message, context,
        duration: dur, gravity: grav, backgroundColor: Colors.green);
  }

  static void warning(context, message,
      {DurationToast duration, Gravity gravity}) {
    var dur = Toast.LENGTH_LONG;
    if (duration == DurationToast.SHORT) {
      dur = Toast.LENGTH_SHORT;
    } else if (duration == DurationToast.LONG) {
      dur = Toast.LENGTH_LONG;
    }
    var grav = Toast.CENTER;
    if (gravity == Gravity.BOTTOM) {
      grav = Toast.BOTTOM;
    } else if (gravity == Gravity.CENTER) {
      grav = Toast.CENTER;
    } else if (gravity == Gravity.TOP) {
      grav = Toast.TOP;
    }
    Toast.show(message, context,
        duration: dur, gravity: grav, backgroundColor: Colors.orange);
  }

}

enum DurationToast { SHORT, LONG }
enum Gravity { CENTER, TOP, BOTTOM }
