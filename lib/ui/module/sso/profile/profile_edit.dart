import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:common_config/utils/toast/toast.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_presenter.dart';
import 'package:sso_futurescape/presentor/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/module/sso/profile/utils/image_picker_handler.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/validation_utils.dart';

// enum SingingCharacter { lafayette, jefferson }

class ProfileEdit extends StatefulWidget {
  var profileData;

  ProfileEdit(profileData) {
    this.profileData = profileData;
    print("EditProfileData " + profileData.toString());
  }

  @override
  _ProfileEditState createState() => new _ProfileEditState(profileData);
}

class _ProfileEditState extends State<ProfileEdit>
    with TickerProviderStateMixin
    implements ProfileResponseView, ImagePickerListener {
  ProfilePresenter presenter;
  bool update_image = false;
  bool isLoading = false;
  bool isDone = true;
  bool isImageDialog = false;
  String accessToken = "Iq6XXSVGwZKn8gO1HixzBhYfRbDxDhVk9w8uN013";
  List<String> _bloodgroup = [
    'Select',
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ]; // Option 1
  String _selectedBloodgroup; // Option 1

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
  List<String> _education = [
    'Select',
    'Under Graduate',
    'Graduate',
    'Post Graduate',
    'Engineering Graduate',
    'Doctor',
    'Diploma'
  ]; // Option 2
  String _selectedEducation; // Option 2

  String _genter = "";
  String fullName = "";
  String first_name = "";
  String last_name = "";
  var profileData;
  var tempProfileData;
  var dataprofile;
  TextEditingController fullNameController = new TextEditingController();

  //TextEditingController fullAddressController = new TextEditingController();

  TextEditingController first_nameController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController last_nameController = new TextEditingController();
  TextEditingController bloodGroupController = new TextEditingController();
  TextEditingController panController = new TextEditingController();
  TextEditingController aadhaarController = new TextEditingController();
  TextEditingController wedAnniversaryController = new TextEditingController();
  TextEditingController highEducationController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController dobController = new TextEditingController();

  /*TextEditingController address_line_1Controller = new TextEditingController();
  TextEditingController address_line_2Controller = new TextEditingController();*/
  GlobalKey<FormState> _formKey;
  bool _autoValidate = false;

  // FocusNode _fullNameNode;

  REQUEST_TYPE request_type;
  UPLOAD_IMAGE_TYPE upload_image_type;
  String imageFrom = "gallery";
  File _image = null;
  int counter = 0;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  String profileImageURL = null;
  String avatar_size = "avatar_medium";

  bool isSocial = false;

  _ProfileEditState(profileData) {
    this.profileData = profileData;
    print("EditStateProfileData " + profileData.toString());
  }

  void _userGender(String value) {
    setState(() {
      _genter = value;
    });
  }

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    presenter = new ProfilePresenter(this);
    intializeController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color1 = Color(0xff404040);
    final Color color2 = Color(0xff999999);
    final _media = MediaQuery.of(context).size;
    // final String image = avatars[0];
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Edit Profile".toLowerCase(),
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(),
        /*backgroundColor: Colors.transparent,
        title: Text(
          "edit profile",
          style: FSTextStyle.appbartext,
        ),
        leading: FsBackButton(),*/

        /* actions: <Widget>[
          IconButton(
            icon: Icon(Icons.home),
            color: const Color(0xFF545454),
            onPressed: (){
              Navigator.push(
                context, new MaterialPageRoute(
                  builder: (context) => MyApp()
              ),
              );
            },
          ),
        ]*/
      ),
      body: isLoading
          ? PageLoader()
          : SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Stack(
                  children: <Widget>[
                    Container(
                      height: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50.0),
                              bottomRight: Radius.circular(50.0)),
                          gradient: LinearGradient(
                              colors: [color1, color2],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 15.0),
                          Container(
                            child: Stack(
                              children: <Widget>[
                                new Stack(children: <Widget>[
                                  new Center(
                                    /*child: profileData[avatar_size] != null*/
                                    child: profileImageURL != null
                                        ? new Container(
                                            height: 180,
                                            width: 180,
                                            margin: const EdgeInsets.only(
                                                left: 20.0,
                                                right: 20.0,
                                                top: 10.0),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(90.0),
                                              child: Image.network(
                                                profileImageURL,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          )
                                        : _image != null
                                            ? new Container(
                                                height: 180,
                                                width: 180,
                                                margin: const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20.0,
                                                    top: 10.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90.0),
                                                  child: Image.file(
                                                    _image,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : new Container(
                                                height: 180,
                                                width: 180,
                                                margin: const EdgeInsets.only(
                                                    left: 20.0,
                                                    right: 20.0,
                                                    top: 10.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          90.0),
                                                  child: Image.asset(
                                                    'images/default.png',
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                  ),
                                  /*new Center(
                              child: new Container(
                                height: 180,
                                width: 180,
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 10.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: new FlatButton(
                                    onPressed: () => {},
                                    color: const Color(0x80000000),
                                  ),
                                ),
                              ),
                            ),*/
                                  /* new Center(
                              child: new Container(
                                height: 180,
                                width: 180,
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 20.0, top: 10.0),
                                child: new FlatButton(
                                  onPressed: () =>
                                  {
                                    print("onPressed camera"),
                                    // openCamera()
                                    openGallery()
                                    */ /* imagePicker.showDialog(context)*/ /*
                                  },
                                  padding: EdgeInsets.all(10.0),
                                  child: new Icon(
                                    Icons.camera_alt,
                                    size: 30.0,
                                    color: FsColor.white,
                                  ),
                                ),
                              ),
                            )*/
                                  new Center(
                                    child: new Container(
                                      height: 180,
                                      width: 180,
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 20.0, top: 10.0),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(90.0),
                                        child: new FlatButton(
                                          onPressed: () =>
                                              {_uploadImageDialog()},
                                          color: const Color(0x80000000),
                                          child: null,
                                        ),
                                      ),
                                    ),
                                  ),
                                  new Center(
                                    child: new Container(
                                      height: 180,
                                      width: 180,
                                      margin: const EdgeInsets.only(
                                          left: 20.0, right: 20.0, top: 10.0),
                                      child: new FlatButton(
                                        onPressed: () => {_uploadImageDialog()},
                                        padding: EdgeInsets.all(10.0),
                                        child: new Icon(
                                          Icons.camera_alt,
                                          size: 30.0,
                                          color: FsColor.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Container(
                            padding:
                                EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
                            child: Column(children: <Widget>[
                              TextFormField(
                                validator: (value) {
                                  if (ValidationUtils.isValueNullOrEmpty(
                                      value)) {
                                    return "Name is Mandatory";
                                  }
                                  return null;
                                },
                                controller: fullNameController,
                                // focusNode: _fullNameNode,
                                decoration: InputDecoration(
                                    labelText: 'Name',
                                    hintText: 'Enter Name',
                                    errorText: null,
                                    errorMaxLines: 3,
                                    errorStyle: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      color: FsColor.red,
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: FsColor.basicprimary))),
                                /* onEditingComplete: (){
                            _shiftFocus(context, _fullNameNode);
                          },*/
                                /*controller: fullNameController,
                          onChanged: (String text) {
                            fullName = text;
                          },*/
                                /* initialValue: profileData["first_name"].toString() +
                              " " +
                              profileData["last_name"].toString(),*/
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                ),
                              ),
                            ]),
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Column(
                              children: <Widget>[
                                ListTile(
                                  title: Text(
                                    "Details",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Semibold',
                                    ),
                                  ),
                                ),
                                ListTile(
                                  subtitle: TextFormField(
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                    ),
                                    controller: mobileController,
                                    enabled: false,
                                    keyboardType: TextInputType.number,
                                    /* initialValue: profileData["mobile"].toString(),*/
                                    decoration:
                                        InputDecoration(labelText: 'Mobile'),
                                  ),
                                  leading: Icon(Icons.phone),
                                ),
                                1 == 1
                                    ? Container()
                                    : ListTile(
                                        subtitle: TextFormField(
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Regular',
                                          ),
                                          controller: emailController,
                                          enabled: false,
                                          /*initialValue: profileData["email"].toString(),*/
                                          decoration: InputDecoration(
                                              labelText: 'Email'),
                                        ),
                                        leading: Icon(Icons.email),
                                      ),
                                ListTile(
                                  subtitle: TextFormField(
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                    ),
                                    /*initialValue: "SDEAD3521L",*/
                                    controller: panController,
                                    decoration: InputDecoration(
                                        labelText: 'PAN/TAX ID'),
                                    maxLength: 15,
                                  ),
                                  leading: Icon(Icons.web),
                                ),
                                ListTile(
                                  subtitle: TextFormField(
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                    ),
                                    controller: aadhaarController,
                                    maxLength: 16,
                                    /* initialValue: "3251423005563",*/
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Aadhaar/SSN'),
                                  ),
                                  leading: Icon(Icons.web),
                                ),
                                ListTile(
                                  subtitle: DateTimeField(
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                    ),
                                    /*format: DateFormat("dd/MM/yyyy"),*/
                                    format: DateFormat("dd-MM-yyyy"),
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          lastDate: DateTime.now());
                                    },
                                    controller: dobController,
                                    showCursor: false,
                                    readOnly: true,
                                    decoration: InputDecoration(
                                      labelText: "Date of Birth",
                                    ),
                                  ),
                                  leading: Icon(FlutterIcon.calendar),
                                ),
                                SizedBox(height: 10),
                                ListTile(
                                  title: Text(
                                    "Gender",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      fontSize: 12,
                                      color: const Color(0xFF7b7b7b),
                                    ),
                                  ),
                                  subtitle: new Column(children: <Widget>[
                                    new RadioListTile(
                                      value: "Male",
                                      title: new Text(
                                        "Male",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Regular',
                                        ),
                                      ),
                                      groupValue: _genter,
                                      onChanged: (String value) {
                                        _userGender(value);
                                      },
                                    ),
                                    new RadioListTile(
                                      value: "Female",
                                      title: new Text(
                                        "Female",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Regular',
                                        ),
                                      ),
                                      groupValue: _genter,
                                      onChanged: (String value) {
                                        _userGender(value);
                                      },
                                    ),
                                    new RadioListTile(
                                      value: "Other",
                                      title: new Text(
                                        "Other",
                                        style: TextStyle(
                                          fontFamily: 'Gilroy-Regular',
                                        ),
                                      ),
                                      groupValue: _genter,
                                      onChanged: (String value) {
                                        _userGender(value);
                                      },
                                    ),
                                  ]),
                                  leading: Icon(Icons.person),
                                ),
                                ListTile(
                                  title: Text(
                                    "Blood Group",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      fontSize: 12,
                                      color: const Color(0xFF7b7b7b),
                                    ),
                                  ),
                                  subtitle: new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        DropdownButton(
                                          hint: Text(
                                            'Choose your blood group',
                                            style: TextStyle(
                                              fontFamily: 'Gilroy-Regular',
                                            ),
                                          ),
                                          value: _selectedBloodgroup,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedBloodgroup = newValue;
                                            });
                                          },
                                          items: _bloodgroup.map((bloodgroup) {
                                            return DropdownMenuItem(
                                              child: new Text(
                                                bloodgroup,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Regular',
                                                ),
                                              ),
                                              value: bloodgroup,
                                            );
                                          }).toList(),
                                        ),
                                      ]),
                                  leading: Icon(FlutterIcon.eyedropper),
                                ),
                                ListTile(
                                  subtitle: DateTimeField(
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                    ),
                                    /* format: DateFormat("dd/MM/yyyy"),*/
                                    format: DateFormat("dd-MM-yyyy"),
                                    onShowPicker: (context, currentValue) {
                                      return showDatePicker(
                                          context: context,
                                          firstDate: DateTime(1900),
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          lastDate: DateTime(2100));
                                    },
                                    showCursor: false,
                                    readOnly: true,
                                    controller: wedAnniversaryController,
                                    decoration: InputDecoration(
                                      labelText: "Wedding Anniversary",
                                    ),
                                  ),
                                  leading: Icon(FlutterIcon.calendar),
                                ),
                                SizedBox(height: 10),
                                ListTile(
                                  title: Text(
                                    "Higher Education",
                                    style: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      fontSize: 12,
                                      color: const Color(0xFF7b7b7b),
                                    ),
                                  ),
                                  subtitle: new Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      //  width = MediaQuery.of(context).size.width;
                                      // double yourWidth = width * 0.100;
                                      children: <Widget>[
                                        DropdownButton(
                                          hint: Text(
                                            'Choose your Higher Education',
                                            style: TextStyle(
                                                fontFamily: 'Gilroy-Regular'),
                                          ),
                                          value: _selectedEducation,
                                          onChanged: (newValue) {
                                            setState(() {
                                              _selectedEducation = newValue;
                                            });
                                          },
                                          items: _education.map((education) {
                                            return DropdownMenuItem(
                                              child: new Text(
                                                education,
                                                style: TextStyle(
                                                  fontFamily: 'Gilroy-Regular',
                                                ),
                                              ),
                                              value: education,
                                            );
                                          }).toList(),
                                        ),
                                      ]),
                                  leading: Icon(FlutterIcon.graduation_cap),
                                ),
                              ],
                            ),
                          ),
                          /*  Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            title: Text(
                              "Addresses",
                              style: TextStyle(
                                fontFamily: 'Gilroy-Semibold',
                              ),
                            ),
                          ),
                          ListTile(
                            subtitle: TextFormField(
                              */ /* controller: address_line_1Controller,*/ /*
                              style: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                              ),
                              minLines: 2,
                              maxLines: 4,
                              */ /*controller: fullAddressController,
                              initialValue: profileData["address_line_1"]
                                  .toString() +
                                  " " +
                                  profileData["address_line_2"].toString() +
                                  " \n" +
                                  profileData["city"].toString() +
                                  " " +
                                  profileData["zip_code"].toString() +
                                  " \n" +
                                  profileData["state"].toString() +
                                  " " +
                                  profileData["country"].toString(),*/ /*
                              decoration: InputDecoration(labelText: 'Home'),
                            ),
                            leading: Icon(Icons.home),
                          ),
                        ],
                      ),
                    ),*/
                          isSocial
                              ? Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: Column(
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          "Social Accounts",
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Semibold',
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        subtitle: Container(
                                          alignment: Alignment.centerLeft,
                                          child: FlatButton.icon(
                                            icon: Icon(FlutterIcon.attention,
                                                color: FsColor.red, size: 14),
                                            label: Text(
                                              'Connect',
                                              style: TextStyle(
                                                color: FsColor.red,
                                                fontSize: 14,
                                                fontFamily: 'Gilroy-Regular',
                                              ),
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        leading: Icon(FlutterIcon.google),
                                      ),
                                      ListTile(
                                        subtitle: Container(
                                          alignment: Alignment.centerLeft,
                                          child: FlatButton.icon(
                                            icon: Icon(FlutterIcon.attention,
                                                color: FsColor.red, size: 14),
                                            label: Text(
                                              'Connect',
                                              style: TextStyle(
                                                color: FsColor.red,
                                                fontSize: 14,
                                                fontFamily: 'Gilroy-Regular',
                                              ),
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        leading: Icon(FlutterIcon.facebook),
                                      ),
                                      ListTile(
                                        subtitle: Container(
                                          alignment: Alignment.centerLeft,
                                          child: FlatButton.icon(
                                            icon: Icon(FlutterIcon.ok_circled,
                                                color: FsColor.green, size: 14),
                                            label: Text(
                                              'Connected',
                                              style: TextStyle(
                                                color: FsColor.green,
                                                fontSize: 14,
                                                fontFamily: 'Gilroy-Regular',
                                              ),
                                            ),
                                            onPressed: () {},
                                          ),
                                        ),
                                        leading: Icon(FlutterIcon.twitter),
                                      ),
                                      SizedBox(height: 55.0),
                                    ],
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
      floatingActionButton: isDone
          ? FloatingActionButton.extended(
              onPressed: () => {
                /* Navigator.push(
            context,
          new MaterialPageRoute(builder: (context) => ProfileView()),
        ),*/
                print("onPressed"),
                updateProfileEvent(),
              },
              label: Text(
                'Done',
                style: TextStyle(
                  fontFamily: 'Gilroy-Regular',
                ),
              ),
              backgroundColor: const Color(0xFF404040),
            )
          : Container(),
    );
  }

  @override
  void dispose() {
    //_fullNameNode.dispose();
    super.dispose();
  }

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

  updateProfileEvent() {
    //uploadImageApiCall();
    bool isValid = checkValidity();
    print("isValid" + isValid.toString());
    if (!isValid) {
      setState(() {
        isLoading = true;
        isDone = false;
      });
      HashMap<String, String> finalParam = prepareData();
      if (finalParam.keys.length > 0) {
        print("updateProfileEvent");
        request_type = REQUEST_TYPE.EDIT_PROFILE;
        print(request_type);
        presenter.updateProfileDetails(finalParam);
      } else if (_image != null && update_image) {
        print(request_type);
        print("updateImageEvent");
        uploadImageApiCall();
      } else if (profileData[avatar_size] == null && _image != null) {
        print("updateImageEvent");
        print(request_type);
        uploadImageApiCall();
      } else {
        setState(() {
          isLoading = false;
          isDone = true;
        });
        Toasly.warning(context, "Nothing to update",
            duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
      }
    }
  }

  @override
  void hideProgress() {}

  @override
  void onSuccess(String success) {
    setState(() {
      isLoading = false;
      isDone = true;
    });
    if (request_type == REQUEST_TYPE.EDIT_PROFILE &&
        (_image == null && !update_image)) {
      print("AfterSuccessEditFormFields" + tempProfileData.toString());
      /* Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => ProfileView()),
      );*/
      Navigator.of(context).pop({'selection': success});
    } else if (request_type == REQUEST_TYPE.EDIT_PROFILE &&
        (_image != null && update_image)) {
      print("AfterSuccessEditFormFields and now upload Image");
      uploadImageApiCall();
    } else if (request_type == REQUEST_TYPE.UPLOAD_IMAGE) {
      print("AfterSuccess upload Image");
      Navigator.of(context).pop({'selection': success});
      /* Navigator.push(
        context,
        new MaterialPageRoute(builder: (context) => ProfileView()),
      );*/
    }
    //SsoStorage.setUserProfile(tempProfileData);
  }

  @override
  void showProgress() {
    // TODO: implement showProgress
  }

  @override
  void onFailure(String failure) {
    setState(() {
      isLoading = false;
      isDone = true;
    });
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((failure))));
    print("failure" + failure);
    tempProfileData = profileData;
    // TODO: implement onFailure
  }

  @override
  void onError(String error) {
    print("error" + error);
    tempProfileData = profileData;
    setState(() {
      isLoading = false;
      isDone = true;
    });
    Toasly.error(context, AppUtils.errorDecoder(jsonDecode((error))));
  }

  prepareData() {
    HashMap<String, String> finalParam = new HashMap();
    splitFullName();
    if (profileData["first_name"] != first_name) {
      // tempProfileData["first_name"] = first_name;
      print("first_name" + first_name);
      finalParam["first_name"] = first_name;
    }
    if (profileData["last_name"] != last_name) {
      //  tempProfileData["last_name"] = last_name;
      print("last_name" + last_name);
      finalParam["last_name"] = last_name;
    }

    if (profileData["dob"] !=
        AppUtils.changeDateFormat(
            dobController.text.toString().trim(), "dd-MM-yyyy", "yyyy-MM-dd")) {
      // tempProfileData["dob"] = dobController.text.toString().trim();
      //finalParam["dob"] =AppUtils.reverseString(dobController.text.toString().trim(), "-");
      String dob = AppUtils.changeDateFormat(
          dobController.text.toString().trim(), "dd-MM-yyyy", "yyyy-MM-dd");
      if (dob != null) {
        finalParam["dob"] = dob;
      }
    }
    print("profileData[dob] ${profileData["dob"]}");
    //print("tempProfileData[dob] ${tempProfileData["dob"].toString()}");
    print("finalParam[dob] ${finalParam["dob"]}");
    if (_genter == "Male") {
      if (profileData["gender"].toString() != "M") {
        finalParam["gender"] = "M";
        //  tempProfileData["gender"] = "M";
      }
    } else if (_genter == "Female") {
      if (profileData["gender"].toString() != "F") {
        finalParam["gender"] = "F";
        // tempProfileData["gender"] = "F";
      }
    } else if (_genter == "Other") {
      if (profileData["gender"].toString() != "O") {
        finalParam["gender"] = "O";
        // tempProfileData["gender"] = "F";
      }
    }

    /*panController.text
aadhaarController.text
wedAnniversaryController.text
highEducationController.text
bloodGroupController.text */

    if (profileData["pan"] != panController.text.toString().trim()) {
      //  tempProfileData["pan"] = panController.text.toString().trim();
      finalParam["pan"] = panController.text.toString().trim();
    }
    if (profileData["aadhaar"] != aadhaarController.text.toString().trim()) {
      //  tempProfileData["aadhaar"] = aadhaarController.text.toString().trim();
      finalParam["aadhaar"] = aadhaarController.text.toString().trim();
    }
    if (profileData["wedding_anniversary"] !=
        AppUtils.changeDateFormat(
            wedAnniversaryController.text.toString().trim(),
            "dd-MM-yyyy",
            "yyyy-MM-dd")) {
      //tempProfileData["wedding_anniversary"] =          wedAnniversaryController.text.toString().trim();
      /*finalParam["wedding_anniversary"] =
          AppUtils.reverseString(wedAnniversaryController.text.toString().trim(), "-"); */

      String anniw = AppUtils.changeDateFormat(
          wedAnniversaryController.text.toString().trim(),
          "dd-MM-yyyy",
          "yyyy-MM-dd");
      if (anniw != null) {
        finalParam["wedding_anniversary"] = anniw;
      }
    }
    if ((profileData["highest_education"] != _selectedEducation) &&
        _selectedEducation != "Select") {
      //tempProfileData["highest_education"] = _selectedEducation;
      finalParam["highest_education"] = _selectedEducation;
    }
    if ((profileData["blood_group"] != _selectedBloodgroup) &&
        _selectedBloodgroup != "Select") {
      //  tempProfileData["blood_group"] = _selectedBloodgroup;
      finalParam["blood_group"] = _selectedBloodgroup;
    }

    print("finalProfileData" + finalParam.toString());
    print("tempProfileData" + tempProfileData.toString());
    print("ProfileData" + profileData.toString());
    print("dataprofile" + dataprofile.toString());
    return finalParam;
  }

  void intializeController() {
    if (profileData != null) {
      fullNameController.text = getFullname();

      first_nameController.text =
          profileData["first_name"] == null ? "" : profileData["first_name"];
      last_nameController.text =
          profileData["last_name"] == null ? "" : profileData["last_name"];
      mobileController.text =
          profileData["mobile"] == null ? "" : profileData["mobile"];
      //dobController.text = profileData["dob"] == null ? "" : profileData["dob"];

      if (profileData["dob"] == null || profileData["dob"] == "0000-00-00") {
        dobController.text = "";
      } else {
        dobController.text = AppUtils.changeDateFormat(
            profileData["dob"], "yyyy-MM-dd", "dd-MM-yyyy");
      }

      first_name = first_nameController.text;
      last_name = last_nameController.text;

      if (profileData["gender"].toString() == "M") {
        _genter = "Male";
      } else if (profileData["gender"].toString() == "F") {
        _genter = "Female";
      } else if (profileData["gender"].toString() == "O") {
        _genter = "Other";
      }

      panController.text = profileData["pan"] == null ? "" : profileData["pan"];
      aadhaarController.text =
          profileData["aadhaar"] == null ? "" : profileData["aadhaar"];
      wedAnniversaryController.text = profileData["wedding_anniversary"] == null
          ? ""
          : AppUtils.changeDateFormat(
              profileData["wedding_anniversary"], "yyyy-MM-dd", "dd-MM-yyyy");
      if (profileData["highest_education"] != null) {
        _selectedEducation = profileData["highest_education"];
      } else {
        _selectedEducation = "Select";
      }
      if (profileData["blood_group"] != null) {
        _selectedBloodgroup = profileData["blood_group"];
      } else {
        _selectedBloodgroup = "Select";
      }
      emailController.text =
          profileData["email"] == null ? "" : profileData["email"];
      genderController.text =
          profileData["gender"] == null ? "" : profileData["gender"];

      if (profileData[avatar_size] != null) {
        print("IMAGE_LINK " + profileData[avatar_size] + "?dummy=${counter++}");
        profileImageURL = profileData[avatar_size] + "?dummy=${counter++}";
      }
    }
  }

  String getFullname() {
    String fname =
        profileData["first_name"] == null ? "" : profileData["first_name"];
    String lastName =
        profileData["last_name"] == null ? "" : profileData["last_name"];
    /*  return fname == "" ? lastName : fname + " " + lastName;*/
    return fname + " " + lastName;
  }

  void splitFullName() {
    first_name = "";
    last_name = "";
    fullName = fullNameController.text.trim();
    List<String> splitString = fullName.split(" ");
    int size = splitString.length;
    if (size > 1) {
      for (int i = 0; i < size; i++) {
        if (i == 0) {
          first_name = splitString[i];
          print("first_name" + first_name);
        } else {
          if (last_name.isEmpty) {
            last_name += splitString[i];
          } else {
            last_name += " " + splitString[i];
          }
        }
      }
      print("last_name" + last_name);
    } else if (size == 1) {
      first_name = fullNameController.text;
      last_name = "";
    }
    print("first " + first_name);
    print("last " + last_name);
  }

  bool checkValidity() {
    bool isValid = false;

    if (!_formKey.currentState.validate()) {
      isValid = true;
    }

    if (fullNameController.text.trim() == null ||
        fullNameController.text.trim().isEmpty) {
      Toasly.error(context, "Name is mandatory",
          duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
      isValid = true;
    }
    /*if (mobileController.text.trim() == null) {
      Toasly.error(context, "Mobile Number is mandatory",
          duration: Duration.SHORT, gravity: Gravity.BOTTOM);
      isValid = true;
    }*/
    /*if (emailController.tex t.trim() == null) {
      Toasly.error(context, "Email is mandatory",
          duration: Duration.SHORT, gravity: Gravity.BOTTOM);
      isValid = true;
    } else*/
    if (emailController.text.trim() != null &&
        !emailController.text.trim().isEmpty) {
      if (!AppUtils.validateEmail(emailController.text.trim())) {
        Toasly.error(context, "EmailId is Invalid",
            duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
        isValid = true;
      }
    }

    if (aadhaarController.text.trim() != null &&
        !aadhaarController.text.trim().isEmpty) {
      String aadhaar = aadhaarController.text.trim();
      if (aadhaar.length < 12 || aadhaar.length > 16) {
        Toasly.error(context, "Aaadhaar no is Invalid",
            duration: DurationToast.SHORT, gravity: Gravity.BOTTOM);
        isValid = true;
      }
    }
    return isValid;
  }

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
    //if(_image.)
    if (_image != null) {
      update_image = true;
    }
    imagePicker = null;
    setState(() {
      isImageDialog = false;
      profileData[avatar_size] = null;
      profileImageURL = null;
      this._image = _image;
    });
    // print("userImage FROM"+ );
    print("userImage Successful");
    //print("userImage Path " + _image.path);
    //throw UnimplementedError();
  }

  void uploadImageApiCall() {
    setState(() {
      isLoading = true;
      isDone = false;
    });
    request_type = REQUEST_TYPE.UPLOAD_IMAGE;
    presenter = new ProfilePresenter(this);
    presenter.uploadProfileImage(accessToken, _image);
  }

  @override
  void onProfileProgress(String success) {
    // TODO: implement onProfileProgress
  }

  void uploadImageEvent(String upload_image_type) {
    if (upload_image_type == "Gallery") {
      openGallery();
    } else if (upload_image_type == "Camera") {
      openCamera();
    }
  }

/* String changeDateFormat1(String date, String toFormat) {
    String formatter;
    try {
      //var now =DateTime.parse(date);
      DateTime now = DateTime.parse(date);
      print("nowwww" + now.toString());
      var formatted = new DateFormat(toFormat);
      print("formatteddddd" + formatted.toString());
      formatter = formatted.format(now);

      //formatter = DateFormat(toFormat).format(DateTime.parse(date)); // new DateFormat('yyyy-MM-dd');
      //formatted = formatter.format(now);
      print("formatter" + formatter);
    } catch (e) {
      print("in side Exception");
      print(e.toString());
    }
    print("formatted ${date} to ${formatter} using ${toFormat}");
    return formatter;
  }

  String changeDateFormat(String date, String fromFormat, String toFormat) {
    String dateInString;
    try {
      DateFormat inputFormat = DateFormat(fromFormat);
      DateTime dateTime = inputFormat.parse(date);
      DateFormat outputFormat = DateFormat(toFormat);
      dateInString = outputFormat.format(dateTime);
      print("formatter" + dateInString);
    } catch (e) {
      print("in side Exception");
      print(e.toString());
    }
    print("formatted ${date} to ${dateInString} using ${toFormat}");
    return dateInString;
  }*/
}

enum REQUEST_TYPE { EDIT_PROFILE, UPLOAD_IMAGE }
enum UPLOAD_IMAGE_TYPE { GALLERY, CAMERA }
