import 'package:flutter/material.dart';
import 'package:sso_futurescape/ui/widgets/no_data.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';

class FsListWidget extends StatefulWidget {
  var pageLoadListner;
  Function afterView;
  var itemBuilder;

  var message;

  var title;

  bool shrinkWrap = false;

  FsListWidget({this.pageLoadListner,
    this.afterView,
    this.itemBuilder,
    this.title,
    this.message,
    this.shrinkWrap});

  @override
  State<StatefulWidget> createState() {
    return FsListState(
        pageLoadListner: pageLoadListner,
        afterView: afterView,
        itemBuilder: itemBuilder,
        title: title,
        message: message,
        shrinkWrap: shrinkWrap);
  }
}

class FsListState extends State<FsListWidget> {
  PageLoadListener pageLoadListner;
  Function afterView;

  Function itemBuilder;

  var title;

  var message;

  bool shrinkWrap = false;

  @override
  initState() {
    _scrollController.addListener(() {
      print("ssssssssssssssss");
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("position.maxScrollExtent");
        if (metadata == null ||
            metadata['last_page'] != metadata['current_page']) {
          print("page no " + metadata.toString());
          String pageNumber =
          metadata == null || metadata['current_page'].toString() == null
              ? '1'
              : (metadata['current_page'] + 1).toString();
          loadMore(pageNumber);
        }
      }
    });
    super.initState();
  }

  FsListState({this.pageLoadListner,
    this.afterView,
    this.itemBuilder,
    this.title,
    this.message,
    this.shrinkWrap = false}) {
    afterView(this);
  }

  ScrollController _scrollController = ScrollController();
  List receiptList = null;

  var metadata;
  int unit_id;

  void loadMore(String pageNumber) {
    pageLoadListner.loadNextPage(pageNumber);
  }

  @override
  Widget build(BuildContext context) {
    return receiptList == null
        ? PageLoader()
        : receiptList.length == 0
        ? FsNoData(
      title: title,
      message: message,
    )
            : ListView.builder(
        shrinkWrap: shrinkWrap == null ? false : shrinkWrap,
        primary: false,
        controller: _scrollController,
        itemCount: receiptList == null ? 0 : receiptList.length,
        itemBuilder: (BuildContext context, int index) {
          /* Padding childItem = getChildItem(index);*/
          var childItem =
          itemBuilder(context, index, receiptList[index]);
          return childItem;
        });
  }

  void clearList() {
    receiptList.clear();
  }

  void addListList(metadata, receiptList) {
    if (this.receiptList == null) {
      this.receiptList = [];
    }
    this.metadata = metadata;
    this.receiptList.addAll(receiptList);

    setState(() {});
  }

  void notItems() {
    if (metadata == null) {
      this.receiptList = null;
    }
    setState(() {});
  }

  void clearListAndData() {
    metadata = null;
    this.receiptList = null;

    setState(() {});
  }

  void stateUpdate() {
    setState(() {});
  }
}

abstract class PageLoadListener {
  loadNextPage(String page);

  lastPage(int page);
}
