import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerHandler {
  //ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;

  ImagePickerHandler(this._listener, this._controller);

  openCamera() async {
    print("openCamera");
    // imagePicker.dismissDialog();
    var image = await ImagePicker.pickImage(
        source: ImageSource.camera,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 85);
    _listener.userImage(image);
    print("userImagePickerHandler");
    //cropImage(image);
  }

  openGallery() async {
    print("openGallery");
    //imagePicker.dismissDialog();
    var image = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 480,
        maxWidth: 640,
        imageQuality: 85);
    _listener.userImage(image);
    // cropImage(image);
  }

/*void init() {
    imagePicker = new ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }*/

/*Future cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      ratioX: 1.0,
      ratioY: 1.0,
      maxWidth: 512,
      maxHeight: 512,
    );
    _listener.userImage(croppedFile);
  }*/

/* showDialog(BuildContext context) {
    imagePicker.getImage(context);
  }*/
}

abstract class ImagePickerListener {
  userImage(File _image);
}
