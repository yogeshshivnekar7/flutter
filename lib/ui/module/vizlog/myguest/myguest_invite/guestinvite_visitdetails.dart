import 'dart:collection';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:common_config/utils/fs_navigator.dart';
import 'package:common_config/utils/toast/toast.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest.dart';
import 'package:sso_futurescape/presentor/module/vizlog/guest/guest_view.dart';
import 'package:sso_futurescape/ui/module/vizlog/myguest/myguest_invite/guestinvite_information.dart';
import 'package:sso_futurescape/ui/module/vizlog/myvisitors_dashboard.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_constant.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/sso_storage.dart';
import 'package:sso_futurescape/utils/user_util.dart';

class GuestInviteDetails extends StatefulWidget {
  HashMap<String, String> hmInviteDetails;

  GuestInviteDetails(this.hmInviteDetails) {}

  @override
  _GuestInviteDetailsState createState() =>
      _GuestInviteDetailsState(hmInviteDetails);
}

class _GuestInviteDetailsState extends State<GuestInviteDetails>
    implements GuestView {
  HashMap<String, String> hmInviteDetails;

  GuestPresenter _guestPresenter;

  bool isLoading = false;

  _GuestInviteDetailsState(this.hmInviteDetails) {}

  List<String> _purpose = [
    'Cab Pickup & Drop',
    'Commercial Office Space',
    'Conference Rooms',
    'Courier Service',
    'Customised Space',
    'Delivery',
    'Eating',
    'Enquiry',
    'Events',
    'Functions',
    'Gaming',
    'Inspection',
    'Interview',
    'Learn',
    'Maintenance Service',
    'Meeting',
    'Networking',
    'Office Work',
    'Personal Work',
    'Play',
    'Post Office',
    'Reception',
    'Startup Hub',
  ];
  String _selectedPurpose;

  List<String> _pass = [
    'Day',
    'Visit',
  ];
  String _selectedallowPass = "Day";

  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  TextEditingController tfNoOfDay = new TextEditingController(text: "1");

  var inviteDateController = new TextEditingController();

  var comingFromController = new TextEditingController();

  var purposeController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _guestPresenter = new GuestPresenter(this);
    if (hmInviteDetails["coming_from"] != null &&
        hmInviteDetails["coming_from"].length > 0) {
      setState(() {
        comingFromController.text = hmInviteDetails["coming_from"];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      primaryColor: FsColor.primaryvisitor,
      appBar: new AppBar(
        backgroundColor: FsColor.primaryvisitor,
        elevation: 0.0,
        title: new Text(
          'Invite Guest'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        leading: FsBackButtonlight(backEvent: (context) {
          backEvent(context);
        }),
      ),
      body: isLoading
          ? PageLoader(
              title: "Please wait inviting guest....",
            )
          : SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          children: <Widget>[
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                'fill the guest visit details'.toLowerCase(),
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
              child: DateTimeField(
                controller: inviteDateController,
                format: DateFormat("dd-MM-yyyy hh:mm a"),
                onShowPicker: (context, currentValue) async {
                  final date = await showDatePicker(
                      context: context,
                      firstDate: getCurrentDate(),
                      initialDate: currentValue ?? DateTime.now(),
                      lastDate: DateTime(2100));
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.fromDateTime(
                          currentValue ?? DateTime.now()),
                    );
                    return DateTimeField.combine(date, time);
                  } else {
                    return currentValue;
                  }
                },
                decoration: InputDecoration(
                  labelText: "Visit Date and time".toLowerCase(),
                  labelStyle: TextStyle(
                      fontFamily: 'Gilroy-Regular',
                      fontSize: FSTextStyle.h6size,
                      color: FsColor.darkgrey),
                ),
              ),
            ),
//            Container(
//              alignment: Alignment.topLeft,
//              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
//              child: DateTimeField(
//                format: DateFormat("HH:mm"),
//                // format: format,
//                onShowPicker: (context, currentValue) async {
//                  final time = await showTimePicker(
//                    context: context,
//                    initialTime:
//                        TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//                  );
//                  return DateTimeField.convert(time);
//                },
//                decoration: InputDecoration(
//                  labelText: "Visit Time".toLowerCase(),
//                  labelStyle: TextStyle(
//                      fontFamily: 'Gilroy-Regular',
//                      fontSize: FSTextStyle.h6size,
//                      color: FsColor.darkgrey),
//                ),
//              ),
//            ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    // child: TextField(
                    //   style: new TextStyle(
                    //       fontFamily: 'Gilroy-SemiBold',
                    //       fontSize: FSTextStyle.h6size,
                    //       color: FsColor.darkgrey),
                    //   decoration: InputDecoration(
                    //       labelText: 'Allow Pass for '.toLowerCase(),
                    //       labelStyle: TextStyle(
                    //           fontFamily: 'Gilroy-Regular', color: FsColor.darkgrey),
                    //       focusedBorder: UnderlineInputBorder(
                    //           borderSide: BorderSide(color: FsColor.basicprimary))),
                    // ),
                    child: DropdownButtonFormField(
                      isExpanded: true,

//                hint: Text(
//                  'Allow Pass for'.toLowerCase(),
//                  style: TextStyle(
//                      fontFamily: 'Gilroy-Regular',
//                      fontSize: FSTextStyle.h6size,
//                      color: FsColor.darkgrey),
//                ),
                      decoration: InputDecoration(
                          labelText: 'Allow Pass for'.toLowerCase(),
                          labelStyle: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.darkgrey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: FsColor.basicprimary))),
                      value: _selectedallowPass,
                      onChanged: (newValue) {
                        setState(() {
                          print("newValue--------------------------$newValue");
                          _selectedallowPass = newValue;
                        });
                      },
                      items: _pass.map((pass) {
                        return DropdownMenuItem(
                          child: new Text(
                            pass,
                            style: TextStyle(
                                fontFamily: 'Gilroy-SemiBold',
                                fontSize: FSTextStyle.h6size,
                                color: FsColor.darkgrey),
                          ),
                          value: pass,
                        );
                      }).toList(),
                    ),
                  ),

