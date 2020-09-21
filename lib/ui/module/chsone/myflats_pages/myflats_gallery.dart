import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/chsone/gallery/gallery_albumlist.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/utils/app_utils.dart';

class MyFlatsGallery extends StatefulWidget {
  var flatsGallery;
  var currentUnit;
  MyFlatsGallery(this.flatsGallery, this.currentUnit);

  @override
  _MyFlatsGalleryState createState() =>
      new _MyFlatsGalleryState(this.flatsGallery, this.currentUnit);
}

class _MyFlatsGalleryState extends State<MyFlatsGallery> {
  var flatsGallery;
  var currentUnit;
  bool isFlatsGallery = false;

  _MyFlatsGalleryState(this.flatsGallery, this.currentUnit);

  @override
  void initState() {
    initializeData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: Container(
          child: Column(
        children: <Widget>[
          !isFlatsGallery
              ? Container()
              : Container(
                  child: Card(
                    elevation: 3.0,
                    key: null,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/dash-bg.jpg"),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                            width: 1.0,
                            color: FsColor.darkgrey.withOpacity(0.5)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Gallery".toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.dashtitlesize,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.primaryflat),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // RaisedButton(
                                //   elevation: 1.0,
                                //   shape: new RoundedRectangleBorder(
                                //     borderRadius:
                                //         new BorderRadius.circular(4.0),
                                //   ),
                                //   onPressed: () async {
                                //     var result = await Navigator.push(
                                //       context,
                                //       MaterialPageRoute(
                                //         builder: (context) => GalleryPhotoList(
                                //             currentUnit,
                                //             flatsGallery['album_id']),
                                //       ),
                                //     );
                                //     if (result != null) {
                                //       Navigator.pushReplacement(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (BuildContext context) =>
                                //                   MyFlatsDashboard(
                                //                       currentUnit)));
                                //     }
                                //   },
                                //   color: FsColor.primaryflat,
                                //   padding: EdgeInsets.symmetric(
                                //       vertical: 10.0, horizontal: 10.0),
                                //   child: Text(
                                //     "View",
                                //     style: TextStyle(
                                //         fontSize: FSTextStyle.h6size,
                                //         fontFamily: 'Gilroy-Bold',
                                //         color: FsColor.white),
                                //   ),
                                // ),
                                SizedBox(width: 10),
                                Flexible(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "",
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: FsColor.basicprimary.withOpacity(0.2)),
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "".toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.lightgrey),
                                      ),
                                      Text(
                                        "".toString(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: GestureDetector(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GalleryAlbumList(currentUnit),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "View All",
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                fontFamily: 'Gilroy-SemiBold',
                                                color: FsColor.darkgrey),
                                          ),
                                          SizedBox(width: 10.0),
                                          Icon(FlutterIcon.right_big,
                                              color: FsColor.darkgrey,
                                              size: FSTextStyle.h6size),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  alignment: Alignment.center,
                ),
          isFlatsGallery
              ? Container()
              : Container(
                  child: Card(
                    elevation: 3.0,
                    key: null,
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/dash-bg.jpg"),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(
                            width: 1.0,
                            color: FsColor.darkgrey.withOpacity(0.5)),
                      ),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Gallery".toLowerCase(),
                                  style: TextStyle(
                                      fontSize: FSTextStyle.dashtitlesize,
                                      fontFamily: 'Gilroy-SemiBold',
                                      color: FsColor.primaryflat),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                // RaisedButton(
                                //   elevation: 1.0,
                                //   shape: new RoundedRectangleBorder(
                                //     borderRadius:
                                //         new BorderRadius.circular(4.0),
                                //   ),
                                //   onPressed: () => {
                                //     print("object"),
                                //     Navigator.push(
                                //       context,
                                //       new MaterialPageRoute(
                                //         builder: (context) =>
                                //             GalleryAlbumList({}),
                                //       ),
                                //     )
                                //   },
                                //   color: FsColor.primaryflat,
                                //   padding: EdgeInsets.symmetric(
                                //       vertical: 10.0, horizontal: 10.0),
                                //   child: Text(
                                //     "Create",
                                //     style: TextStyle(
                                //         fontSize: FSTextStyle.h6size,
                                //         fontFamily: 'Gilroy-Bold',
                                //         color: FsColor.white),
                                //   ),
                                // ),
                                SizedBox(width: 10),
                                Flexible(
                                    child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(
                                      "".toLowerCase(),
                                      style: TextStyle(
                                          fontSize: FSTextStyle.h6size,
                                          fontFamily: 'Gilroy-SemiBold',
                                          color: FsColor.darkgrey),
                                    ),
                                  ],
                                )),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0, 0.0),
                            decoration: BoxDecoration(
                                border: Border(
                              top: BorderSide(
                                  width: 1.0,
                                  color: FsColor.basicprimary.withOpacity(0.2)),
                            )),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        "".toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.lightgrey),
                                      ),
                                      Text(
                                        "",
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  child: GestureDetector(
                                    child: FlatButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                GalleryAlbumList(currentUnit),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "View All",
                                            style: TextStyle(
                                                fontSize: FSTextStyle.h6size,
                                                fontFamily: 'Gilroy-SemiBold',
                                                color: FsColor.darkgrey),
                                          ),
                                          SizedBox(width: 10.0),
                                          Icon(FlutterIcon.right_big,
                                              color: FsColor.darkgrey,
                                              size: FSTextStyle.h6size),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  alignment: Alignment.center,
                ),
        ],
      )),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => GalleryAlbumList(currentUnit)),
        );
      },
    );
  }

  void initializeData() {
    if (flatsGallery != null && flatsGallery["album_title"] != null) {
      isFlatsGallery = true;
    }
  }
}
