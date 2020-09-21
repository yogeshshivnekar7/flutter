import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

Widget customTextField(BuildContext context, String text, Icon icon,
    bool obscure, TextEditingController controller) {
  return Card(
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
      side: BorderSide(color: FsColor.primaryrecipe),
    ),
    child: TextField(
      controller: controller,
      obscureText: obscure,
      cursorColor: Colors.black,
      style:
          TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 17),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 1),
        prefixIcon: icon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
        labelText: text,
        labelStyle:
            TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 15),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    ),
  );
}
