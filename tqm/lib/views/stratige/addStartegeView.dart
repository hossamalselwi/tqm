import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:tqm/models/Stratige/Brch.dart';
import 'package:tqm/models/Stratige/Goal.dart';
import 'package:tqm/models/Stratige/Stratige.dart';
import 'package:tqm/models/Stratige/Years.dart';
import 'package:tqm/models/barch.dart';
import 'package:tqm/services/Stratege/stratigeService.dart';
import 'package:tqm/shared_widgets/DatePicker/YearsPicker.dart';
import 'package:tqm/shared_widgets/DatePicker/monthPicker.dart';
import 'package:tqm/shared_widgets/customerFielsLable.dart';
import 'package:tqm/shared_widgets/customerRadioButton.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/goal/goalCard.dart';
import 'package:tqm/views/goal/goalView.dart';
import 'package:tqm/views/shareView/DefaultButton.dart';
import 'package:tqm/views/shareView/FormText.dart';
import 'package:tqm/views/shareView/appBar.dart';

import 'SubWidget/BrchDialog.dart';

StratigeService _stratigeService = StratigeService();

class AddStratigeView extends StatefulWidget {
  AddStratigeView({
    Key key,
  }) : super(key: key);

  @override
  _NewOneStrState createState() => _NewOneStrState();
}

