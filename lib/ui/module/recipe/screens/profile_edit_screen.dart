import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math' as Math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as Img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/recipe/screens/login_screen.dart';
import 'package:sso_futurescape/ui/module/recipe/services/http_service.dart';
import 'package:sso_futurescape/ui/module/recipe/widgets/shimmer.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';

  final Function retrieveData;

  EditProfileScreen({this.retrieveData});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
/*final FacebookLogin _facebookLogin = new FacebookLogin();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _fNameController;

  TextEditingController _lNameController;
  TextEditingController _emailController;
  TextEditingController _passwordController;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();
  TextEditingController _resetOldPasswordController;
  TextEditingController _resetNewPasswordController;
  TextEditingController _resetNewConfPasswordController;

  final picker = ImagePicker();

  String _id, image;
  String status = '';
  String _base64Image;
  File _tmpFile;
  String _errMessage = 'Error Uploading Image';
  File _image;
  String _path = HttpService.USER_IMAGES_PATH;
  bool _enabled = true;

  @override
  void initState() {
    super.initState();
    _fNameController = TextEditingController();
    _lNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _resetOldPasswordController = TextEditingController();
    _resetNewPasswordController = TextEditingController();
    _resetNewConfPasswordController = TextEditingController();

    // Get the first name, last name, email and image of the user
    getUserInfo();
  }

  Future getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _id = prefs.getString('id').toString();
    if (_id != 'null') {
      await HttpService.getUserInfo(_id).then((value) {
        setState(() {
          if (value != null) {
            _fNameController.text = value.fname;
            _lNameController.text = value.lname;
            _emailController.text = value.email;
            _passwordController.text = value.password;
            image = value.image;
          }
        });
      });
    } else if (await _googleSignIn.isSignedIn()) {
      _auth.currentUser().then((value) {
        setState(() {
          _enabled = false;
          _emailController.text = value.email;
          List name = value.displayName.split(" ");
          _fNameController.text = name[0];
          _lNameController.text = name[1];
          _passwordController.text = null;
          image = value.photoUrl;
        });
      });
    } else if (await _facebookLogin.isLoggedIn) {
      _facebookLogin.currentAccessToken.then((value) async {
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture.width(800).height(800),first_name,last_name,email&access_token=${value.token}');
        final profile = await json.decode(graphResponse.body);
        setState(() {
          _enabled = false;
          _fNameController.text = profile['first_name'];
          _lNameController.text = profile['last_name'];
          _emailController.text = profile['email'];
          _passwordController.text = null;
          image = profile['picture']['data']['url'];
        });
      });
    }
  }

  void dispose() {
    _fNameController.dispose();
    _lNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  setStatus(String message) {
    setState(() {
      status = message;
    });
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
      _tmpFile = _image;
      _base64Image = base64Encode(_image.readAsBytesSync());
    });
    setStatus('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              if (prefs.getString('id') != null) {
                prefs.remove('id');
                prefs.remove('email');
                prefs.remove('fname');
                prefs.remove('lname');
                prefs.remove('image');
                Navigator.of(context).pushNamedAndRemoveUntil(
                    LoginScreen.routeName, (Route<dynamic> route) => false);
              } else if (await _googleSignIn.isSignedIn()) {
                await _auth.signOut().then((_) {
                  _googleSignIn.signOut();
                  prefs.remove('uid');
                  prefs.remove('email');
                  prefs.remove('fname');
                  prefs.remove('lname');
                  prefs.remove('image');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.routeName, (Route<dynamic> route) => false);
                });
              } else if (await _facebookLogin.isLoggedIn) {
                await _auth.signOut().then((_) {
                  _facebookLogin.logOut();
                  prefs.remove('uid');
                  prefs.remove('email');
                  prefs.remove('fname');
                  prefs.remove('lname');
                  prefs.remove('image');
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      LoginScreen.routeName, (Route<dynamic> route) => false);
                });
              }
            },
          ),
        ],
        title: Text(
          'Edit Profile'.toUpperCase(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                (_image == null)
                    ? (image != null)
                        ? (image.contains(
                                    'https://platform-lookaside.fbsbx.com') ||
                                image.contains(
                                    'https://lh3.googleusercontent.com'))
                            ? CachedNetworkImage(
                                imageUrl: '$image',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover)),
                                ),
                                placeholder: (context, url) => ShimmerWidget(
                                    width: 100, height: 100, circular: true),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                            : CachedNetworkImage(
                                imageUrl: '$_path$image',
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  width: 100.0,
                                  height: 100.0,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                placeholder: (context, url) => ShimmerWidget(
                                    width: 100, height: 100, circular: true),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              )
                        : CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[100],
                                child:
                                    Image.asset('assets/images/logo_user.png')),
                            radius: 50,
                          )
                    : CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: FileImage(_image),
                        radius: 50,
                      ),
                SizedBox(width: 25),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FlatButton(
                        padding: EdgeInsets.symmetric(horizontal: 22),
                        child: Text('Upload new image'),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))),
                        onPressed: () => _enabled
                            ? chooseImage()
                            : Fluttertoast.showToast(
                                msg:
                                    'This option isn\'t available with your current authentication'),
                        color: Colors.grey[100]),
                    FlatButton(
                      padding: EdgeInsets.symmetric(horizontal: 39),
                      child: Text('Delete image'),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      onPressed: () {
                        if (_enabled) {
                          setState(() {
                            image = null;
                            HttpService.deleteUserImage(_id);
                          });
                        } else {
                          Fluttertoast.showToast(
                              msg:
                                  'This option isn\'t available with your current authentication');
                        }
                      },
                      color: Colors.grey[100],
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 50),
            customTextField(context, _enabled, _fNameController, 'First Name'),
            SizedBox(height: 10),
            customTextField(context, _enabled, _lNameController, 'Last Name'),
            SizedBox(height: 10),
            customTextField(context, false, _emailController, 'Email'),
            SizedBox(height: 10),
            customPasswordTextField(
                context, _enabled, _passwordController, 'Password'),
            SizedBox(height: 50),
            FlatButton(
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13.0)),
              color: FsColor.primaryrecipe,
              textColor: Colors.white,
              child: Text(
                'Save Changes',
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
              ),
              onPressed: () async {
                if (_fNameController.value.text != null &&
                    _lNameController.value.text != null &&
                    _emailController.value.text != null) {
                  String fileName;

                  if (null == _tmpFile) {
                    setStatus(_errMessage);
                    _base64Image = '';
                    fileName = image;
                  } else {
                    fileName = _tmpFile.path.split('/').last;
                  }

                  await HttpService.updateUserInfo(
                      _id,
                      _fNameController.value.text.trim(),
                      _lNameController.value.text.trim(),
                      _base64Image,
                      fileName);

                  await widget.retrieveData();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget customTextField(BuildContext context, bool enabled,
      TextEditingController controller, String label) {
    return TextField(
      enabled: enabled,
      controller: controller,
      style:
          TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 17),
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, fontFamily: 'Raleway')),
    );
  }

  Widget customPasswordTextField(BuildContext context, bool enabled,
      TextEditingController controller, String label) {
    return TextField(
        enabled: enabled,
        obscureText: true,
        readOnly: true,
        showCursor: false,
        controller: controller,
        style:
            TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 17),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontSize: 16, fontFamily: 'Raleway'),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.edit,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                        contentPadding: EdgeInsets.only(bottom: 20),
                        title: Text(
                          'CHANGE PASSWORD',
                          style: TextStyle(fontSize: 16),
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                              child: Text(
                                'Please enter your old and new password',
                                style: TextStyle(
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: customChangePassTextField(
                                  context,
                                  'Old Password',
                                  Icon(Icons.lock,
                                      color: FsColor.primaryrecipe),
                                  false,
                                  _resetOldPasswordController),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: customChangePassTextField(
                                  context,
                                  'New Password',
                                  Icon(Icons.lock, color: FsColor
                                      .primaryrecipe),
                                  false,
                                  _resetNewPasswordController),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 7),
                              child: customChangePassTextField(
                                  context,
                                  'Confirm New Password',
                                  Icon(Icons.mail, color: FsColor
                                      .primaryrecipe),
                                  false,
                                  _resetNewConfPasswordController),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            RaisedButton(
                              onPressed: () async {
                                if (_resetNewPasswordController.value.text ==
                                    _resetNewConfPasswordController
                                        .value.text) {
                                  await HttpService.changePassword(
                                    _id,
                                    _resetOldPasswordController.value.text,
                                    _resetNewPasswordController.value.text,
                                  ).then((value) {
                                    Fluttertoast.showToast(msg: '$value');
                                    if (value ==
                                        'Password Updated Successfully')
                                      Navigator.pop(context);
                                  });
                                } else {
                                  Fluttertoast.showToast(
                                      msg:
                                          'New password and confirmation password does not match');
                                }
                              },
                              color: FsColor.primaryrecipe,
                              child: Text(
                                'RESET',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ));
            },
          ),
        ));
  }

  Widget customChangePassTextField(BuildContext context, String text, Icon icon,
      bool obscure, TextEditingController controller) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
        side: BorderSide(color: FsColor.primaryrecipe),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscure,
        cursorColor: Colors.black,
        style:
            TextStyle(color: Colors.black, fontFamily: 'Raleway', fontSize: 17),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 1),
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
          labelText: text,
          labelStyle: TextStyle(
              color: Colors.black, fontFamily: 'Raleway', fontSize: 15),
          floatingLabelBehavior: FloatingLabelBehavior.never,
        ),
      ),
    );
  }*/
}
