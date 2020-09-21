import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/custom_text_field.dart';
import 'package:uuid/uuid.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // Initializing input controllers
  TextEditingController _fNameController;
  TextEditingController _lNameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  TextEditingController _confPasswordController;

  // Initializing the image picker
  final picker = ImagePicker();

  // Initializing variables and files
  String base64Image;
  File tmpFile;
  File _image;
  String fileName;
  var uuid = Uuid(); // Used to generate a user random unique id

  void initState() {
    super.initState();
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confPasswordController = TextEditingController();
  }

  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confPasswordController.dispose();
    super.dispose();
  }

  Future chooseImage() async {
    var imageFile = await picker.getImage(
        source: ImageSource.gallery, maxWidth: 500, maxHeight: 500);

    final tempDir = await getTemporaryDirectory();
    final path = tempDir.path;

    int rand = Math.Random().nextInt(100000);

    Img.Image image = Img.decodeImage(File(imageFile.path).readAsBytesSync());
    Img.Image smallerImg = Img.copyResize(image, width: 250);

    var compressImg = new File("$path/image_$rand.jpg")
      ..writeAsBytesSync(Img.encodeJpg(smallerImg, quality: 85));

    setState(() {
      _image = compressImg;
      tmpFile = _image;
      base64Image = base64Encode(_image.readAsBytesSync());
    });
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            child: Stack(children: [
              Image.asset(
                'assets/images/logo.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ]),
            width: double.infinity,
            height: double.infinity,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 40, 0, 0),
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.keyboard_backspace,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Center(
                  child: InkWell(
                    onTap: chooseImage,
                    child: Card(
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: (_image == null)
                          ? Container(
                              width: 125,
                              height: 125,
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  size: 35,
                                ),
                              ),
                            )
                          : Container(
                              width: 125,
                              height: 125,
                              child: Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
                            ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      elevation: 2,
                      margin: EdgeInsets.all(10),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      queryData.size.width / 7, 0, queryData.size.width / 7, 0),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        customTextField(
                            context,
                            'First Name',
                            Icon(Icons.portrait, color: FsColor.primaryrecipe),
                            false,
                            _fNameController),
                        SizedBox(
                          height: 5,
                        ),
                        customTextField(
                            context,
                            'Last Name',
                            Icon(Icons.portrait, color: FsColor.primaryrecipe),
                            false,
                            _lNameController),
                        SizedBox(
                          height: 5,
                        ),
                        customTextField(
                            context,
                            'Email',
                            Icon(Icons.mail, color: FsColor.primaryrecipe),
                            false,
                            _emailController),
                        SizedBox(
                          height: 5,
                        ),
                        customTextField(
                            context,
                            'Password',
                            Icon(Icons.lock, color: FsColor.primaryrecipe),
                            true,
                            _passwordController),
                        SizedBox(
                          height: 5,
                        ),
                        customTextField(
                            context,
                            'Confirm Password',
                            Icon(Icons.lock, color: FsColor.primaryrecipe),
                            true,
                            _confPasswordController),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                          elevation: 2,
                          padding: EdgeInsets.symmetric(
                              horizontal: 100, vertical: 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0)),
                          color: FsColor.primaryrecipe,
                          textColor: Colors.white,
                          child: Text(
                            'Sign Up'.toUpperCase(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            if (_fNameController.value.text.isNotEmpty &&
                                _lNameController.value.text.isNotEmpty &&
                                _emailController.value.text.isNotEmpty &&
                                _passwordController.value.text.isNotEmpty &&
                                _confPasswordController.value.text.isNotEmpty) {
                              if (EmailValidator.validate(
                                  _emailController.value.text)) {
                                if (_passwordController.value.text ==
                                    _confPasswordController.value.text) {
                                  if (null == tmpFile) {
                                    print('No Image Provided');
                                  } else {
                                    setState(() {
                                      fileName = tmpFile.path.split('/').last;
                                    });
                                  }
                                  if (base64Image != null && fileName != null) {
                                    await HttpService.registerUser(
                                            uuid.v1(),
                                            _fNameController.value.text,
                                            _lNameController.value.text,
                                            _emailController.value.text,
                                            _passwordController.value.text,
                                            base64Image,
                                            fileName)
                                        .then((value) {
                                      Fluttertoast.showToast(msg: value);
                                      Navigator.pop(context);
                                    });
                                  } else {
                                    await HttpService.registerUser(
                                            uuid.v1(),
                                            _fNameController.value.text,
                                            _lNameController.value.text,
                                            _emailController.value.text,
                                            _passwordController.value.text,
                                            '',
                                            '')
                                        .then((value) {
                                      Fluttertoast.showToast(msg: value);
                                      Navigator.pop(context);
                                    });
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: 'Password doesn\'t match!',
                                      toastLength: Toast.LENGTH_SHORT,
                                      timeInSecForIosWeb: 1);
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'Email is not valid!',
                                    toastLength: Toast.LENGTH_SHORT,
                                    timeInSecForIosWeb: 1);
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: 'Please fill all fields!',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 1);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget registerButton(
      BuildContext context, String text, Image image, Color color) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      onPressed: () {},
      padding: EdgeInsets.all(6),
      color: color,
      textColor: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            child: image,
            maxRadius: 15,
            backgroundColor: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Text(text.toUpperCase(), style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  Widget divider() {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        child: Divider(
          thickness: 1,
          color: Colors.black,
          height: 36,
        ),
      ),
    );
  }
}
