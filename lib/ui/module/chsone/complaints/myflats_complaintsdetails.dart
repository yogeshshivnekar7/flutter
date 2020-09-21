import 'package:common_config/utils/toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/presentor/module/chsone/complaints/compalint_add_reply_presenter.dart';
import 'package:sso_futurescape/presentor/module/chsone/complaints/complaint_reply_presenter.dart';
import 'package:sso_futurescape/presentor/module/chsone/complaints/complaint_view.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/my_flutter_app_icons.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
import 'package:sso_futurescape/utils/app_utils.dart';
import 'package:sso_futurescape/utils/storage/chsone_storage.dart';

class MyFlatsComplaintsDetails extends StatefulWidget {
  var complaintId;
  String ticketNumber;
  String complaintTitle;
  String complaintStatus;
  var currentUnit;


  MyFlatsComplaintsDetails(this.currentUnit, this.complaintId,
      this.ticketNumber,
      this.complaintTitle, this.complaintStatus);

  @override
  _MyFlatsComplaintsDetailsState createState() =>
      new _MyFlatsComplaintsDetailsState(this.currentUnit,
          complaintId, ticketNumber, complaintTitle, complaintStatus);
}

class _MyFlatsComplaintsDetailsState extends State<MyFlatsComplaintsDetails>
    implements ComplaintReplyView, AddReplyView {
  //get all properties ready
  ComplaintReplyPresenter presentor;
  ComplaintAddReplyPresenter reply_add_presentor;
  var issues;
  var replies;
  int complaintId;
  String complaintTitle;
  String ticketNumber;
  String complaintStatus;
  bool isLoading = false;
  bool isReply = false;
  String fileAttachment;
  var currentUnit; // at init keep container empty;
  //constructor
  _MyFlatsComplaintsDetailsState(this.currentUnit, this.complaintId,
      this.ticketNumber,
      this.complaintTitle, this.complaintStatus,);

  TextEditingController _enterReplyController = new TextEditingController();
  String _selectedStatus = "open";
  List<String> _status = ['open', 'closed', 'reopened'];

  // create init state
  @override
  void initState() {
    initDownload();
    print("sssssssssssssssssssssssssss");
    print(complaintStatus);
    print(complaintStatus);
    _selectedStatus = "open"; //by default
    presentor = new ComplaintReplyPresenter(this);
    reply_add_presentor = new ComplaintAddReplyPresenter(this);
    super.initState();
    _getComplaintsReply(this.complaintId);
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: new AppBar(
          elevation: 0.0,
          backgroundColor: FsColor.primaryflat,
          title: new Text(
            'Ticket : $ticketNumber'.toLowerCase(),
            style: FSTextStyle.appbartextlight,
          ),
          leading: FsBackButtonlight(),
          actions: <Widget>[
            fileAttachment != null ? IconButton(
                icon: Icon(FlutterIcon.download_1), onPressed: () {
              print(fileAttachment);
//              AppUtils.launchUrlWithUrl(fileAttachment);
              //downloadFiles(fileAttachment);
              AppUtils.downloadFile(fileAttachment);


            }) : Container()
          ],
        ),
        body: isLoading
            ? PageLoader()
            : Container(
          // height: 1024,
          height: MediaQuery
              .of(context)
              .size
              .height,

          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                        alignment: Alignment.centerLeft,
                        padding:
                        EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
                        color: FsColor.lightgreybg.withOpacity(0.4),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Subject : '.toLowerCase(),
                              style: TextStyle(
                                  fontSize: FSTextStyle.h6size,
                                  fontFamily: 'Gilroy-SemiBold',
                                  color: FsColor.lightgrey),
                            ),
                            SizedBox(width: 5),
                            Flexible(
                              child: Text(
                                '$complaintTitle'.toLowerCase(),
                                style: TextStyle(
                                    fontSize: FSTextStyle.h6size,
                                    fontFamily: 'Gilroy-SemiBold',
                                    color: FsColor.darkgrey),
                              ),
                            )
                          ],
                        )),
                    Container(
                      padding:
                      EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 55.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Complaint Communication',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold',
                                color: FsColor.darkgrey),
                          ),
                          SizedBox(height: 5),
                          isReply != true
                              ? Card()
                              : Container(
                              child: Column(
                                  children: renderCards(replies)))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    color: FsColor.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey[500],
                        offset: Offset(0.0, 1.5),
                        blurRadius: 4.0,
                      ),
                    ],
                  ),
                  constraints: BoxConstraints(
                    maxHeight: 100,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        title: TextField(
                          controller: _enterReplyController,
                          style: TextStyle(
                            fontSize: FSTextStyle.h6size,
                            color: FsColor.darkgrey,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            hintText: "Write your message...",
                            hintStyle: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              color: FsColor.lightgrey,
                            ),
                          ),
                          maxLines: 1,
                        ),
                        leading: Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: DropdownButton(
                            value: _selectedStatus,
                            onChanged: (newValue) {
                              setState(() {
                                _selectedStatus = newValue;
                                print(_selectedStatus = newValue);
                              });
                            },
                            items: _status.map((status) {
                              return DropdownMenuItem(
                                child: new Text(
                                  status,
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-SemiBold',
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.darkgrey),
                                ),
                                value: status,
                              );
                            }).toList(),
                          ),
                        ),
                        trailing: Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          width: 50,
                          child: RaisedButton(
                            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                            shape: new RoundedRectangleBorder(
                              borderRadius:
                              new BorderRadius.circular(4.0),
                            ),
                            child: Icon(
                              FlutterIcon.paper_plane_empty,
                              color: FsColor.white,
                              size: 20,
                            ),
                            onPressed: () {
                              sendReply(complaintId);
                            },
                            color: FsColor.primaryflat,
                            textColor: FsColor.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  @override
  void onReplyListError(String response) {
    // TODO: implement onReplyListError
    Toasly.error(context, AppUtils.errorDecoder(response));
  }

  @override
  void onReplyListFailure(String response) {
    // TODO: implement onReplyListFailure
    Toasly.error(context, AppUtils.errorDecoder(response));
  }

  @override
  void onSuccessReplyListTopics(resPonse, listResult) {
    print("dddddddddddd");
    print(resPonse["attachment"]);
    print(listResult);
    this.issues = resPonse;
    this.replies = listResult;

    try {
      fileAttachment = resPonse["attachment"][0]["final_url"];
    } catch (e) {
      print("file not found");
      print(e);
      fileAttachment = null;
    }


    print(fileAttachment);
    setState(() {
      isLoading = false;
      isReply = true;
    });
  }

  void _getComplaintsReply(complaintId) {
    try {
      presentor.getComplaintReplyist(complaintId);
    } catch (e) {}
  }

  void sendReply(int complaintId) {
    String reply = _enterReplyController.text.trim();
    String compalintStatus = _selectedStatus.toLowerCase();
    ChsoneStorage.getMemberIdForUnit(currentUnit["unit_id"].toString()).then((
        userData) {
      if (reply.isNotEmpty) {
        reply_add_presentor.addReply(
            userData["member_id"].toString(), reply, complaintId,
            compalintStatus);
        isLoading = true;
        setState(() {});
      } else {
        Toasly.error(context, "Enter reply !");
      }
    });
  }

  List<Widget> renderCards(replies) {
    List<Widget> widget = [];
    for (var i = 0; i < replies.length; i++) {
      Widget heading = Card(
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(
              Radius.circular(4.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      replies[i]["responder_name"] == null
                          ? "-"
                          : replies[i]["responder_name"].toLowerCase(),
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.darkgrey),
                    ),
                    Text(
                      replies[i]["response_date"] == null
                          ? "-"
                          : replies[i]["response_date"]
                          .toString()
                          .toLowerCase(),
                      style: TextStyle(
                          fontSize: FSTextStyle.h6size,
                          fontFamily: 'Gilroy-SemiBold',
                          color: FsColor.lightgrey),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          replies[i]["response_text"] == null
                              ? "-"
                              : replies[i]["response_text"]
                              .toString()
                              .toLowerCase(),
                          style: TextStyle(
                              fontSize: FSTextStyle.h6size,
                              fontFamily: 'Gilroy-SemiBold',
                              color: FsColor.darkgrey),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            replies[i]["body"] == null
                                ? "-"
                                : replies[i]["body"].toString().toLowerCase(),
                            style: TextStyle(
                                fontSize: FSTextStyle.h7size,
                                fontFamily: 'Gilroy-Regular',
                                color: FsColor.darkgrey),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ));
      widget.add(heading);
    }
    return widget;
  }

  @override
  void onError(String response) {
    isLoading = false;
    setState(() {});
  }

  @override
  void onFailure(String response) {
    isLoading = false;
    Toasly.error(context, AppUtils.errorDecoder(response));
    setState(() {});
  }

  @override
  void onSuccessAddReplyComplaint(response) {
    Toasly.success(context, "Reply added sucessfully!");
    _enterReplyController.text = "";
    presentor.getComplaintReplyist(complaintId);
  }

  Future<void> downloadFiles(String fileAttachment) async {
    /* final taskId = await FlutterDownloader.enqueue(
      url: fileAttachment,
      savedDir: 'the path of directory where you want to save downloaded files',
      showNotification: true,
      // show download progress in status bar (for Android)
      openFileFromNotification: true, // click on notification to open downloaded file (for Android)
    );*/
    //await FlutterDownloader.open(taskId: taskId);
  }

  Future<void> initDownload() async {
    /*WidgetsFlutterBinding.ensureInitialized();
    await FlutterDownloader.initialize();*/
  }
}
