import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/request_complex/complex_view.dart';
import 'package:sso_futurescape/presentor/module/chsone/request_complex/request_complex_presenter.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/complex_verification.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/focus_utils.dart';
import 'package:sso_futurescape/utils/validation_utils.dart';

class RequestComplexPage extends StatefulWidget {
  @override
  _RequestComplexPageState createState() => _RequestComplexPageState();
}

class _RequestComplexPageState extends State<RequestComplexPage>
    implements RequestComplexView {
  TextEditingController nameController = new TextEditingController();
  TextEditingController compleNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();

  RequestComplexPresenter requestComplexPresenter;

  GlobalKey<FormState> _formKey;
  bool _autoValidate = false;
  FocusNode _complexNameNode;
  FocusNode _chairmanNameNode;
  FocusNode _mobileNumberNode;

  @override
  void initState() {
    requestComplexPresenter = new RequestComplexPresenter(this);
    _formKey = GlobalKey<FormState>();
    _complexNameNode = FocusNode();
    _chairmanNameNode = FocusNode();
    _mobileNumberNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _complexNameNode.dispose();
    _chairmanNameNode.dispose();
    _mobileNumberNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: FsColor.primaryflat,
        elevation: 0.0,
        title: new Text(
          'request complex',
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
      ),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Form(
          key: _formKey,
          autovalidate: _autoValidate,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'give us your complex details',
                  style: TextStyle(
                    fontSize: FSTextStyle.h5size,
                    fontFamily: 'Gilroy-SemiBold',
                    color: FsColor.darkgrey,
                    height: 1.2,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: ListTile(
                  subtitle: TextFormField(
                    validator: (value) {
                      if (ValidationUtils.isValueNullOrEmpty(value)) {
                        return "Need the name of the complex";
                      }
                      return null;
                    },
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    focusNode: _complexNameNode,
                    onEditingComplete: () {
                      FocusUtils.shiftFocus(context,
                          from: _complexNameNode, to: _chairmanNameNode);
                    },
                    controller: compleNameController,
                    style: new TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.darkgrey),
                    decoration: InputDecoration(
                        errorText: null,
                        errorMaxLines: 3,
                        errorStyle: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          color: FsColor.red,
                        ),
                        labelText: 'complex name'.toLowerCase(),
                        labelStyle: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            color: FsColor.darkgrey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: FsColor.basicprimary))),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: ListTile(
                  subtitle: TextFormField(
                    validator: (value) {
                      if (ValidationUtils.isValueNullOrEmpty(value)) {
                        return "Need the name of the secretary or chairman of the complex";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z\s]+'))
                    ],
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    focusNode: _chairmanNameNode,
                    onEditingComplete: () {
                      FocusUtils.shiftFocus(context,
                          from: _chairmanNameNode, to: _mobileNumberNode);
                    },
                    controller: nameController,
                    style: new TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.darkgrey),
                    decoration: InputDecoration(
                        errorText: null,
                        errorMaxLines: 3,
                        errorStyle: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          color: FsColor.red,
                        ),
                        labelText: 'Secretary/Chairman Name'.toLowerCase(),
                        labelStyle: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            color: FsColor.darkgrey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: FsColor.basicprimary))),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                child: ListTile(
                  subtitle: TextFormField(
                    focusNode: _mobileNumberNode,
                    textInputAction: TextInputAction.done,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    validator: (value) {
                      if (ValidationUtils.isValueNullOrEmpty(value)) {
                        return "Secretary or Chairman's mobile number is needed";
                      }

                      /*if(!ValidationUtils.isMobileNumberValid(value, 10)) {
                        return "Mobile number must be exactly of 10 digits";
                      }*/

                      return null;
                    },
                    controller: phoneController,
                    style: new TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.darkgrey),
                    decoration: InputDecoration(
                        errorText: null,
                        errorMaxLines: 3,
                        errorStyle: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          color: FsColor.red,
                        ),
                        labelText:
                        'secretary/chairman contact number'.toLowerCase(),
                        labelStyle: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            color: FsColor.darkgrey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: FsColor.basicprimary))),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(4.0),
                    ),
                    child: Text('Send Request',
                        style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                        )),
                    onPressed: () {
                      requestApiCall();
                    },
                    color: FsColor.primaryflat,
                    textColor: FsColor.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  requestApiCall() {
    String name = nameController.text.trim();
    String complexName = compleNameController.text.trim();
    String phone = phoneController.text.trim();
    /*if (checkValidity()) {
      requestComplexPresenter.requestComplex(name, complexName, phone);
    }*/

    if (_formKey.currentState.validate()) {
      requestComplexPresenter.requestComplex(name, complexName, phone);
      //Toasly.error(context, 'Validation Successful', gravity: Gravity.TOP);
    }
  }

  bool checkValidity() {
    bool isValid = true;
    String name = nameController.text.trim();
    String complexName = compleNameController.text.trim();
    String phone = phoneController.text.trim();
    if (complexName == '') {
      Toasly.error(context, 'Please enter complex name',
          gravity: Gravity.CENTER);
      return false;
    }
    if (name == '') {
      Toasly.error(context, 'Please enter secretary/chairman name',
          gravity: Gravity.CENTER);
      return false;
    }
    if (phone == '') {
      Toasly.error(context, 'Please enter secretary/chairman contact number',
          gravity: Gravity.CENTER);
      return false;
    } else {
      try {
        int.parse(phone);
      } catch (e, s) {
//        print(s);
        Toasly.error(context, 'Please enter valid contact number',
            gravity: Gravity.CENTER);
        return false;
      }
    }
    return isValid;
  }

  void popupButtonSelected(String value) {}

  @override
  clearList() {}

  @override
  onComplexFound(complex) {}

  @override
  onError(error) {}

  @override
  onFailure(failed) {}

  @override
  onSuccess(String reponse) {
    String complexName = compleNameController.text.trim();
    FsFacebookUtils.requestSocietySubmitEvent(complexName);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ComplexVerificationPage(complexName)),
    );
  }
}
