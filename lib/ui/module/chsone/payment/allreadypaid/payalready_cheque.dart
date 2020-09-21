import 'dart:io';

import 'package:common_config/utils/toast/toast.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/payment/allreadypaid/payment_bank_model.dart';
import 'package:sso_futurescape/ui/module/sso/profile/utils/image_picker_handler.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';

/*this.
onNext = onNext;}

@override
PayAlreadyChequePageState createState() =>
    new PayAlreadyChequePageState(onNext);}*/
class PayAlreadyChequePage extends StatefulWidget {
  var onNext;

  @override
  State<StatefulWidget> createState() {
    return PayAlreadyChequePageState(onNext);
  }

  PayAlreadyChequePage(onNext) {
    this.onNext = onNext;
  }
}

class PayAlreadyChequePageState extends State<PayAlreadyChequePage>
    implements PayAlreadyChequePageView, ImagePickerListener {
  /* List<String> _bank = [
    'HDFC',
    'ICICI',
    'SBI',
    'Kotak Mahindra',
    'Axis',
  ];*/ // Option 2
  String _selectedTextBank;

  // var _selectedBankAll;

  var onNext;

  File chequeFile;

  String chequeBankError = null;
  String chequeNumberError = null;
  String paymentDateError = null;
  String chequeDateError = null;
  TextEditingController chequeNumberController = new TextEditingController();
  TextEditingController chequeBankController = new TextEditingController();
  TextEditingController chequeDateController = new TextEditingController();
  TextEditingController paymentDateController = new TextEditingController();

  PayAlreadyChequePagePresentor
      payAlreadyChequePageState; //=new PayAlreadyChequePageState
  PayAlreadyChequePageState(onNext) {
    this.onNext = onNext;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    payAlreadyChequePageState = new PayAlreadyChequePagePresentor(this);
    payAlreadyChequePageState.getBankAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            alignment: Alignment.center,
            child: Text(
              'add Cheque details'.toLowerCase(),
              style: TextStyle(
                fontFamily: 'Gilroy-SemiBold',
                fontSize: FSTextStyle.h5size,
                color: FsColor.darkgrey,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: TextField(
              controller: chequeNumberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6)
              ],
              decoration: InputDecoration(
                  errorText: chequeNumberError,
                  labelText: "Enter Cheque Number".toLowerCase(),
                  labelStyle: TextStyle(
                      fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: FsColor.basicprimary))),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: TextField(
              controller: chequeBankController,
              decoration: InputDecoration(
                  errorText: chequeBankError,
                  labelText: "Enter Cheque Bank".toLowerCase(),
                  labelStyle: TextStyle(
                      fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: FsColor.basicprimary))),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              subtitle: DateTimeField(
                showCursor: false,
                /*onSaved: onFieldSubmitted(),*/
                controller: chequeDateController,
                style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                ),
                format: DateFormat("dd/MM/yyyy"),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                },
                decoration: InputDecoration(
                    errorText: chequeDateError,
                    labelText: "Select Cheque Date".toLowerCase(),
                    labelStyle: TextStyle(
                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: ListTile(
              contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              subtitle: DateTimeField(
                controller: paymentDateController,
                style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                ),
                format: DateFormat("dd/MM/yyyy"),
                showCursor: false,
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                      context: context,
                      firstDate: DateTime(1900),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime.now());
                },
                decoration: InputDecoration(
                    errorText: paymentDateError,
                    labelText: "Select Payment Date".toLowerCase(),
                    labelStyle: TextStyle(
                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey)),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
            child: DropdownButton(
              isExpanded: true,
              hint: Text(
                'Deposit In Bank Account'.toLowerCase(),
                style: TextStyle(
                    fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
              ),
              value: _selectedTextBank,
              onChanged: (newValue) {
                setState(() {
                  /*ledger_account_id*/

                  try {
                    _selectedTextBank = newValue;
                  } catch (e) {
                    print(e);
                    _selectedTextBank = newValue;
                    ;
                  }

                  /*_selectedBankAll = newValue;*/
                });
              },
              items: _bank.map((bank) {
                return DropdownMenuItem(
                  child: new Text(
                    bank["ledger_account_name"],
                    style: TextStyle(
                        fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                  ),
                  value: bank["ledger_account_name"],
                );
              }).toList(),
            ),
          ),
          /* Container(
              child: Column(
                children: <Widget>[*/
          chequeFile == null
              ? Container(
                  child: Column(
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 100,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: FsColor.lightgrey.withOpacity(0.1),
                            border:
                                Border.all(width: 1, color: FsColor.lightgrey),
                          ),
                          child: Icon(
                            FlutterIcon.upload_1,
                            color: FsColor.primaryflat,
                          ),
                        ),
                        onTap: () {
                          _uploadImageDialog();
                        },
                      ),
                      SizedBox(height: 5),
                      Text(
                        'upload cheque here'.toLowerCase(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            fontFamily: 'Gilroy-SemiBold',
                            color: FsColor.darkgrey),
                      ),
                    ],
                  ),
                )
              : Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          height: 48,
                          width: 48,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color: FsColor.primaryflat.withOpacity(0.1),
                          ),
                          child: Text(
                            chequeFile.path.split(".").last.toUpperCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.primaryflat),
                          )),
                      SizedBox(width: 10.0),
                      Flexible(
                          child: Text(
                        '',
                        // 'untitled-1.png',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.lightgrey,
                        ),
                      )),
                      GestureDetector(
                        onTap: () {
                          chequeFile = null;
                          setState(() {});
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 48,
                          width: 48,
                          padding: EdgeInsets.all(5),
                          child: Icon(
                            FlutterIcon.cancel_1,
                            size: FSTextStyle.h5size,
                            color: FsColor.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

          /* ],
              )
          ),*/
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20.0, top: 20.0),
                  child: GestureDetector(
                    child: RaisedButton(
                      padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text('Submit',
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold')),
                      onPressed: () {
                        doPayment();
                      },
                      color: FsColor.primaryflat,
                      textColor: FsColor.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List uploadimage = [
    {
      "name": "Camera",
      "img": "images/camera.png",
    },
    {
      "name": "Gallery",
      "img": "images/gallery.png",
    },
    // {
    //   "name": "Drive",
    //   "img": "images/drive.png",
    // }
  ];
  List _bank = [];

  @override
  void onBanksDetails(List banks) {
    setState(() {
      _bank = banks;
    });
  }

  @override
  void onBanksDetailsError() {}

  @override
  void onBanksDetailsFailed() {}

  bool isImageDialog;

  void _uploadImageDialog() {
    // flutter defined function
    isImageDialog = true;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return !isImageDialog
            ? Container()
            : AlertDialog(
                title: new Text("choose image",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Gilroy-SemiBold',
                        fontSize: FSTextStyle.h4size,
                        color: FsColor.darkgrey)),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(7.0),
                ),
                content: Container(
                  height: 120.0,
                  alignment: Alignment.center,
                  // width: 900.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 10, left: 0),
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          primary: false,
                          itemCount:
                              uploadimage == null ? 0 : uploadimage.length,
                          itemBuilder: (BuildContext context, int index) {
                            Map upload = uploadimage[index];
                            return Padding(
                              padding: const EdgeInsets.only(right: 0, top: 10),
                              child: InkWell(
                                child: Container(
                                  height: 120,
                                  width: 90,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(height: 8),
                                      ClipRRect(
                                        // borderRadius: BorderRadius.circular(50),
                                        child: Image.asset(
                                          "${upload["img"]}",
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      Container(
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${upload["name"]}",
                                          style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-Regular',
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.left,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  print("onTap" + upload["name"]);
                                  uploadImageEvent(upload["name"]);
                                  Navigator.pop(context);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                actions: <Widget>[
                  // usually buttons at the bottom of the dialog
                  FlatButton(
                    child: new Text(
                      "Cancel",
                      style: TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey),
                    ),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop('dialog');
                    },
                  ),
                ],
              );
      },
    );
  }

  AnimationController _controller;

  void uploadImageEvent(String upload_image_type) {
    if (upload_image_type == "Gallery") {
      openGallery();
    } else if (upload_image_type == "Camera") {
      openCamera();
    }
  }

  var imagePicker = null;

  openCamera() {
    //if (imagePicker == null) {
    imagePicker = null;
    imagePicker = new ImagePickerHandler(this, _controller);
    //}
    imagePicker.openCamera();
  }

  openGallery() {
    imagePicker = null;
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.openGallery();
  }

  @override
  userImage(File _image) {
    chequeFile = _image;
    setState(() {});
  }

  void doPayment() {
    chequeBankError = null;
    chequeNumberError = null;
    chequeDateError = null;
    paymentDateError = null;

    if (chequeNumberController.text.toString() == "") {
      chequeNumberError = "Please enter cheque number";
    } else if (chequeNumberController.text.length != 6) {
      chequeNumberError = "Please enter valid cheque number";
    } else if (chequeBankController.text.toString() == "") {
      chequeBankError = "Please enter cheque bank name";
    } else if (chequeDateController.text.toString() == "") {
      chequeDateError = "Please select cheque date";
    } else if (paymentDateController.text.toString() == "") {
      paymentDateError = "Please select payment date";
    } else {
      String accountId = null;
      for (var a in _bank) {
        if (a["ledger_account_name"] == _selectedTextBank) {
          accountId = a["ledger_account_id"].toString();
          break;
        }
      }
      setState(() {});

      if (accountId == null) {
        Toasly.error(context, "Please choose your bank");
        return;
      }
      onNext({
        "file": chequeFile.path,
        "payment_instrument": chequeBankController.text.trim(),
        "cheque_date": chequeDateController.text.trim(),
        "payment_date": paymentDateController.text.trim(),
        "bank_account": accountId,
        "transaction_reference": chequeNumberController.text.trim(),
      });
    }
    setState(() {});
  }
}
