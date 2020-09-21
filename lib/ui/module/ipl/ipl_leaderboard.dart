import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/ipl/api_call.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/facebook_utils.dart';

class IplLeaderboard extends StatefulWidget {
  int userid;

  IplLeaderboard({this.userid});

  @override
  _IplLeaderboardState createState() => new _IplLeaderboardState();
}

class _IplLeaderboardState extends State<IplLeaderboard> {
  List iplleaderboard = [];
  bool loading = false;

  Future fetchData() async {
    if (widget.userid != null) {
      await fetchLeaderboard(widget.userid).then((value) {
        print(value);
        if (mounted) {
          setState(() {
            if (value != null) {
              iplleaderboard = value['data'];
              loading = false;
            }
          });
        }
      });
    }
  }

  @override
  void initState() {
    FsFacebookUtils.callCartClick("ipl_leaderboard_page_view", "page open");
    super.initState();
    setState(() {
      loading = true;
    });
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? PageLoader(
            title: '',
          )
        : SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15),
                  child: ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: iplleaderboard.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map ipl = iplleaderboard[index]; //3548 AD 1168
                      return Container(
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        decoration: ipl['auth_id'] != null
                            ? ipl["auth_id"].toString() ==
                                    widget.userid.toString()
                                ? BoxDecoration(
                                    // color: (index==1||index==2||index==3) ? {
                                    //   FsColor.blue,
                                    // }
                                    // :{},
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      width: 2,
                                      color: FsColor.primaryipl,
                                    ))
                                : BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                          width: 1,
                                          color: FsColor.darkgrey
                                              .withOpacity(0.2)),
                                    ),
                                  )
                            : BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      width: 1,
                                      color: FsColor.darkgrey.withOpacity(0.2)),
                                ),
                              ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: Container(
                                  color: FsColor.darkgrey.withOpacity(0.05),
                                  alignment: Alignment.center,
                                  width: 48,
                                  height: 48,
                                  child:
                                      /*index == 0
                                      ? ImageIcon(
                                          AssetImage(
                                              "assets/images/trophy.png"),
                                        )
                                      : index == 1
                                          ? ImageIcon(
                                              AssetImage(
                                                  "assets/images/trophy.png"),
                                            )
                                          : index == 2
                                              ? ImageIcon(
                                                  AssetImage(
                                                      "assets/images/trophy.png"),
                                                )
                                              :*/
                                      Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-Regular',
                                        fontSize: FSTextStyle.h3size,
                                        color: FsColor.darkgrey),
                                  )
                                  // Image.network(
                                  //   '${ipl["img"]}',
                                  //   fit: BoxFit.cover,
                                  // ),
                                  ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Row(
                                children: [
                                  (index == 0 || index == 1 || index == 2)
                                      ? Icon(
                                          Icons.emoji_events_outlined,
                                          color: Colors.orangeAccent,
                                        )
                                      : Container(),
                                  SizedBox(width: 5),
                                  Text(
                                    '${ipl["name"]}',
                                    style: TextStyle(
                                        fontFamily: 'Gilroy-SemiBold',
                                        fontSize: FSTextStyle.h5size,
                                        color: FsColor.basicprimary),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                alignment: Alignment.center,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: Colors.orangeAccent,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '${ipl["points"]}',
                                      style: TextStyle(
                                          fontFamily: 'Gilroy-SemiBold',
                                          fontSize: FSTextStyle.h5size,
                                          color: FsColor.darkgrey),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
