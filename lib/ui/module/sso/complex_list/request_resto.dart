import 'dart:convert';
import 'dart:ui';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/restaurant/request_resto/request_resto_presenter.dart';
import 'package:sso_futurescape/presentor/module/restaurant/request_resto/resto_view.dart';
import 'package:sso_futurescape/ui/module/restaurant/online_order_webview.dart';
import 'package:sso_futurescape/ui/module/sso/complex_list/request_verification.dart';
import 'package:sso_futurescape/ui/module/veza/veza_shop_listing.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';
import 'package:sso_futurescape/utils/focus_utils.dart';
import 'package:sso_futurescape/utils/validation_utils.dart';

class RequestListingPage extends StatefulWidget {
  BusinessAppMode pageTitle;
  String listingFor;

  RequestListingPage(BusinessAppMode title, String listingFor) {
    pageTitle = title;
    this.listingFor = listingFor;
  }

  @override
  _RequestListingPageState createState() =>
      _RequestListingPageState(pageTitle, listingFor);
}

class _RequestListingPageState extends State<RequestListingPage>
    implements RequestRestoView {
  TextEditingController nameController = new TextEditingController();
  TextEditingController brandNameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  RequestRestoPresenter requestRestoPresenter;

  BusinessAppMode pageTitle;
  String listingFor;
  String pageTitleName = 'request ';

  GlobalKey<FormState> _formKey;
  bool _autoValidateForm = false;
  FocusNode _businessNameNode;
  FocusNode _ownerNameNode;
  FocusNode _mobileNumberNode;
  FocusNode _emailAddressNode;

  _RequestListingPageState(BusinessAppMode title, String listingFor) {
    pageTitle = title;
    if (pageTitle == BusinessAppMode.RESTAURANT) {
      pageTitleName = "request Resto Listing".toLowerCase();
    } else if (pageTitle == BusinessAppMode.TIFFIN) {
      pageTitleName = "request Tiffin Listing".toLowerCase();
    } else if (pageTitle == BusinessAppMode.GROCERY) {
      pageTitleName = "request Grocery Listing".toLowerCase();
    } else if (pageTitle == BusinessAppMode.DAILY_ESSENTIALS) {
      pageTitleName = "request Daily Essential Listing".toLowerCase();
    } else if (pageTitle == BusinessAppMode.WINESHOP) {
      pageTitleName = "request shop Listing".toLowerCase();
    }
    this.listingFor = listingFor;
    print(getPageTitleString());
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _businessNameNode = FocusNode();
    _ownerNameNode = FocusNode();
    _mobileNumberNode = FocusNode();
    _emailAddressNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _businessNameNode.dispose();
    _ownerNameNode.dispose();
    _mobileNumberNode.dispose();
    _emailAddressNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: OnlineOrderWebViewState.backgroundColor(pageTitle),
        elevation: 0.0,
        title: new Text(
          pageTitleName,
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(),
      ),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Form(
          autovalidate: _autoValidateForm,
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  'Please tell us about your $listingFor'.toLowerCase(),
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
                    autovalidate: _autoValidateForm,
                    validator: (value) {
                      if (ValidationUtils.isValueNullOrEmpty(value)) {
                        return "We need the name of your business or its brand";
                      }
                      return null;
                    },
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    focusNode: _businessNameNode,
                    onEditingComplete: () {
                      FocusUtils.shiftFocus(context,
                          from: _businessNameNode, to: _ownerNameNode);
                    },
                    controller: brandNameController,
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
                        labelText: 'Business Brand Name'.toLowerCase(),
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
                    controller: nameController,
                    autovalidate: _autoValidateForm,
                    validator: (value) {
                      if (ValidationUtils.isValueNullOrEmpty(value)) {
                        return "Need to know name of the business owner";
                      }
                      return null;
                    },
                    inputFormatters: [
                      WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z\s]+'))
                    ],
                    maxLines: 1,
                    textInputAction: TextInputAction.next,
                    focusNode: _ownerNameNode,
                    onEditingComplete: () {
                      FocusUtils.shiftFocus(context,
                          from: _ownerNameNode, to: _mobileNumberNode);
                    },
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
                        "Business Administrator/Owner's name".toLowerCase(),
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
                    controller: phoneController,
                    autovalidate: _autoValidateForm,
                    validator: (value) {
                      if (ValidationUtils.isValueNullOrEmpty(value)) {
                        return "Owner's mobile number is required";
                      }

                      /*if(!ValidationUtils.isMobileNumberValid(value, 10)) {
                        return "Mobile number must be exactly of 10 digits";
                      }*/

                      return null;
                    },
                    focusNode: _mobileNumberNode,
                    onEditingComplete: () {
                      FocusUtils.shiftFocus(context,
                          from: _mobileNumberNode, to: _emailAddressNode);
                    },
                    textInputAction: TextInputAction.next,
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    style: new TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.darkgrey),
                    decoration: InputDecoration(
                        labelText: "Business Administrator/Owner's number"
                            .toLowerCase(),
                        labelStyle: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            color: FsColor.darkgrey),
                        errorText: null,
                        errorMaxLines: 3,
                        errorStyle: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          color: FsColor.red,
                        ),
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
                    controller: emailController,
                    autovalidate: _autoValidateForm,
                    validator: (value) {
                      if (ValidationUtils.isValueNullOrEmpty(value)) {
                        return null;
                      }

                      if (!ValidationUtils.isEmailValid(value)) {
                        return "Email address has an invalid format and must be in a valid format";
                      }

                      return null;
                    },
                    focusNode: _emailAddressNode,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    maxLines: 1,
                    style: new TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.darkgrey),
                    decoration: InputDecoration(
                        labelText: "Business Administrator/Owner's mail id"
                            .toLowerCase(),
                        labelStyle: TextStyle(
                            fontFamily: 'Gilroy-Regular',
                            color: FsColor.darkgrey),
                        errorText: null,
                        errorMaxLines: 3,
                        errorStyle: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          color: FsColor.red,
                        ),
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
                    child: Text('Submit',
                        style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                        )),
                    onPressed: () {
                      requestApiCall();
                    },
                    color: OnlineOrderWebViewState.backgroundColor(pageTitle),
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

  Color backgroundColor() {
    if (getPageTitleString() == 'Resto') {
      return FsColor.primaryrestaurant;
    } else if (getPageTitleString() == 'Grocery') {
      return FsColor.primarygrocery;
    } else
      return FsColor.primarytiffin;
  }

  requestApiCall() {
    String name = nameController.text.trim();
    String brandName = brandNameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();
    requestRestoPresenter = new RequestRestoPresenter(this);
    /*if (checkValidity()) {
      requestRestoPresenter.requestResto(name, brandName, phone,email,pageTitle);
    }*/
    if (_formKey.currentState.validate()) {
      requestRestoPresenter.requestResto(
          name, brandName, phone.toString(), email, getPageTitleString());
      //Toasly.success(context, 'Validation Successful', gravity: Gravity.TOP);
    }
  }

  String getPageTitleString() {
    if (pageTitle == BusinessAppMode.RESTAURANT) {
      return 'Resto';
    } else if (pageTitle == BusinessAppMode.TIFFIN) {
      return "Tiffin";
    } else if (pageTitle == BusinessAppMode.GROCERY) {
      return "Grocery";
    } else if (pageTitle == BusinessAppMode.DAILY_ESSENTIALS) {
      return "Daily Essentials";
    }
  }

  bool checkValidity() {
    bool isValid = true;
    String name = nameController.text.trim();
    String brandName = brandNameController.text.trim();
    String phone = phoneController.text.trim();
    String email = emailController.text.trim();

    if (brandName == '') {
      isValid = false;
      Toasly.error(context, 'Please enter brand name');
    }
    if (name == '') {
      isValid = false;
      Toasly.error(context, 'Please enter Name');
    }
    if (phone == '') {
      isValid = false;
      Toasly.error(context, 'Please enter Phone Number');
    }
/*    if (email == '') {
      isValid = false;
      Toasly.error(context, 'Please enter Email');
    }*/
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
  onFailure(failed) {
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode(failed)));
  }

  @override
  onSuccess(String reponse) {
    String brandName = brandNameController.text.trim();
    FsFacebookUtils.requestSubmitEvent(pageTitle, brandName);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              RequestVerificationPage(getPageTitleString(), brandName)),
    );
  }
//  void popupButtonSelected(String value) {}

}
