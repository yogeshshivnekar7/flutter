import 'package:flutter/cupertino.dart';
import 'package:sso_futurescape/config/colors/color.dart';

import 'my_flutter_app_icons.dart';

class AmountWithCurrencyWidget extends StatelessWidget {
  String currency;
  String amount;
  var iconName = 0xf156;

  AmountWithCurrencyWidget(currentCurrency, String amount) {
    this.currency = currency;
    this.amount = amount;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(FlutterIcon.getCurrencyIcons(iconName),
            size: FSTextStyle.h4size, color: FsColor.darkgrey),
        Text(
          amount,
          style: TextStyle(
              fontSize: FSTextStyle.h4size,
              fontFamily: 'Gilroy-Bold',
              color: FsColor.darkgrey),
        ),
      ],
    );
  }
}
