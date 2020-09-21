import 'package:flutter/material.dart';

class PinEntryTextField extends StatefulWidget {
  final int fields;
  final onSubmit;
  final fieldWidth;
  final fontSize;
  final isTextObscure;
  final showFieldAsBox;

  PinEntryTextField(
      {this.fields: 4,
      this.onSubmit,
      this.fieldWidth: 40.0,
      this.fontSize: 20.0,
      this.isTextObscure: false,
      this.showFieldAsBox: false})
      : assert(fields > 0);

  @override
  State createState() {
    return PinEntryTextFieldState();
  }
}

class PinEntryTextFieldState extends State<PinEntryTextField> {
  List<String> _pin;
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;

  @override
  void initState() {
    super.initState();
    print("initState");
    _pin = List<String>(widget.fields);
    _focusNodes = List<FocusNode>(widget.fields);
    _textControllers = List<TextEditingController>(widget.fields);
  }

  String getPinText() {
    String s = "";
    _focusNodes.forEach((FocusNode f) => s = s + s);
    print(s);
    return s;
  }

  @override
  void dispose() {
    print("dispose");
//    _focusNodes.forEach((FocusNode f) => f.dispose());
    _textControllers.forEach((TextEditingController t) => t.dispose());
    super.dispose();
  }

  void clearTextFields() {
    print("clearTextFields");

    _textControllers.forEach(
        (TextEditingController tEditController) => tEditController.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    print("buildTextField");
    _focusNodes[i] = FocusNode();
    _textControllers[i] = TextEditingController();
    /*_focusNodes[i].addListener(() {
      if (_focusNodes[i].hasFocus) {
        print("_focusNodes.hasFocus");
        _textControllers[i].clear();
      }
    });*/

    return Container(
      width: widget.fieldWidth,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: widget.fontSize),
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        decoration: InputDecoration(
            counterText: "",
            border: widget.showFieldAsBox
                ? OutlineInputBorder(borderSide: BorderSide(width: 2.0))
                : null),
        onChanged: (String str) {
          /*  if (str.isEmpty) {
            if (i != 0) {
              FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
            }
          } else {*/
          print(str);
          _pin[i] = str;
          if (i + 1 != widget.fields) {
            print("_widget.fields");
            FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
          } else {
            print("clearTextFields");
            if (i != 3) {
              clearTextFields();
              FocusScope.of(context).requestFocus(_focusNodes[0]);
              /*
            widget.onSubmit(_pin.join());*/ /*
          */
            }
          }
          // }
        },
        onSubmitted: (String str) {
          //clearTextFields();
          widget.onSubmit(_pin.join());
        },
      ),
    );
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    //FocusScope.of(context).requestFocus(_focusNodes[0]);
    print('generateTextFields');
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: textFields);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: generateTextFields(context),
    );
  }
}
