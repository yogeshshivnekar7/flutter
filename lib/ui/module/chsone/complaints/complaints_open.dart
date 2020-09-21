import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/config/strings/strings.dart';
import 'package:sso_futurescape/presentor/module/chsone/complaints/complaint_view.dart';
import 'package:sso_futurescape/presentor/module/chsone/complaints/list_complaint_presenter.dart';
import 'package:sso_futurescape/ui/module/chsone/complaints/myflats_complaintsdetails.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
// import 'package:sso_futurescape/utils/storage/complex.dart';

class ComplaintsOpen extends StatefulWidget {
  var complaintType;

  var currentUnit;

  ComplaintsOpen(this.currentUnit, this.complaintType);

  @override
  _ComplaintsOpenState createState() =>
      new _ComplaintsOpenState(currentUnit, complaintType);
}

class _ComplaintsOpenState extends State<ComplaintsOpen>
    implements ComplaintListView {
  ListComplaintPresenter presentor;

  // List complaints = [];
  List complaints = [];
  var complaintType;
  var currentUnit;
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  var metadata;

  //String currentPage = "1";

  _ComplaintsOpenState(this.currentUnit, this.complaintType);

  @override
  void initState() {
    presentor = new ListComplaintPresenter(this);
    super.initState();
    _getComplaints();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (metadata == null ||
            metadata['last_page'] != metadata['current_page']) {
          String currentPage =
          metadata == null || metadata['current_page'].toString() == null
              ? '1'
              : (metadata['current_page'] + 1).toString();
          _getComplaints(currentPage: currentPage);
        }
      }
    });
    isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? PageLoader()
        : complaints.length == 0
        ? FsNoData(
        title: false,
        message: complaintType == COMPLAINT_TYPE.OPEN ? FsString
            .NO_OPEN_COMPLAINTS : complaintType == COMPLAINT_TYPE.CLOSED
            ? FsString.NO_CLOSED_COMPLAINTS
            : FsString.NO_RESOLVED_COMPLAINTS)
        : ListView(
      controller: _scrollController,
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15),
              child: ListView.builder(
                primary: false,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: complaints == null ? 0 : complaints.length,
                itemBuilder: (BuildContext context, int index) {
                  Map complaint = complaints[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Card(
                      elevation: 1.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4.0),
                        ),
                        // side:BorderSide(color: FsColor.lightgrey, width: 1.0),
                      ),
                      child: InkWell(
                        child: Container(
                          padding: const EdgeInsets.all(15.0),

                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment:
                                CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    '${complaint["ticket_number"]}'
                                        .toLowerCase(),
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h6size,
                                        fontFamily: 'Gilroy-SemiBold',
                                        color: FsColor.primaryflat),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0, 10.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '${complaint["title"]}'
                                            .toLowerCase(),
                                        style: TextStyle(
                                            fontSize:
                                            FSTextStyle.h6size,
                                            fontFamily:
                                            'Gilroy-SemiBold',
                                            color: FsColor.darkgrey),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(
                                    0.0, 10.0, 0, 0.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          width: 1.0,
                                          color: FsColor.basicprimary
                                              .withOpacity(0.2)),
                                    )),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment:
                                  CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            "${complaint["created_date"]}",
                                            style: TextStyle(
                                                fontSize: FSTextStyle
                                                    .h6size,
                                                fontFamily:
                                                'Gilroy-SemiBold',
                                                color:
                                                FsColor.darkgrey),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          // child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // mainAxisSize: MainAxisSize.max,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          //   children: <Widget>[

                          //   ],
                          // ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) =>
                                    MyFlatsComplaintsDetails(
                                        currentUnit,
                                        complaint["issue_id"],
                                        complaint["ticket_number"],
                                        complaint["title"],
                                        complaint["status"])),
                          );
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
    );
  }

  void _getComplaints({currentPage}) {
    if (currentPage == null || currentPage == 1) {
      isLoading = true;
    }
    try {
      // String unitId = currentUnit["unit_id"].toString();
      if (complaintType == COMPLAINT_TYPE.OPEN) {
        presentor.getComplaintList(currentUnit,
            complaintType: "open", loadPage: currentPage);
      } else if (complaintType == COMPLAINT_TYPE.RESOLVED) {
        presentor.getComplaintList(currentUnit,
            complaintType: "resolved", loadPage: currentPage);
      } else if (complaintType == COMPLAINT_TYPE.CLOSED) {
        presentor.getComplaintList(currentUnit,
            complaintType: "closed", loadPage: currentPage);
      } else {
        print(complaintType);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void onError(response) {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void onFailure(response) {
    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void onSuccessListComplaint(metadata, response) {
    if (this.complaints == null) {
      this.complaints = [];
    }
    this.complaints.addAll(response);
    isLoading = false;
    this.metadata = metadata;
    setState(() {});
  }
}

enum COMPLAINT_TYPE { OPEN, RESOLVED, CLOSED }
