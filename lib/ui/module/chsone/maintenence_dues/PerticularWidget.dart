import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class PerticualrsWidget extends StatelessWidget {
  var i;
  List particularHeader;

  var particularValue;

  PerticualrsWidget(this.particularHeader, this.particularValue) {
    /* particularValue = invoice['particular_value'][i];
    particularHeader = invoice['particular_header'];*/
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
            width: 1.0, color: FsColor.basicprimary.withOpacity(0.2)),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: renderChildrenTable(i),
      ),
    );
  }

  renderChildrenTable(int i) {
    List<Widget> widget = [];

    // if(invoice['particular_header'][0]['name'] !="Sr No")
    // {

    // Widget inner1 = Column(
    //   children: <Widget>[
    //     Container(
    //       width: 150,
    //      child: Text(
    //         particularValue[0] == null
    //             ? "-"
    //             : particularValue[0].toString().toLowerCase(),
    //         textAlign: TextAlign.right,
    //         style: TextStyle(
    //             fontSize: FSTextStyle.h6size,
    //             fontFamily: 'Gilroy-SemiBold',
    //             color: FsColor.darkgrey),
    //             overflow: TextOverflow.ellipsis,
    //       ),


    //     )
    //   ],
    // );

    /*   Widget inner1 = Expanded(
      child: Text(*/

    Widget inner1 = Column(
      children: <Widget>[
        Container(
          width: 100,
          child: Text(
            particularValue[0] == null
                ? "-"
                : particularValue[0].toString().toLowerCase(),
            textAlign: TextAlign.right,
            style: TextStyle(
                fontSize: FSTextStyle.h6size,
                fontFamily: 'Gilroy-SemiBold',
                color: FsColor.darkgrey),
          ),
        )
      ],
    );

    widget.add(inner1);

    Widget inner2 = Container(
      width: 150,
      child: Column(
        children: renderRow(i),
      ),
    );
    widget.add(inner2);
    return widget;
  }

  renderRow(int i) {
    List<Widget> widget = [];
    Widget row = SizedBox(height: 5);
    widget.add(row);
    try {
      //var perticularHeader = invoice['particular_header'];
      for (var j = 1; j < particularHeader.length; j++) {
        Widget row2 = Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              particularHeader[j]['name'] == null
                  ? "-"
                  : particularHeader[j]['name'].toLowerCase(),
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: FSTextStyle.h6size,
                  fontFamily: 'Gilroy-SemiBold',
                  color: FsColor.lightgrey),
            ),
            Text(
              particularValue[j] == null
                  ? "-"
                  : particularValue[j].toString().toLowerCase(),
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: FSTextStyle.h6size,
                  fontFamily: 'Gilroy-SemiBold',
                  color: FsColor.darkgrey),
            ),
          ],
        );
        widget.add(row2);
      }
    } catch (e) {
      print(e);
    }

    return widget;
  }
}
