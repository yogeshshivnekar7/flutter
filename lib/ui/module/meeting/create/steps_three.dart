import 'package:flutter/material.dart';
import 'package:sso_futurescape/config/colors/color.dart';
import 'package:sso_futurescape/ui/module/meeting/pojo/meet_vote_pojos.dart';

class StepsThree extends StatefulWidget {
  var data;

  StepsThree({Key key, this.data}) : super(key: key);

  @override
  StepsThreeState createState() => new StepsThreeState();
}

class StepsThreeState extends State<StepsThree> {
  TextEditingController _agendaDescriptionController;
  List _agendaList = [];

  @override
  void initState() {
    super.initState();
    _agendaDescriptionController = TextEditingController();
    _agendaList.addAll(getDataValue("agendas"));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 15),
            child: Text(
              'some line add agenda lorem',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: FSTextStyle.h5size,
                  color: FsColor.secondarymeeting,
                  fontFamily: 'Gilroy-SemiBold'),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
              border: Border.all(
                width: 1.0,
                color: FsColor.primarymeeting.withOpacity(0.2),
              ),
            ),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                          width: 1,
                          color: FsColor.primarymeeting.withOpacity(0.2)),
                    ),
                    color: FsColor.primarymeeting.withOpacity(0.1),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    style: TextStyle(
                        fontSize: FSTextStyle.h6size,
                        color: FsColor.basicprimary,
                        fontFamily: 'Gilroy-Regular'),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(
                        left: 5,
                        right: 0,
                      ),
                      labelText: 'Enter Agenda Here'.toLowerCase(),
                      labelStyle: TextStyle(
                          fontFamily: 'Gilroy-Regular',
                          fontSize: FSTextStyle.h6size,
                          color: FsColor.darkgrey.withOpacity(0.75)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: FsColor.primarymeeting)),
                      suffix: GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          child: RaisedButton(
                            padding: EdgeInsets.all(0),
                            color: FsColor.primarymeeting,
                            onPressed: () {
                              _onClickAddAgenda();
                            },
                            child: Icon(
                              Icons.add,
                              color: FsColor.white,
                              size: FSTextStyle.h4size,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  primary: false,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _agendaList?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    var _agenda = _agendaList[index];
                    return AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeInOut,
                        padding: EdgeInsets.fromLTRB(10, 7, 10, 7),
                        decoration: BoxDecoration(
                            // color: FsColor.red,
                            border: Border(
                          bottom: BorderSide(
                              width: 1,
                              color: FsColor.darkgrey.withOpacity(0.2)),
                        )),
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  _agenda["description"],
                                  style: TextStyle(
                                      fontFamily: 'Gilroy-SemiBold',
                                      fontSize: FSTextStyle.h6size,
                                      color: FsColor.basicprimary),
                                ),
                              ),
                              Container(
                                width: 32,
                                height: 32,
                                alignment: Alignment.center,
                                child: FlatButton(
                                    padding: EdgeInsets.all(0),
                                    onPressed: () {
                                      _onClickRemoveAgenda(index);
                                    },
                                    child: Icon(
                                      Icons.clear,
                                      color: FsColor.red,
                                      size: 22,
                                    )),
                              )
                            ],
                          ),
                        ));
                    },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onClickAddAgenda() {
    String agendaDescription = _agendaDescriptionController.text?.trim();
    if (agendaDescription != null && agendaDescription.trim().isNotEmpty) {
      _agendaList.insert(0, {
        "description": agendaDescription
      });
      setState(() {});
    }
  }

  void _onClickRemoveAgenda(int index) {
    if (index > 0) {
      _agendaList.removeAt(index);
      setState(() {});
    }
  }

  List getDataValue(String dataKey) {
    if (widget.data == null) {
      return [];
    }
    return widget.data[dataKey] ?? [];
  }

  StepData validateAndGetStepData() {
    StepData stepData = StepData();

    if (_agendaList == null || _agendaList.isEmpty) {
      stepData.data = null;
      stepData.errorMsg = "please add atleast 1 agenda";
      stepData.dataError = true;
      return stepData;
    }

    var data = {
      "agendas": _agendaList
    };

    stepData.data = data;
    stepData.errorMsg = null;
    stepData.dataError = false;
    return stepData;
  }
}