//            Container(
//              alignment: Alignment.topLeft,
//              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
//              child: DropdownButton(
//                isExpanded: true,
//                hint: Text('No of Days'.toLowerCase(),
//                  style: TextStyle(
//                      fontFamily: 'Gilroy-Regular',
//                      fontSize: FSTextStyle.h6size,
//                      color: FsColor.darkgrey
//                  ),
//                ),
//                value: _selecteddays,
//                onChanged: (newValue) {
//                  setState(() {
//                    _selecteddays = newValue;
//                  }
//                  );
//                },
//                items: _days.map((days) {
//                  return DropdownMenuItem(
//                    child: new Text(days,
//                      style: TextStyle(
//                          fontFamily: 'Gilroy-SemiBold',
//                          fontSize: FSTextStyle.h6size,
//                          color: FsColor.darkgrey
//                      ),
//                    ),
//                    value: days,
//                  );
//                }).toList(),
//              ),
//            ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    child: TextField(
                      controller: tfNoOfDay,
                      keyboardType: TextInputType.number,
                      style: new TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey),
                      decoration: InputDecoration(
                          labelText: 'No of Days'.toLowerCase(),
                          labelStyle: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              color: FsColor.darkgrey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: FsColor.basicprimary))),
                    ),
                  ),

                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    child: TextField(
                      controller: comingFromController,
                      style: new TextStyle(
                          fontFamily: 'Gilroy-SemiBold',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey),
                      decoration: InputDecoration(
                          labelText: 'Coming From'.toLowerCase(),
                          labelStyle: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              color: FsColor.darkgrey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: FsColor.basicprimary))),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 20.0),
                    child: Column(
                      children: <Widget>[
                        searchTextField = AutoCompleteTextField<String>(
                          key: key,
                          controller: purposeController,
                          clearOnSubmit: false,
                          suggestions: _purpose,
                          style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              color: FsColor.darkgrey,
                              fontSize: FSTextStyle.h6size),
                          decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                              hintText: "Search Purpose".toLowerCase(),
                              hintStyle: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                  color: FsColor.basicprimary.withOpacity(0.85),
                                  fontSize: FSTextStyle.h6size),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: FsColor.basicprimary))),
                          itemFilter: (item, query) {
                            return item
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          },
                          itemSorter: (a, b) {
                            return a.compareTo(b);
                          },
                          itemSubmitted: (item) {
                            print(
                                "-----------------------------------------$item");
                            setState(() {
                              _selectedPurpose = item;
                              searchTextField.textField.controller.text = item;
                            });
                          },

                          // itemSubmitted: (item) => setState(() => _selectedPurpose = item),
