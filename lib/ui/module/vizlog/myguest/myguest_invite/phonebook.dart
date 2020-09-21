import 'dart:collection';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:random_color/random_color.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';
import 'package:sso_futurescape/ui/widgets/page_loader.dart';
// Ref Link : https://www.developerlibs.com/2018/06/flutter-apply-search-box-in-appbar.html

class Phonebook extends StatefulWidget {
  Function onClicked;

  @override
  _PhonebookState createState() => new _PhonebookState(onClicked);

  Phonebook(this.onClicked);
}

class _PhonebookState extends State<Phonebook> {
  List listcontacts;

  static final GlobalKey<ScaffoldState> scaffoldKey =
  new GlobalKey<ScaffoldState>();

  TextEditingController _searchQuery;
  bool _isSearching = false;
  String searchQuery = "";

  bool isLoading = false;

  RandomColor _randomColor;

  Function onClicked;

  _PhonebookState(this.onClicked);

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
    _randomColor = RandomColor();
    getContact();
  }

  void _startSearch() {
    print("open search box");
    ModalRoute.of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearchQuery() {
    print("close search box");
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("");
    });
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment = CrossAxisAlignment.center;

    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            const Text('Seach box'),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search contact',
        hintStyle: TextStyle(color: FsColor.black.withOpacity(0.3)),
        border: InputBorder.none,
      ),
      style: TextStyle(
          color: _isSearching ? FsColor.basicprimary : FsColor.white,
          fontSize: FSTextStyle.h6size),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    setState(() {
      searchQuery = newQuery;
    });
    print("search query " + newQuery);
    if (newQuery.length > 2) {
      getContact(search: newQuery);
    } else if (newQuery.length == 0) {
      getContact();
    }
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: Icon(
            Icons.clear,
            color: _isSearching ? FsColor.darkgrey : FsColor.white,
          ),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: Icon(Icons.search),
        onPressed: _startSearch,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: new AppBar(
          elevation: 1,
          backgroundColor:
          _isSearching ? FsColor.white : FsColor.primaryvisitor,
          leading: _isSearching ? FsBackButton() : FsBackButtonlight(),
          title: _isSearching
              ? _buildSearchField()
              : Text(
            'Phonebook'.toLowerCase(),
            style: FSTextStyle.appbartextlight,
          ),
          actions: _buildActions(),
        ),
        body: isLoading
            ? PageLoader()
            : ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: ListView.builder(
                    primary: false,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                    listcontacts == null ? 0 : listcontacts.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map listmembers = listcontacts[index];
                      return Padding(
                        padding: EdgeInsets.only(bottom: 0),
                        child: GestureDetector(
                          onTap: () {
                            if (_isSearching) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                            }
                            print("emia --- ${listmembers["email"]}");
                            onClicked(listmembers);
//                                  Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.only(
                              bottom: 10.0,
                              top: 10.0,
                            ),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        width: 1,
                                        color: FsColor.darkgrey
                                            .withOpacity(0.1)))),
                            child: Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: <Widget>[
                                // ClipRRect(
                                //   borderRadius: BorderRadius.circular(25),
                                //   child: Image.asset(
                                //     "${listmembers["photo"]}",
                                //     height: 42, width: 42, fit: BoxFit.cover,
                                //   ),
                                // ),

                                Container(
                                  width: 42,
                                  height: 42,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.circular(25),
                                    color: _randomColor.randomColor(),
                                  ),
                                  child: Text(
                                    listmembers["initial"],
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: FSTextStyle.h3size,
                                        fontFamily: 'Gilroy-Regular',
                                        color: FsColor.white),
                                  ),
                                ),

                                SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${listmembers["name"]}'
                                            .toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h6size,
                                            fontFamily: 'Gilroy-SemiBold',
                                            color:
                                            FsColor.primaryvisitor),
                                      ),
                                      SizedBox(height: 5),
                                      Text(
                                        '${listmembers["number"]}'
                                            .toLowerCase(),
                                        style: TextStyle(
                                            fontSize: FSTextStyle.h5size,
                                            fontFamily: 'Gilroy-Regular',
                                            color: FsColor.darkgrey),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> getContact({search}) async {
    isLoading = true;
    Iterable<Contact> contacts =
    await ContactsService.getContacts(withThumbnails: false, query: search);
    Set<Contact> l = contacts.toSet();
    listcontacts = [];
    HashMap<String, String> hm = HashMap();
    l.forEach((contact) {
      Set<Item> listPhone = contact.phones.toSet();
      listPhone.forEach((element) {
        if (checkValidation(element.value)) {
          String phoneNum = getPhoneNumber(element);
          if (!hm.containsKey(phoneNum)) {
            hm[phoneNum] = phoneNum;
            var data = {
              "name": contact.displayName,
              "number": phoneNum,
              "initial": getInitial(contact.displayName),
              "email": getEmail(contact.emails)
            };
            listcontacts.add(data);
          }
        }
      });
    });

    setState(() {
      isLoading = false;
    });
//    print("l------------------ ${l.toString()}");
  }

  String getPhoneNumber(Item element) {
    element.value = element.value.replaceAll(" ", "").replaceAll("-", "");
//    if (element.value.length > 10) {
//      element.value = reverseString(element.value);
//      element.value = element.value.substring(0, 10);
//      element.value = reverseString(element.value);
//    }
    return element.value;
  }

  String reverseString(String element) {
    String revers = "";
    for (int i = element.length - 1; i >= 0; i--) {
      revers = revers + element.substring(i, i + 1);
    }
    return revers;
  }

  bool checkValidation(String mobNumber) {
    if (mobNumber.length <= 9) {
      return false;
    } else {
      return true;
    }
  }

  getInitial(String displayName) {
    return displayName.substring(0, 1).toUpperCase();
  }

  String getEmail(Iterable<Item> emails) {
//    print("email ---- ${emails.toList().toString()}");
    String email = "";
    emails.forEach((element) {
//      print("email ---- ${element.value}");
      if (element.value != null && element.value.length > 0) {
        email = element.value;
      }
    });
    return email;
  }
}
