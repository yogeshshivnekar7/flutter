import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/gallery/gallery_photolist.dart';
import 'package:sso_futurescape/presentor/module/chsone/gallery/album_view.dart';
import 'package:sso_futurescape/presentor/module/chsone/gallery/list_album_presenter.dart';
import 'package:sso_futurescape/ui/module/chsone/myflats_dashboard.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/storage/complex.dart';
import 'package:common_config/utils/toast/toast.dart';

class GalleryAlbumList extends StatefulWidget {
  var currentUnit;

  GalleryAlbumList(this.currentUnit);
  @override
  _GalleryAlbumListState createState() =>
      new _GalleryAlbumListState(this.currentUnit);
}

class _GalleryAlbumListState extends State<GalleryAlbumList>
    implements AlbumListView {
  ListAlbumPresenter presentor;
  // List complaints = [];
  List albums = [];
  var newAlbumName = "";
  var currentUnit;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  var metadata;

  _GalleryAlbumListState(this.currentUnit);

  @override
  void initState() {
    presentor = new ListAlbumPresenter(this);
    super.initState();
    _getAlbums();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (metadata == null ||
            metadata['last_page'] != metadata['current_page']) {
          String currentPage =
              metadata == null || metadata['current_page'].toString() == null
                  ? '1'
                  : (metadata['current_page'] + 1).toString();
          _getAlbums(currentPage: currentPage);
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
          'Albums'.toLowerCase(),
          style: FSTextStyle.appbartextlight,
        ),
        elevation: 0.0,
        backgroundColor: FsColor.primaryflat,
        leading: FsBackButtonlight(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.perm_media),
        onPressed: () {
          _createAlbumDialog();
        },
        backgroundColor: FsColor.primaryflat,
      ),
      body: isLoading
          ? PageLoader()
          : (albums.length != 0)
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
                            itemCount: albums == null ? 0 : albums.length,
                            itemBuilder: (BuildContext context, int index) {
                              Map album = albums[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Card(
                                  elevation: 0.0,
                                  clipBehavior: Clip.antiAlias,
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
                                                child: (album["photos"]
                                                            ["album_path"] !=
                                                        "")
                                                    ? Image.network(
                                                        '${album["photos"]["album_path"]}',
                                                        fit: BoxFit.cover,
                                                        alignment:
                                                            Alignment.center,
                                                      )
                                                    : Icon(Icons.folder,
                                                        size: 75,
                                                        color:
                                                            Color(0xFF8f8f8f))),
                                          ),
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
                                                Expanded(
                                                  child: Text(
                                                    '${album["name"]}'
                                                        .toLowerCase(),
                                                    style: TextStyle(
                                                        fontSize:
                                                            FSTextStyle.h6size,
                                                        fontFamily:
                                                            'Gilroy-SemiBold',
                                                        color:
                                                            FsColor.darkgrey),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  width: 32,
                                                  child: FlatButton(
                                                      padding:
                                                          EdgeInsets.all(0),
                                                      onPressed: () {
                                                        _deleteAlbumConfirmationDialog(
                                                            album["id"]);
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
                                    onTap: () async {
                                      var result = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GalleryPhotoList(
                                                  currentUnit, album['id']),
                                        ),
                                      );
                                      if (result != null) {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        this.widget));
                                      }
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
              : Center(child: Text("no albums created")),
    );
  }

  void _deleteAlbumConfirmationDialog(albumid) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Column(
            children: [
              Text(
                "Do you want to delete this album".toLowerCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontFamily: 'Gilroy-SemiBold',
                    fontSize: FSTextStyle.h4size,
                    color: FsColor.darkgrey),
              ),
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
                          _deleteAlbums([albumid]);
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

  void _createAlbumDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(20),
          title: Column(
            children: [
              Text("Enter Details to Add Album".toLowerCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Gilroy-SemiBold',
                      fontSize: FSTextStyle.h5size,
                      color: FsColor.darkgrey)),
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
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 15.0),
                    child: TextField(
                        decoration: InputDecoration(
                            labelText: "Enter Album Name".toLowerCase(),
                            labelStyle: TextStyle(
                                fontFamily: 'Gilroy-Regular',
                                color: FsColor.darkgrey.withOpacity(0.85)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: FsColor.basicprimary))),
                        onChanged: (text) {
                          newAlbumName = text;
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        child: new Text(
                          "Cancel",
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
                          "Save",
                          style: TextStyle(
                              fontFamily: 'Gilroy-SemiBold',
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.white),
                        ),
                        color: FsColor.basicprimary,
                        onPressed: () {
                          Navigator.of(context).pop();
                          createAlbum(newAlbumName);
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

  void _deleteAlbums(albumids, {currentPage}) {
    if (currentPage == null || currentPage == 1) {
      isLoading = true;
    }
    try {
      presentor.deleteAlbums(currentUnit, albumids, loadPage: currentPage);
    } catch (e) {
      print(e);
    }
  }

  void createAlbum(name, {currentPage}) {
    if (currentPage == null || currentPage == 1) {
      isLoading = true;
    }
    try {
      presentor.createAlbum(name, loadPage: currentPage);
    } catch (e) {
      print(e);
    }
  }

  void _getAlbums({currentPage}) {
    if (currentPage == null || currentPage == 1) {
      isLoading = true;
    }
    try {
      presentor.getAlbumList(currentUnit, loadPage: currentPage);
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
  void onSuccessListAlbum(metadata, response) {
    if (this.albums == null) {
      this.albums = [];
    }
    this.albums.addAll(response);
    isLoading = false;
    this.metadata = metadata;
    setState(() {});
  }

  @override
  void onSuccessDeleteAlbum(deletedAlbumIds) {
    this.albums.removeWhere((a) => deletedAlbumIds.contains(a['id']));
    print(deletedAlbumIds);
    print(this.albums);
    Toasly.success(context, "Album has been deleted successfully",
        gravity: Gravity.CENTER);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MyFlatsDashboard(currentUnit),
    //   ),
    // );
    isLoading = false;
    setState(() {});
  }

  @override
  void onSuccessCreateAlbum(response) {
    this.albums.add(response);
    isLoading = false;
    setState(() {});
    Toasly.success(context, "Album has been created successfully",
        gravity: Gravity.CENTER);
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => MyFlatsDashboard(currentUnit),
    //   ),
    // );
  }
}

// abstract class MyAlbumListView {
//   void onSuccessProperies(var successs);

//   void onActionSuccessProperies(var successs);

//   void onFailedProperties(var failed);

//   void onActionFailedProperties(var failed);
// }