//                    itemSubmitted: (item) => setState(() {
//                      _selectedPurpose = item;
//                    } ),
                          // value: _selectedPurpose,
                          //         onChanged: (newValue) {
                          //         setState(() {
                          //           _selectedPurpose = newValue;
                          // }
                          itemBuilder: (context, item) {
                            // ui for the autocomplete row
                            return Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                item,
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.basicprimary),
                              ),
                            );
                          },
                        ),

                        // DropdownButton(
                        //   isExpanded: true,

                        //     hint: Text('Select the Purpose'.toLowerCase(),
                        //       style: TextStyle(
                        //         fontFamily: 'Gilroy-Regular',
                        //         fontSize: FSTextStyle.h6size,
                        //         color: FsColor.darkgrey
                        //         ),
                        //       ),
                        //         value: _selectedPurpose,
                        //         onChanged: (newValue) {
                        //         setState(() {
                        //           _selectedPurpose = newValue;
                        //         }
                        //       );
                        //     },
                        //     items: _purpose.map((purpose) {
                        //       return DropdownMenuItem(
                        //         child: new Text(purpose,
                        //           style: TextStyle(
                        //             fontFamily: 'Gilroy-SemiBold',
                        //             fontSize: FSTextStyle.h6size,
                        //             color: FsColor.darkgrey
                        //           ),
                        //         ),
                        //         value: purpose,
                        //       );
                        //     }).toList(),
                        //   ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      child: RaisedButton(
                        color: FsColor.primaryvisitor,
                        textColor: FsColor.white,
                        padding: EdgeInsets.fromLTRB(30.0, 10.0, 30.0, 10.0),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        child: Text('Invite',
                            style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                            )),
                        onPressed: () {
                          validate();
                          // _confirmGuestInviteDialog();
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => GuestPass()),
//                    );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  DateTime getCurrentDate() {
    DateTime date = DateTime.now();
    return DateTime(date.year, date.month, date.day);
  }

  void popupButtonSelected(String value) {}

  validate() {
    if (inviteDateController.text.length <= 0) {
      Toasly.error(context, "please select date and time");
    } else if (tfNoOfDay.text.length <= 0) {
      Toasly.error(context, "please enter no of days");
    } else if (comingFromController.text.length <= 0) {
      Toasly.error(context, "please enter coming from");
    } else if (comingFromController.text.length <= 2) {
      Toasly.error(context, "please enter coming from at least 3 charector");
    }
    /*else if (purposeController.text.length <= 0) {
      Toasly.error(context, "please enter purpose");
    } */ else {
      submit();
    }
  }

  void submit() {
    setState(() {
      isLoading = true;
    });
    SsoStorage.getVizProfile().then((data) {
      print("visiitoor profile ---------------$data");
      print(data["data"]["users"]["visitor_id"]);
      UserUtils.getCurrentUnits(app: AppConstant.VIZLOG).then((unit) {
        if (unit != null) {
//          print(AppUtils.getDateTime(inviteDateController.text));
          hmInviteDetails["unit_id"] = unit["soc_id"];
          hmInviteDetails["building_unit_id"] = unit["unit_id"];
          if (comingFromController.text != null &&
              comingFromController.text.length > 0) {
            hmInviteDetails["coming_from"] = comingFromController.text;
          }
          hmInviteDetails["visitor_type"] = "guest";
          hmInviteDetails["pass_type"] = _selectedallowPass.toLowerCase();
          hmInviteDetails["pass_validity"] = tfNoOfDay.text;
          if (purposeController.text != null &&
              purposeController.text.length > 0) {
            hmInviteDetails["purpose"] = purposeController.text;
          }
          hmInviteDetails["expected_date_time"] = AppUtils.getDateTime(
              inviteDateController.text,
              sourceFormat: "dd-MM-yyyy hh:mm a");

          hmInviteDetails["added_by"] =
              data["data"]["users"]["visitor_id"].toString();
          if (hmInviteDetails["is_existing_guest"] == null) {
            hmInviteDetails["is_existing_guest"] = "0"; //newVisitor
            _guestPresenter.addNewGuest(hmInviteDetails);
          } else {
            _guestPresenter.inviteGuest(hmInviteDetails);
          }
        }
      });
    });
//
    print(hmInviteDetails.toString());
  }

  @override
  error(error) {
    setState(() {
      isLoading = false;
    });
    Toasly.error(context, error);
    print("erro------------------------------------$error");
    // TODO: implement error
//    throw UnimplementedError();
  }

  @override
  failure(failed) {
    setState(() {
      isLoading = false;
    });
    Toasly.error(context, AppUtils.errorDecoder(failed));
    print("failed------------------------------------$failed");
    // TODO: implement failure
//    throw UnimplementedError();
  }

  @override
  success(success) {
    setState(() {
      isLoading = false;
    });
    Toasly.success(context, FsString.GUEST_INVITED_SUCCESSFULLY);
//    FsNavigator.push(context, MyVisitorsDashboard());
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MyVisitorsDashboard()),
            (Route<dynamic> route) => false);
    print("success------------------------------------$success");

    // TODO: implement success
//    throw UnimplementedError();
  }

  backEvent(context) {
    Navigator.pop(context);
//    FsNavigator.push(context, GuestInviteInformation(hmInviteDetails));
  }
}
