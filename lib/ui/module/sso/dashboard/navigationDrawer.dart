import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_view.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ProfileView(),
    );
  }
}
