import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_country_picker/flutter_country_picker.dart';
import 'package:sso_futurescape/config/colors/color.dart';

class MobileNumberWidget extends StatefulWidget {
  ContactNumberController controller;
  static String ONLY_MOBILE = "ONLY_MOBILE";
  String type;

  String errorText;

  bool showConact;

  @override
  State<StatefulWidget> createState() {
    return MobileNumberPage(
        controller: controller,
        type: type,
        errorText: errorText,
        showConact: showConact);
  }

  MobileNumberWidget({String data,
    ContactNumberController controller,
    String type,
    String errorText,
    this.showConact}) {
    this.controller = controller;
    this.type = type;
    this.errorText = errorText;
  }
}

class MobileNumberPage extends State<MobileNumberWidget> {
/*  TextEditingController demo = TextEditingController();*/
  bool isMobileNumber = false;
  Country _selected = Country.IN;

  ContactNumberController mobileNumberController;

  String type;

  String errorText;

  bool showConac = false;

//  int lenght;

  MobileNumberPage({ContactNumberController controller,
    String type,
    String errorText,
    bool showConact = false}) {
    this.mobileNumberController = controller;
    this.type = type;
    this.showConac = showConact;
    this.errorText = errorText;
  }

  @override
  void initState() {
    super.initState();
    if (type != MobileNumberWidget.ONLY_MOBILE) {
      mobileNumberController.addListener(_printLatestValue);
    } else {
      isMobileNumber = true;
    }
    mobileNumberController.country = Country.IN;
  }

  _printLatestValue() {
    print("Second text field: ${mobileNumberController.text}");
    final n = num.tryParse(mobileNumberController.text);
    if (mobileNumberController.text.length > 2 && n != null) {
      if (!mounted) return;
      setState(() {
        isMobileNumber = true;
      });
    } else {
      if (!mounted) return;
      setState(() {
        isMobileNumber = false;
      });
    }
  }

  void chanegText(String value) {
    var listener = mobileNumberController.getListener();
    if (listener != null) {
      if (value.length > 3) {
        print("value           --------------------------------------- " +
            mobileNumberController.country.isoCode);
//        PhoneNumberUtil.isValidPhoneNumber(
//            phoneNumber: value, isoCode: mobileNumberController.country.isoCode)
//            .then((isValid) {
//          print("valid number ----------------------- " + isValid.toString());
//          if (isValid) {
//            setState(() {
////              lenght = value.length;
//            });
//          }
//        });
        print("chanegText--------------------------------------- $value");
        listener.onTextChanged(value);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width /* > size.height ? size.height : size.width*/;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        isMobileNumber
            ? CountryPicker(
                dense: false,
                showFlag: false,
                showDialingCode: true,
                showName: false,
                onChanged: (Country country) {
                  if (!mounted) return;
                  setState(() {
                    mobileNumberController.country = country;
                    _selected = country;
                    print("New Country selected: " + country.toString());
                  });
                  chanegText(mobileNumberController.text);
                },
          selectedCountry: _selected,
              )
            : Container(),
        Container(
          width: isMobileNumber ? width - 150 : width - 40,
          child: TextField(
            onChanged: chanegText,
            inputFormatters: type == MobileNumberWidget.ONLY_MOBILE
                ? [WhitelistingTextInputFormatter.digitsOnly]
                : [],
            keyboardType: type == MobileNumberWidget.ONLY_MOBILE
                ? TextInputType.number
                : TextInputType.text,
            controller: mobileNumberController,
//            maxLength: lenght,
            decoration: InputDecoration(
              // labelText: 'Username',

                suffixIcon: showConac != null && showConac
                    ? IconButton(
                  onPressed: () {
                    mobileNumberController
                        .getListener()
                        .onContactClicked();
                  },
                  color: FsColor.primaryvisitor,
                  icon: Icon(Icons.contacts),
                )
                    : null,
                errorText: errorText,
                hintText: "98XXXXXXXX",
                hintStyle: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                  color: FsColor.lightgrey,
                ),
                labelStyle: TextStyle(
                  fontFamily: 'Gilroy-SemiBold',
                  color: FsColor.darkgrey,
                ),
                // hintStyle: ,
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: FsColor.basicprimary))),
          ),
        ),
      ],
    );
  }
/*void _onCountryChange(CountryCode countryCode) {

    print("New Country selected: " + countryCode.toString());
  }*/

}

class ContactNumberController extends TextEditingController {
  TextListener _textListener = null;

  ContactNumberController({TextListener textListener}) {
    this._textListener = textListener;
  }

  TextListener getListener() {
    return _textListener;
  }

  Country country;

  bool isMobileNumber() {
    return text
        .trim()
        .length < 2
        ? false
        : int.tryParse(text.trim()) == null ? false : true;
  }

  String getUserName() {
    if (isMobileNumber()) {
      return country.dialingCode + text.trim();
    } else {
      return text.trim();
    }
  }

  void setText(String string) {
    text = string;
    if (_textListener != null) {
      _textListener.onTextChanged(text);
    }
  }
}

abstract class TextListener {
  onTextChanged(text);

  onContactClicked();
}
