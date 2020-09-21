import 'dart:convert';
import 'dart:io';

import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/gallery/list_photo_presenter.dart';
import 'package:sso_futurescape/presentor/module/chsone/gallery/photos_view.dart';
import 'package:sso_futurescape/ui/module/sso/profile/utils/image_picker_handler.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/permission/permission_service.dart';

class GalleryPhotoList extends StatefulWidget {
  var albumid;
  var currentUnit;

  GalleryPhotoList(this.currentUnit, this.albumid);

  @override
  _GalleryPhotoListState createState() =>
      new _GalleryPhotoListState(this.currentUnit, this.albumid);
}

class _GalleryPhotoListState extends State<GalleryPhotoList>
    implements PhotoListView, ImagePickerListener {
  AnimationController _controller;
  ListPhotoPresenter presentor;
  REQUEST_TYPE request_type;
  UPLOAD_IMAGE_TYPE upload_image_type;
  bool isDone = true;
  String imageFrom = "gallery";
  File _image = null;
  bool update_image = false;
  bool isImageDialog = false;
  ImagePickerHandler imagePicker;
  List uploadimage = [
    {
      "name": "Camera",
      "img": "images/camera.png",
    },
    {
      "name": "Gallery",
      "img": "images/gallery.png",
    },
    // {n
    //   "name": "Drive",
    //   "img": "images/drive.png",
    // }
  ];
  var photos = [];
  var albumid;
  var currentUnit;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  var metadata;
  _GalleryPhotoListState(this.currentUnit, this.albumid);

  @override
  void initState() {
    presentor = new ListPhotoPresenter(this);
    super.initState();
    _getPhotos();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (metadata == null ||
            metadata['last_page'] != metadata['current_page']) {
          String currentPage =
              metadata == null || metadata['current_page'].toString() == null
                  ? '1'
                  : (metadata['current_page'] + 1).toString();
          _getPhotos(currentPage: currentPage);
        }
      }
    });
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // primaryColor: FsColor.primaryflat,
      appBar: AppBar(
        title: Text(
          'Photos'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 0.0,
        backgroundColor: FsColor.primaryflat,
        leading: FsBackButtonlight(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.image),
        onPressed: () {
          _uploadImageDialog(albumid);
        },
        backgroundColor: FsColor.primaryflat,
      ),
      body: isLoading
          ? PageLoader()
          : (photos.length != 0)
              ? ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  MediaQuery.of(context).size.width < 767
                                      ? 2
                                      : 4,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                              // childAspectRatio: MediaQuery.of(context).size.width < 767 ? 1.25:2,
                              // childAspectRatio: MediaQuery.of(context).size.width / (MediaQuery.of(context).size.height / 1.5),
                            ),
                            primary: false,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: photos == null ? 0 : photos.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map photo = photos[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Card(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(4.0),
                                    ),
                                    side: BorderSide(
                                        color: Color(0xFFdadce0), width: 1.0),
                                  ),
                                  child: InkWell(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Expanded(
                                              child: Container(
                                            width: double.infinity,
                                            child: Image.network(
                                              '${photo["image"]}',
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                            ),
                                          )),
                                          Container(
                                            height: 48,
                                            alignment: Alignment.center,
                                            color: FsColor.white,
                                            padding: EdgeInsets.fromLTRB(
                                                10, 10, 5, 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 32,
                                                  child: FlatButton(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      onPressed: () {
                                                        _deletePhotoConfirmationDialog(
                                                            photo["id"]);
                                                      },
                                                      child: Icon(
                                                          Icons.delete_outline,
                                                          color: FsColor.red,
                                                          size: 18)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) =>
                                      //     GestureDetector(
                                      //       onVerticalDragUpdate: (dragUpdateDetails) {
                                      //         Navigator.of(context).pop();
                                      //       },
                                      //       behavior: HitTestBehavior.opaque,
                                      //       child: PhotoView(
                                      //       imageProvider: NetworkImage("${photo["image"]}"),
                                      //       ),
                                      //     ),
                                      //   ),
                                      // );

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => GestureDetector(
                                            behavior:
                                                HitTestBehavior.translucent,
                                            child: Stack(
                                              children: [
                                                PhotoView(
                                                  imageProvider: NetworkImage(
                                                      "${photo["image"]}"),
                                                ),
                                                Positioned(
                                                  right: 0,
                                                  top: 0,
                                                  child: Container(
                                                    width: 44,
                                                    height: 44,
                                                    alignment: Alignment.center,
                                                    color: FsColor.red,
                                                    child: FlatButton(
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                              5, 10, 5, 10),
                                                      child: Icon(
                                                        Icons.close,
                                                        size: 24,
                                                        color: FsColor.white,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => PhotoView(
                                      //       imageProvider: NetworkImage("${photo["image"]}"),
                                      //     ),
                                      //   ),
                                      // );
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Center(child: Text("no photos added")),
    );
  }

  void _deletePhotoConfirmationDialog(photoid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                "Do you want to delete this photo".toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey),
              )
            ],
          ),
          shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(7.0),
          ),
          content: SingleChildScrollView(
            child: Container(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: new Text(
                          "No",
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.darkgrey),
                        ),
                        onPressed: () {
                          Navigator.of(context, rootNavigator: true)
                              .pop('dialog');
                        },
                      ),
                      RaisedButton(
                        child: new Text(
                          "Yes",
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.white),
                        ),
                        color: FsColor.basicprimary,
                        onPressed: () {
                          Navigator.of(context).pop();
                          _deletePhotos([photoid]);
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _deletePhotos(photoids, {currentPage}) {
    if (currentPage == null || currentPage == 1) {
      isLoading = true;
    }
    try {
      presentor.deletePhotos(currentUnit, photoids, loadPage: currentPage);
    } catch (e) {
      print(e);
    }
  }

  void _uploadImageDialog(albumid) {
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
                                  uploadImageEvent(albumid, upload["name"]);
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

  openCamera() {
    //if (imagePicker == null) {
    PermissionsService1 permissionsService1 = new PermissionsService1();
    permissionsService1.requestCameraPermission().then((value) {
      if (value) {
        imagePicker = null;
        imagePicker = new ImagePickerHandler(this, _controller);
        //}
        imagePicker.openCamera();
      } else {
        PermissionsService1 permissionsService1 = new PermissionsService1();
        permissionsService1.showPermissionCameraAlertDialog(context);
      }
    });
  }

  openGallery() {
    PermissionsService1 permissionsService1 = new PermissionsService1();
    permissionsService1.requestPhotosPermission().then((value) {
      if (value) {
        imagePicker = null;
        imagePicker = new ImagePickerHandler(this, _controller);
        //}
        imagePicker.openGallery();
      } else {
        PermissionsService1 permissionsService1 = new PermissionsService1();
        permissionsService1.showPermissionPhotosAlertDialog(context);
      }
    });
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
      // profileData[avatar_size] = null;
      // profileImageURL = null;
      this._image = _image;
    });
    // print("userImage FROM"+ );
    // print(_image.name);
    if (_image != null) {
      print("userImage Successful");
      uploadImageApiCall();
    }

    //print("userImage Path " + _image.path);
    //throw UnimplementedError();
  }

  void uploadImageApiCall() {
    setState(() {
      isLoading = true;
      isDone = false;
    });
    request_type = REQUEST_TYPE.UPLOAD_IMAGE;
    presentor = new ListPhotoPresenter(this);
    presentor.uploadImage(albumid, _image);
  }

  void uploadImageEvent(albumid, String upload_image_type) {
    if (upload_image_type == "Gallery") {
      openGallery();
    } else if (upload_image_type == "Camera") {
      openCamera();
    }
  }

  void _getPhotos({currentPage}) {
    if (currentPage == null || currentPage == 1) {
      isLoading = true;
    }
    try {
      presentor.getPhotoList(currentUnit, albumid, loadPage: currentPage);
    } catch (e) {
      print(e);
    }
  }

  @override
  void onError(response) {
    var msg = "something went wrong. please try again.";
    if (jsonDecode(response)['error'] != null) {
      msg = jsonDecode(response)['error'];
    }
    Toasly.error(context, msg, gravity: Gravity.BOTTOM);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void onFailure(response) {
    var msg = "something went wrong. please try again.";
    if (jsonDecode(response)['error'] != null) {
      msg = jsonDecode(response)['error'];
    }
    Toasly.error(context, msg, gravity: Gravity.BOTTOM);
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void onSuccessDeletePhoto(deletedPhotoIds) {
    this.photos.removeWhere((a) => deletedPhotoIds.contains(a['id']));
    print(deletedPhotoIds);
    print(this.photos);
    if (this.photos.length == 0) {
      Navigator.pop(context, {'reload': true});
    }
    isLoading = false;
    setState(() {});
  }

  @override
  void onSuccessListPhoto(metadata, response) {
    if (this.photos == null) {
      this.photos = [];
    }
    if (metadata == null) {
      metadata = [];
    }
    this.photos.addAll(response);
    print(metadata);
    print(this.photos.length);
    if (this.photos.length == 1 && metadata[0] == 'goToMainPage') {
      isLoading = false;
      Navigator.pop(context, {'reload': true});
    }
    isLoading = false;
    this.metadata = metadata;
    setState(() {});
  }

  @override
  void onSuccessAddPhoto(metadata, response) {
    if (this.photos == null) {
      this.photos = [];
    }
    this.photos.addAll(response);
    isLoading = false;
    // this.metadata = metadata;
    setState(() {});
  }
}

enum REQUEST_TYPE { EDIT_PROFILE, UPLOAD_IMAGE }
enum UPLOAD_IMAGE_TYPE { GALLERY, CAMERA }