class _NewOneStrState extends State<AddStratigeView> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  StratigeModel _model = StratigeModel(
      id: 0,
      iduserEnter: 1,
      img: '',
      name: '',
      type: 'Year',
      years: [],
      brchs: []);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarApp(context, 'استراتيجية جديدة'),
      extendBody: true,
      body: new Center(
        child: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    'اضافة استراتيجية ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Form(
                    key: _key,
                    autovalidate: _validate,
                    child: _getFormUI(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /*void selectType(String value) {
    if (value != null)
      setState(() {
        _model.type = value;
      });
  }*/

  void selectBeginYear(int value) {
    if (value != null)
      setState(() {
        _model.years.add(new YearsModel(
            id: 0, number: value, name: value.toString(), isActive: true));
      });
  }

  void selectBrch(List<Barch> value) //Barch  //BrchSrtModel
  {
    if (value != null) {
      List<BrchSrtModel> temp = List<BrchSrtModel>();
      for (int i = 0; i < value.length; i++) {
        BrchSrtModel m = BrchSrtModel(
            id: value[i].id, name: value[i].name, image: value[i].image);
        temp.add(m);
      }
      setState(() {
        _model.brchs.addAll(temp);
      });
    }
  }

  Widget cardBarch() {
    return Column(
      children: [
        for (int i = 0; i < _model.brchs.length; i++)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10, left: 10),
                child: Row(
                  children: [
                    Text('${i + 1} - '),
                    Text(_model.brchs[i].name),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _model.brchs.removeAt(i);
                        });
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: Icon(
                          Icons.delete,
                          size: 25,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider()
            ],
          ),
      ],
    );
  }

  int countyear = 0;

  addGoal(GoalModel value) {
    _model.goals.add(value);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  Widget _getFormUI() {
    return new Column(
      children: <Widget>[
        new SizedBox(height: 20.0),
        FieldLabel(
          field: 'رقم الاستراتيجية ',
          value: '${_model.id}',
        ),
        new SizedBox(height: 5.0),
        FormText.textFormIconLess(
            context,
            _model.name,
            ' اسم الاستراتيجية',
            //null,
            FormValidator().validateisEmpty, (String value) {
          _model.name = value;
        }, ' اسم الاستراتيجية', null),

        /*RaioButton(
          onChange: selectType,
        ),*/

        new SizedBox(height: 20.0),
        Card(
          child: Column(
            children: [
              Row(
                //mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('فترة الاستراتيجية العدد :'),
                  Expanded(child: Text('${_model.years.length.toString()}')),
                  MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        // side: BorderSide(color: Colors.red)
                      ),
                      onPressed: () {
                        if (_model.years.length == 0) {
                          if (_model.type == "Year") {
                            int min = DateTime.now().year;
                            int max = min + 20;
                            new YearsPicker()
                                .showPicker(context, min, max, selectBeginYear);
                          } else
                            new MonthPickerWidget();
                        } else {
                          if (_model.type == "Year") {
                            int yearlat = _model.years.last.number + 1;

                            setState(() {
                              _model.years.add(new YearsModel(
                                  id: 0,
                                  number: yearlat,
                                  name: '$yearlat',
                                  isActive: false));
                              countyear = _model.years.length;
                            });
                          }
                          //   setState(() {});

                        }

                        //setState(() {});
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.add,
                            size: 16,
                            color: Colors.black,
                          ),
                        ],
                      )),
                ],
              ),
              Divider(),
              for (int i = 0; i < _model.years.length; i++)
                Padding(
                  padding: const EdgeInsets.only(right: 10, left: 10),
                  child: Row(
                    children: [
                      Checkbox(
                        value: true,
                        onChanged: (newValue) {},
                      ),
                      Text(_model.years[i].name),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _model.years.removeAt(i);
                            countyear = _model.years.length;
                          });
                        },
                        child: i == (_model.years.length - 1)
                            ? CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15,
                                child: Icon(
                                  Icons.minimize,
                                  size: 16,
                                  color: Colors.black,
                                ),
                              )
                            : Container(),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        new SizedBox(height: 5.0),
        Row(
          children: [
            Text(' : صورة الاستراتيجية'),
            Expanded(
                child: Text(
              '  تم رفع الملف  ',
              style: TextStyle(color: Colors.green),
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    icon: Icon(
                      Icons.delete_forever_sharp,
                      color: Colors.redAccent,
                      size: 24,
                    ),
                    onPressed: () {
                      // print('delete');
                    }),
                IconButton(
                    icon: Icon(
                      Icons.upload_file,
                      size: 24,
                    ),
                    onPressed: () {
                      // print('delete');
                    }),
              ],
            ),
          ],
        ),
        new BrchDialog(
          context: context,
          onOk: (List<Barch> list) {
            selectBrch(list);
          },
        ),
        cardBarch(),
        new SizedBox(height: 15.0),
        Container(
          margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
          padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
          child: Card(
            child: Container(
              padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'الاهداف: ${_model.goals.length}',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                      Container(
                        child: MaterialButton(
                          child: Icon(
                            Icons.add,
                            textDirection: TextDirection.rtl,
                            size: 28,
                            color: Colors.black,
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              side: BorderSide(color: Colors.red)),
                          onPressed: () {
                            _sendToServer();
                          },
                        ),
                      )
                    ],
                  ),
                  Divider(),
                  Container(
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      //controller: _scrollController,
                      itemCount: _model.goals.length,
                      itemBuilder: (_, index) {
                        return GoalList(
                          goalModel: _model.goals[index],
                          //onPressEdit: _onTapePointerListTile,
                          onPressDelete: _onDeletePointerListTile,
                        );
                      },
                      separatorBuilder: (_, index) {
                        return Divider(
                          color: Colors.blueGrey,
                          thickness: 1.0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        new Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: DefaultButton(
              backColor: bBasicColor,
              text: ' حفظ الاستراتيجية ',
              foreColor: Colors.white,
              radioborder: 25,
              press: _sendToServer11,
            )),
      ],
    );
  }

  Future<void> _deleteGoal(GoalModel pointerModel) async {
    try {
      setState(() {
        _model.goals.removeAt(_model.goals
            .indexWhere((element) => element.id == pointerModel.id));
      });
      SystemMsg.showMsg(
        _scaffoldKey,
        'تم الحذف بنجاح',
        SystemMsg.backgroundSuccessColor,
      );
    } catch (ex, st) {
      print(ex);
      print(st);
      SystemMsg.timeoutError(_scaffoldKey);
    }
  }

  _onDeletePointerListTile(GoalModel pointerModel) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteAlert(
            questionText: 'هل تريد بالتأكيد حذف الهدف',
            dataFirstRowText: pointerModel.name,
            dataSecondRowText: '',
            isTextDirectionAr: true,
            onPressOKBtn: () async {
              await _deleteGoal(pointerModel);
              Navigator.of(context).pop();
            },
          );
        });
  }

  _sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      Navigator.of(context)
          .push(new MaterialPageRoute(
              fullscreenDialog: true,
              builder: (c) {
                return GoalsView(
                  stratige: _model,
                );
              }))
          .then((value) {
        setState(() {
          _model.goals.add(value);
        });
      });
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  _sendToServer11() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();

      final UiUtilities uiUtilities = UiUtilities();

      try {
        BotToast.showLoading(
            allowClick: false,
            clickClose: false,
            backButtonBehavior: BackButtonBehavior.ignore);

        bool sata = false;

        sata = await _stratigeService.add(_model);
        BotToast.closeAllLoading();
        if (sata) {
          uiUtilities.alertNotification(
              context: context, message: 'تم حفظ الاستراتيجية ');
          Navigator.of(context).pop(_model);
        } else {
          uiUtilities.alertNotification(
              context: context,
              message: ' حدث خطا الرجاء التاكد من اتصالك بالانترنت ');
        }
      } catch (ee) {
        uiUtilities.alertNotification(
            context: context,
            message: ' حدث خطا الرجاء التاكد من اتصالك بالانترنت ');
      }
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}

////////////
///
///
///
///
///
