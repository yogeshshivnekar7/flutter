import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FsScrollWidget extends StatefulWidget{
  Widget childWidget;

  FsScrollWidget(this.childWidget);
  @override
  State<StatefulWidget> createState() {

    return _FsScrollState(childWidget);
  }



}
class _FsScrollState extends State<FsScrollWidget>{
  Widget childWidget;

  _FsScrollState(this.childWidget);
  @override
  Widget build(BuildContext context) {

   return Scaffold(
      body: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Container(
          child: childWidget,

        ),
      ),
    );

  }

}