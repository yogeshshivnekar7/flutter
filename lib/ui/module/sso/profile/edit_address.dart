import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/sso/profile/profile_view.dart';
import 'package:sso_futurescape/ui/widgets/back_button.dart';

import 'manage_address.dart';

// enum SingingCharacter { lafayette, jefferson }

class EditAddress extends StatefulWidget {
  var profileData;
  var address;

  EditAddress(this.address, this.profileData);

  @override
  _EditAddressState createState() =>
      new _EditAddressState(address, profileData);
}

class _EditAddressState extends State<EditAddress> {
  var profileData;
  String _addTag = "Home";
  var address;

  bool isLocation = false;

  List<String> _state = ['Maharashtra', 'Delhi'];
  String _selectedState;

  List<String> _country = ['India', 'UAE'];
  String _selectedCountry;

  void _addressTag(String value) {
    setState(() {
      _addTag = value;
    });
  }

  _EditAddressState(address, profileData) {
    this.address = address;
    this.profileData = profileData;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color color1 = Color(0xff404040);
    final Color color2 = Color(0xff999999);
    final _media = MediaQuery.of(context).size;

    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Edit Address".toLowerCase(),
          style: FSTextStyle.appbartext,          
        ),
        leading: FsBackButton(),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 10),
                        isLocation
                            ? ListTile(
                                title: Text(
                                  "Vashi",
                                  style: TextStyle(
                                    fontFamily: 'Gilroy-Regular',
                                  ),
                                ),
                                subtitle: Text(
                                  "1905, cyber one, sector 30A, vashi, navi mumbai.",
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-Regular',
                                      color: const Color(0xff404040)),
                                ),
                                leading: Icon(Icons.place),
                              )
                            : Container(),
                        isLocation
                            ? Container(
                                padding: EdgeInsets.all(5),
                                margin: EdgeInsets.fromLTRB(67, 0, 0, 0),
                                child: new Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      new FlatButton(
                                        child: new Text("Change",
                                            style: TextStyle(
                                              fontSize: FSTextStyle.h6size,
                                              fontFamily: 'Gilroy-SemiBold',
                                              color: FsColor.darkgrey,
                                            )),
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ManageAddress(profileData)),
                                          );
                                        },
                                      ),
                                    ]),
                              )
                            : Container(),
                        ListTile(
                          subtitle: TextFormField(
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                            minLines: 1,
                            maxLines: 4,
                            initialValue: "1905, cyber one, sector 30A",
                            decoration: InputDecoration(labelText: 'Address'),
                          ),
                        ),
                        ListTile(
                          subtitle: TextFormField(
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                            initialValue: "Opp. Cidco exhibition centre",
                            decoration: InputDecoration(labelText: 'Landmark'),
                          ),
                        ),
                        ListTile(
                          subtitle: TextFormField(
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                            initialValue: "Vashi",
                            decoration: InputDecoration(labelText: 'Locality'),
                          ),
                        ),
                        ListTile(
                          subtitle: TextFormField(
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                            initialValue: "Navi Mumbai",
                            decoration: InputDecoration(labelText: 'City'),
                          ),
                        ),
                        ListTile(
                          subtitle: TextFormField(
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                            ),
                            initialValue: "400703",
                            decoration: InputDecoration(labelText: 'Zipcode'),
                          ),
                        ),
                        SizedBox(height: 12),
                        ListTile(
                          title: Text(
                            "State",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              fontSize: 12,
                              color: const Color(0xFF7b7b7b),
                            ),
                          ),
                          subtitle: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: DropdownButton(
                                    hint: Text(
                                      'Choose your state',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Regular',
                                      ),
                                    ),
                                    value: _selectedState,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedState = newValue;
                                      });
                                    },
                                    items: _state.map((state) {
                                      return DropdownMenuItem(
                                        child: new Text(
                                          state,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Regular',
                                          ),
                                        ),
                                        value: state,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ]),
                        ),
                        ListTile(
                          title: Text(
                            "Country",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              fontSize: 12,
                              color: const Color(0xFF7b7b7b),
                            ),
                          ),
                          subtitle: new Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: DropdownButton(
                                    hint: Text(
                                      'Choose your country',
                                      style: TextStyle(
                                        fontFamily: 'Gilroy-Regular',
                                      ),
                                    ),
                                    value: _selectedCountry,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selectedCountry = newValue;
                                      });
                                    },
                                    items: _country.map((country) {
                                      return DropdownMenuItem(
                                        child: new Text(
                                          country,
                                          style: TextStyle(
                                            fontFamily: 'Gilroy-Regular',
                                          ),
                                        ),
                                        value: country,
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ]),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          title: Text(
                            "Saved As",
                            style: TextStyle(
                              fontFamily: 'Gilroy-Regular',
                              fontSize: 12,
                              color: const Color(0xFF7b7b7b),
                            ),
                          ),
                          subtitle: new Column(children: <Widget>[
                            new RadioListTile(
                              value: "Home",
                              activeColor: const Color(0xFF545454),
                              title: new Text(
                                "Home",
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                ),
                              ),
                              groupValue: _addTag,
                              onChanged: (String value) {
                                _addressTag(value);
                              },
                            ),
                            new RadioListTile(
                              value: "Work",
                              activeColor: const Color(0xFF545454),
                              title: new Text(
                                "Work",
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                ),
                              ),
                              groupValue: _addTag,
                              onChanged: (String value) {
                                _addressTag(value);
                              },
                            ),
                            new RadioListTile(
                              value: "Other",
                              activeColor: const Color(0xFF545454),
                              title: new Text(
                                "Other",
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                ),
                              ),
                              groupValue: _addTag,
                              onChanged: (String value) {
                                _addressTag(value);
                              },
                            ),
                            ListTile(
                              subtitle: TextFormField(
                                style: TextStyle(
                                  fontFamily: 'Gilroy-Regular',
                                ),
                                initialValue: "",
                                decoration: InputDecoration(
                                  labelText: "e.g Dads's Ofice",
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
                    child: GestureDetector(
                      child: RaisedButton(
                        child: Text('Save And Proceed',
                            style: TextStyle(
                                fontSize: FSTextStyle.h6size,
                                fontFamily: 'Gilroy-SemiBold')),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4.0),
                        ),
                        color: const Color(0xFF404040),
                        textColor: FsColor.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileView()),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
