import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tqm/models/Stratige/ExecuteDept.dart';
import 'package:tqm/models/Stratige/MeasurementOfficer.dart';
import 'package:tqm/models/Stratige/Overload.dart';
import 'package:tqm/models/Stratige/Pointer.dart';
import 'package:tqm/models/Stratige/Stratige.dart';
import 'package:tqm/models/Stratige/Unit.dart';
import 'package:tqm/models/Stratige/Goal.dart';
import 'package:tqm/models/Stratige/customer.dart';

import 'package:tqm/models/Stratige/enverement.dart';
import 'package:tqm/models/dept.dart' as dept;

import 'package:tqm/services/Stratege/UnitsService.dart';
import 'package:tqm/services/Stratege/customerService.dart';
import 'package:tqm/models/Stratige/domain.dart';
import 'package:tqm/services/Stratege/domainService.dart';
import 'package:tqm/services/Stratege/enviromentService.dart';
import 'package:tqm/services/deptService.dart';
import 'package:tqm/views/shareView/FormText.dart';
import 'ExecutionDept.dart';
import 'domainView.dart';
import 'CustomerView.dart';
import 'UnitsView.dart';
import 'overloadBrch.dart';

final DomainService _domainService = DomainService();
final CustomerService _customerService = CustomerService();
final EnviromentService _enviromentService = EnviromentService();

final UnitService _unitService = UnitService();

DeptService _deptService = DeptService();

//----------------## Stratigi Page الإستراتيجية ##----------------------//
class GoalsView extends StatefulWidget {
  final StratigeModel stratige;

  const GoalsView({Key key, this.stratige}) : super(key: key);
  @override
  _GoalsPageState createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _goalsFormKey = GlobalKey();
  final GlobalKey<FormState> _pointersFormKey = GlobalKey();
  final GlobalKey<FormState> _exeOfficerFormKey = GlobalKey();
  final GlobalKey<FormState> _mCycleFormKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  CurrentForm _currentForm = CurrentForm.GOALS;
  bool _isLoading = false;

  //StratigeModel stratige = StratigeModel();

  //
  //------------## Goals Param ##------------//
  GoalModel goal = GoalModel(code: '', id: '0', pointers: []);

  final FocusNode _goalTextFocus = FocusNode();

  List<DropdownMenuItem<DomainModel>> allDomains =
      List<DropdownMenuItem<DomainModel>>();

  List<DropdownMenuItem<CustomerModel>> allBeneficiaries =
      List<DropdownMenuItem<CustomerModel>>();

  List<DropdownMenuItem<EnviromentModel>> allEnviroment =
      List<DropdownMenuItem<EnviromentModel>>();

  //------------## Pointers Param ##------------//
  PointerModel pointer = PointerModel(unit: new UnitsModel());

  final FocusNode _pointerTextFocus = FocusNode();
  final FocusNode _pointerTargetFocus = FocusNode();

  List<DropdownMenuItem<UnitsModel>> allMeasuringUnites =
      List<DropdownMenuItem<UnitsModel>>();

  ///مسئول القياس
  List<DropdownMenuItem<MeasurementOfficerModel>> allMeasurementOfficers =
      MeasurementOfficerModel.allMeasurementOfficers.map((mOffice) {
    return DropdownMenuItem(child: Text(mOffice.name), value: mOffice);
  }).toList();

  List<DropdownMenuItem<MeasurementCycle>> allMeasurementCycles =
      MeasurementCycle.values.map((mCycle) {
    return DropdownMenuItem(child: Text(mCycle.displayTitle), value: mCycle);
  }).toList();

  //------------## ExecuteDeptModel Param ##------------//
  ExecuteDeptModel executionOfficer = ExecuteDeptModel();

  List<dept.Data> listDept = List<dept.Data>();
  dept.Data deptSelect;

  List<DropdownMenuItem<dept.Data>> allDeptSrtModel =
      List<DropdownMenuItem<dept.Data>>();

  getDeptByBrch() async {
    listDept = await _deptService.getMutiDeptByMutiBrch(widget.stratige.brchs);
    // setState(() {
    allDeptSrtModel = listDept.map((ss) {
      return DropdownMenuItem(child: Text(ss.name.toString()), value: ss);
    }).toList();
    //});
  }

  //------------## BranchMCycle Param ##------------//
  OverloadModel brchSrt = OverloadModel();

  List<CustomerModel> listCustomer = List<CustomerModel>();
  getCustomer() async {
    listCustomer = await _customerService.getData();
    setState(() {
      allBeneficiaries = listCustomer.map((beneficiary) {
        return DropdownMenuItem(
            child: Text(beneficiary.name.toString()), value: beneficiary);
      }).toList();
    });
  }

  List<DomainModel> listDomain = List<DomainModel>();
  getDomain() async {
    listDomain = await _domainService.getData();
    setState(() {
      allDomains = listDomain.map((domain) {
        return DropdownMenuItem(
            child: Text(domain.name.toString()), value: domain);
      }).toList();
    });
  }

  List<UnitsModel> listunit = List<UnitsModel>();

  getUnit() async {
    listunit = await _unitService.getData();
    setState(() {
      allMeasuringUnites = listunit.map((mUnit) {
        return DropdownMenuItem(
            child: Text(mUnit.name.toString()), value: mUnit);
      }).toList();
    });
  }

  List<EnviromentModel> listEnvirment = List<EnviromentModel>();

  getData() async {
    await getCustomer();
    await getDomain();

    listEnvirment = await _enviromentService.getData();

    allEnviroment = listEnvirment.map((beneficiary) {
      return DropdownMenuItem(
          child: Text(beneficiary.name), value: beneficiary);
    }).toList();
    await getUnit();

    await getDeptByBrch();
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: _getCurrentAppBar(),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        children: [_getCurrentForm()],
      ),
    );
  }

  Widget _getCurrentForm() {
    switch (_currentForm) {
      case CurrentForm.GOALS:
        return _getGoalsForm();
        break;
      case CurrentForm.POINTERS:
        return _getPointersForm();
        break;
      case CurrentForm.DEPARTMENTS:
        return _getExeOfficerForm();
        break;
      case CurrentForm.M_CYCLE:
        return _getMCycleForm();
        break;
    }
    return Container(child: Text('Error'));
  }

  Widget _getCurrentAppBar() {
    switch (_currentForm) {
      case CurrentForm.GOALS:
        return AppBar(
          title: Text('الأهداف الإستراتيجية'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        );
        break;
      case CurrentForm.POINTERS:
        return AppBar(
          title: Text('مؤشر جديد'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => setState(() => _currentForm = CurrentForm.GOALS),
          ),
        );
        break;
      case CurrentForm.DEPARTMENTS:
        return AppBar(
          title: Text('مسئول التنفيذ'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                setState(() => _currentForm = CurrentForm.POINTERS),
          ),
        );
        break;
      case CurrentForm.M_CYCLE:
        return AppBar(
          title: Text('دورية القياس'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () =>
                setState(() => _currentForm = CurrentForm.DEPARTMENTS),
          ),
        );
        break;
    }
    return AppBar(title: Text('Error'));
  }

  //------------## Goals Form ##------------//
  Widget _getGoalsForm() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _goalsFormKey,
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: FormText.textFormF(
                  context,
                  // _goalTextFocus,
                  goal.name.toString(),
                  'الهدف الإستراتيجي',
                  null,
                  FormValidator().validateisEmpty,
                  (value) => goal.name = value,
                  'الهدف الإستراتيجي',
                  null,
                  [TextInputType.text],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: listDomain.length > 0
                            ? DropdownButtonFormField(
                                decoration:
                                    InputDecoration(labelText: 'المجال'),
                                value: goal.domainModel,
                                icon: Icon(Icons.arrow_drop_down_outlined),
                                iconSize: 24,
                                items: allDomains,
                                onChanged: (value) {
                                  setState(() {
                                    goal.domainModel = value;
                                  });
                                },
                                validator: (value) {
                                  return value == null
                                      ? 'يجب إختيار المجال'
                                      : null;
                                },
                              )
                            : Text('Loading ..'),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.blue,
                          textDirection: TextDirection.rtl,
                          size: 36,
                        ),
                        onPressed: () {
                          goal.domainModel = null;
                          showDialog(
                            context: context,
                            child: DomainForm(),
                          ).then((value) {
                            getDomain();
                            var mod = value as DomainModel;

                            if (allDomains.isNotEmpty)
                              setState(() {
                                allDomains.add(DropdownMenuItem(
                                    child: Text(mod.name), value: mod));
                              });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: listCustomer.length > 0
                            ? DropdownButtonFormField(
                                decoration:
                                    InputDecoration(labelText: 'المستفيد'),
                                value: goal.customerModel,
                                icon: Icon(Icons.arrow_drop_down_outlined),
                                iconSize: 24,
                                items: allBeneficiaries,
                                onChanged: (value) {
                                  setState(() {
                                    goal.customerModel = value;
                                  });
                                },
                                validator: (value) {
                                  return value == null
                                      ? 'يجب إختيار المستفيد'
                                      : null;
                                },
                              )
                            : Text('loading ..'),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.blue,
                          textDirection: TextDirection.rtl,
                          size: 36,
                        ),
                        onPressed: () {
                          goal.customerModel = null;
                          showDialog(
                            context: context,
                            child: CustomerForm(),
                          ).then((value) {
                            // getCustomer();
                            var dd = value as CustomerModel;

                            if (allBeneficiaries.isNotEmpty)
                              setState(() {
                                allBeneficiaries.add(DropdownMenuItem(
                                    child: Text(dd.name), value: dd));
                              });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
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
                                  'المؤشرات: ${goal.pointers.length}',
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
                                  if (_goalsFormKey.currentState.validate()) {
                                    _goalsFormKey.currentState.save();
                                    setState(() {
                                      pointer = PointerModel();
                                      _currentForm = CurrentForm.POINTERS;
                                    });
                                  }
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
                            controller: _scrollController,
                            itemCount: goal.pointers.length,
                            itemBuilder: (_, index) {
                              return PointerList(
                                pointerModel: goal.pointers[index],
                                onPressEdit: _onTapePointerListTile,
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
              Container(
                margin: EdgeInsets.all(10.0),
                child: !_isLoading
                    ? Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'حفظ الهدف',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 17,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await _addGoal();
                            setState(() {
                              _isLoading = false;
                            });
                          },
                        ),
                      )
                    : CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onTapePointerListTile(PointerModel pointerModel) {
    setState(() {
      pointer = pointerModel;
      _currentForm = CurrentForm.POINTERS;
    });
  }

  _onDeletePointerListTile(PointerModel pointerModel) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteAlert(
            questionText: 'هل تريد بالتأكيد حذف المؤشر؟',
            dataFirstRowText: pointerModel.name,
            dataSecondRowText: '',
            isTextDirectionAr: true,
            onPressOKBtn: () async {
              await _deletePointer(pointerModel);
              Navigator.of(context).pop();
            },
          );
        });
  }

  Future<void> _deletePointer(PointerModel pointerModel) async {
    try {
      setState(() {
        goal.pointers.removeAt(goal.pointers
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

  Future<void> _addGoal() async {
    try {
      if (_goalsFormKey.currentState.validate()) {
        _goalsFormKey.currentState.save();
        if (goal.pointers.isNotEmpty) {
          await Future.delayed(Duration(seconds: 5));
          SystemMsg.showMsg(
            _scaffoldKey,
            'تم حفظ الهدف بنجاح',
            SystemMsg.backgroundSuccessColor,
          );
          Navigator.of(context).pop(goal);
          //print(goal.toString());
        } else {
          SystemMsg.showMsg(
            _scaffoldKey,
            'يجب إضافة المؤشرات أولاً',
            SystemMsg.backgroundErrorColor,
          );
        }
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      SystemMsg.timeoutError(_scaffoldKey);
    }
  }

  //------------## Pointers Form ##------------//
  Widget _getPointersForm() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _pointersFormKey,
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: FormText.textFormF(
                  context,
                  // _pointerTextFocus,
                  pointer.name.toString(),
                  'صيغة المؤشر',
                  null,
                  FormValidator().validateisEmpty,
                  (value) => pointer.name = value,
                  'صيغة المؤشر',
                  null,
                  [TextInputType.text],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: listunit.length > 0
                            ? DropdownButtonFormField(
                                decoration:
                                    InputDecoration(labelText: 'وحدة القياس'),
                                value: pointer.unit,
                                icon: Icon(Icons.arrow_drop_down_outlined),
                                iconSize: 24,
                                items: allMeasuringUnites,
                                onChanged: (value) {
                                  var ddd = value as UnitsModel;
                                  // setState(() {
                                  pointer.unit = ddd;
                                  //});
                                },
                                validator: (value) {
                                  return value == null
                                      ? 'يجب إختيار وحدة القياس'
                                      : null;
                                },
                              )
                            : Text('Loading ...'),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.blue,
                          textDirection: TextDirection.rtl,
                          size: 36,
                        ),
                        onPressed: () {
                          pointer.unit = null;
                          showDialog(
                            context: context,
                            child: UnitForm(),
                          ).then((value) {
                            // getUnit();
                            var mUnit = value as UnitsModel;
                            setState(() {
                              allMeasuringUnites.add(DropdownMenuItem(
                                  child: Text(mUnit.name), value: mUnit));
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        'القطبية:',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    Radio(
                      value: Polar.POSITIVE,
                      groupValue: pointer.isNegitive,
                      onChanged: (Polar value) {
                        setState(() {
                          pointer.isNegitive = value;
                        });
                      },
                    ),
                    Text(Polar.POSITIVE.displayTitle),
                    Radio(
                      value: Polar.NEGATIVE,
                      groupValue: pointer.isNegitive,
                      onChanged: (Polar value) {
                        setState(() {
                          pointer.isNegitive = value;
                        });
                      },
                    ),
                    Text(Polar.NEGATIVE.displayTitle),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        'تراكمي:',
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    Radio(
                      value: Cumulative.CUMULATIVE,
                      groupValue: pointer.type,
                      onChanged: (Cumulative value) {
                        setState(() {
                          pointer.type = value;
                        });
                      },
                    ),
                    Text(Cumulative.CUMULATIVE.displayTitle),
                    Radio(
                      value: Cumulative.NON_CUMULATIVE,
                      groupValue: pointer.type,
                      onChanged: (Cumulative value) {
                        setState(() {
                          pointer.type = value;
                        });
                      },
                    ),
                    Text(Cumulative.NON_CUMULATIVE.displayTitle),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: DropdownButtonFormField(
                          decoration:
                              InputDecoration(labelText: 'مسئول القياس'),
                          value: pointer.measurementOfficer,
                          icon: Icon(Icons.arrow_drop_down_outlined),
                          iconSize: 24,
                          items: allMeasurementOfficers,
                          onChanged: (value) {
                            setState(() {
                              pointer.measurementOfficer = value;
                            });
                          },
                          validator: (value) {
                            return value == null
                                ? 'يجب إختيار مسئول القياس'
                                : null;
                          },
                        ),
                      ),
                    ),
                    Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                          color: Colors.blue,
                          textDirection: TextDirection.rtl,
                          size: 36,
                        ),
                        onPressed: () {
                          pointer.measurementOfficer = null;
                          showDialog(
                            context: context,
                            child: MeasurementOfficerForm(),
                          ).then((value) {
                            setState(() {
                              allMeasurementOfficers = MeasurementOfficerModel
                                  .allMeasurementOfficers
                                  .map((mOffice) {
                                return DropdownMenuItem(
                                    child: Text(mOffice.name), value: mOffice);
                              }).toList();
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: FormText.textFormF(
                  context,
                  //_pointerTargetFocus,
                  pointer.qty.toString(),
                  'مستهدفين المؤشر',
                  null,
                  FormValidator().validateNumberNonZero,
                  (value) => pointer.qty = double.parse(value),
                  'مستهدفين المؤشر',
                  null,
                  [TextInputType.number],
                ),
              ),
              Card(
                child: Container(
                  margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                  padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          'دورية القياس',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                        alignment: Alignment.centerRight,
                      ),
                      Divider(),
                      Container(
                        child: GridView.builder(
                          padding: EdgeInsets.all(0.0),
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: MeasurementCycle.values.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 4),
                          ),
                          itemBuilder: (_, index) {
                            //print('Before');
                            //print(pointer.pointerMCycle.toString());
                            var mCycle = MeasurementCycle.values[index];
                            return Container(
                              margin: EdgeInsets.all(0.0),
                              padding: EdgeInsets.all(0.0),
                              height: 10,
                              alignment: Alignment.center,
                              child: Row(
                                children: [
                                  Container(
                                    child: Checkbox(
                                      value: pointer.pointerMCycle[mCycle],
                                      onChanged: (bool value) {
                                        setState(() {
                                          pointer.pointerMCycle[mCycle] = value;
                                        });
                                        //print('After');
                                        //print(pointer.pointerMCycle.toString());
                                      },
                                    ),
                                  ),
                                  Container(child: Text(mCycle.displayTitle)),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: Card(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(3.0, 0.0, 3.0, 0.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Text(
                                  'مسئولين التنفيذ (الأقسام): ${pointer.executeDept.length}',
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
                                  if (_pointersFormKey.currentState
                                      .validate()) {
                                    _pointersFormKey.currentState.save();
                                    if (pointer.pointerMCycle.values
                                        .any((e) => e == true)) {
                                      setState(() {
                                        // getDeptByBrch();
                                        executionOfficer = ExecuteDeptModel();
                                        _currentForm = CurrentForm.DEPARTMENTS;
                                      });
                                    } else {
                                      SystemMsg.showMsg(
                                        _scaffoldKey,
                                        'يجب تحديد أشهر دورية القياس',
                                        SystemMsg.backgroundErrorColor,
                                      );
                                    }
                                  }
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
                            controller: _scrollController,
                            itemCount: pointer.executeDept.length,
                            itemBuilder: (_, index) {
                              return ExecutionDeptList(
                                executionOfficer: pointer.executeDept[index],
                                onPressEdit: _onTapeExecutionOfficerListTile,
                                onPressDelete:
                                    _onDeleteExecutionOfficerListTile,
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
              Container(
                margin: EdgeInsets.all(10.0),
                child: !_isLoading
                    ? Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'حــفــظ الـمـؤشـر',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await _addPointer();
                            setState(() {
                              _isLoading = false;
                            });
                          },
                        ),
                      )
                    : CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onTapeExecutionOfficerListTile(ExecuteDeptModel exeOfficer) {
    setState(() {
      executionOfficer = exeOfficer;
      _currentForm = CurrentForm.DEPARTMENTS;
    });
  }

  _onDeleteExecutionOfficerListTile(ExecuteDeptModel executionOfficer) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteAlert(
            questionText: 'هل تريد بالتأكيد حذف مسئول التنفيذ؟',
            dataFirstRowText: executionOfficer.nameDept,
            dataSecondRowText: '',
            isTextDirectionAr: true,
            onPressOKBtn: () async {
              await _deleteExecutionOfficer(executionOfficer);
              Navigator.of(context).pop();
            },
          );
        });
  }

  Future<void> _deleteExecutionOfficer(ExecuteDeptModel eOfficer) async {
    try {
      setState(() {
        pointer.executeDept.removeAt(pointer.executeDept
            .indexWhere((element) => element.id == eOfficer.id));
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

  Future<void> _addPointer() async {
    try {
      if (_pointersFormKey.currentState.validate()) {
        _pointersFormKey.currentState.save();
        if (pointer.executeDept.isNotEmpty) {
          setState(() {
            goal.pointers.add(pointer);
            pointer = PointerModel();
            _currentForm = CurrentForm.GOALS;
          });
          SystemMsg.showMsg(
            _scaffoldKey,
            'تم حفظ المؤشر بنجاح',
            SystemMsg.backgroundSuccessColor,
          );
        } else {
          SystemMsg.showMsg(
            _scaffoldKey,
            'يجب إضافة مسئولين التنفيذ أولاً',
            SystemMsg.backgroundErrorColor,
          );
        }
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      SystemMsg.timeoutError(_scaffoldKey);
    }
  }

  //------------## ExecuteDeptModel Form ##------------//

  Widget _getExeOfficerForm() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _exeOfficerFormKey,
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: Text('عدد مستهدفين المؤشر: ${pointer.qty.toString()}'),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: DropdownButtonFormField(
                  decoration: InputDecoration(labelText: 'القسم مسئول التنفيذ'),
                  value: deptSelect,
                  icon: Icon(Icons.arrow_drop_down_outlined),
                  iconSize: 24,
                  items: allDeptSrtModel,
                  onChanged: (value) {
                    dept.Data ddd = value as dept.Data;
                    deptSelect = ddd;

                    setState(() {
                      executionOfficer = ExecuteDeptModel(
                          id: ddd.id,
                          nameDept: ddd.name,
                          idDeptName: int.parse(ddd.idNameDept));

                      ///Error  ارجاع جميع الاقسام بواسطه القسم والفرع الغير موجود به يحدف
                      for (int i = 0; i < widget.stratige.brchs.length; i++) {
                        var mode = OverloadModel(
                            id: 0,
                            idBrch: widget.stratige.brchs[i].idBrch,
                            qty: 0,
                            type: '',
                            finishMCycle: false,
                            nameBrch: widget.stratige.brchs[i].name,
                            measurCycleMounthModel: []);

                        executionOfficer.overload.add(mode);
                        /*executionOfficer.overload =
                          executionOfficer.getAllBranchStrByDept(value);*/
                      }
                    });
                  },
                  validator: (value) {
                    return value == null
                        ? 'يجب إختيار القسم مسئول التنفيذ'
                        : null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                padding: EdgeInsets.all(5.0),
                child: Container(
                  padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                  child: Card(
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'توزيع المستهدفات على الفروع',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Divider(),
                        Container(
                          child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            controller: _scrollController,
                            itemCount: executionOfficer.overload.length,
                            itemBuilder: (_, index) {
                              return BrunchLoadList(
                                brchSrt: executionOfficer.overload[index],
                                onPressMCycle: _onPressMCycle,
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
              Container(
                margin: EdgeInsets.all(10.0),
                child: !_isLoading
                    ? Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'حفظ مسئول التنفيذ',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await _addExeOfficer();
                            setState(() {
                              _isLoading = false;
                            });
                          },
                        ),
                      )
                    : CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _onPressMCycle(OverloadModel brch) {
    if (_exeOfficerFormKey.currentState.validate()) {
      _exeOfficerFormKey.currentState.save();
      if (executionOfficer.overload
              .map((e) => e.qty)
              .fold(0, (previousValue, element) => previousValue + element) !=
          100) {
        SystemMsg.showMsg(
          _scaffoldKey,
          'يجب أن يكون مجموع التوزيع 100%',
          SystemMsg.backgroundErrorColor,
        );
        return 0;
      }

      brch.branchMCycle = widget.stratige.years.map((year) {
        return BranchMCycle(
            year.name,
            year.name,
            pointer.pointerMCycle.keys
                .where((element) => pointer.pointerMCycle[element] == true)
                .map((e) {
              return MCycleTarget(e.index.toString(), e, 0);
            }).toList());
      }).toList();
      setState(() {
        brchSrt = brch;
        _currentForm = CurrentForm.M_CYCLE;
      });
    }
  }

  Future<void> _addExeOfficer() async {
    try {
      if (_exeOfficerFormKey.currentState.validate()) {
        _exeOfficerFormKey.currentState.save();
        if (executionOfficer.overload.isEmpty) {
          SystemMsg.showMsg(
            _scaffoldKey,
            'القسم المحدد لايحتوي على فروع',
            SystemMsg.backgroundErrorColor,
          );
          return 0;
        }
        if (executionOfficer.overload
                .map((e) => e.qty)
                .fold(0, (previousValue, element) => previousValue + element) !=
            100) {
          SystemMsg.showMsg(
            _scaffoldKey,
            'يجب أن يكون مجموع التوزيع 100%',
            SystemMsg.backgroundErrorColor,
          );
          return 0;
        }
        if (executionOfficer.overload
            .any((branchStr) => branchStr.finishMCycle == false)) {
          SystemMsg.showMsg(
            _scaffoldKey,
            'يجب الإنتهاء من توزيع الأحمال ودورات القياس',
            SystemMsg.backgroundErrorColor,
          );
          return 0;
        }
        setState(() {
          pointer.executeDept.add(executionOfficer);
          executionOfficer = ExecuteDeptModel();
          _currentForm = CurrentForm.POINTERS;
        });
        SystemMsg.showMsg(
          _scaffoldKey,
          'تم حفظ مسئول التنفيذ بنجاح',
          SystemMsg.backgroundSuccessColor,
        );
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      SystemMsg.timeoutError(_scaffoldKey);
    }
  }

  //------------## BranchMCycle Form ##------------//
  Widget _getMCycleForm() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _mCycleFormKey,
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(5.0),
                padding: EdgeInsets.all(7.0),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('الفرع: ${brchSrt.nameBrch}',
                        style: TextStyle(fontWeight: FontWeight.w900)),
                    Text(
                        'المستهدفين بحسب نسبة التحمل ${(brchSrt.qty / 100) * pointer.qty}',
                        style: TextStyle(fontWeight: FontWeight.w900)),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: Column(
                  children:
                      List<Widget>.generate(brchSrt.branchMCycle.length, (i) {
                    return ExpandablePanel(
                      controller: ExpandableController(initialExpanded: i == 0),
                      header: Text(brchSrt.branchMCycle[i].year),
                      expanded: Column(
                        children: List<Widget>.generate(
                            brchSrt.branchMCycle[i].mCycleTarget.length, (j) {
                          return Row(
                            children: [
                              Container(
                                width: 65,
                                alignment: Alignment.center,
                                child: Text(brchSrt
                                    .branchMCycle[i]
                                    .mCycleTarget[j]
                                    .measurementCycle
                                    .displayTitle),
                              ),
                              Expanded(
                                child: FormText.textFormF(
                                  context,
                                  // null,
                                  brchSrt.branchMCycle[i].mCycleTarget[j]
                                      .cycleTarget
                                      .toString(),
                                  'المستهدفين',
                                  null,
                                  FormValidator().validateNumberNonZero,
                                  (value) => brchSrt
                                      .branchMCycle[i]
                                      .mCycleTarget[j]
                                      .cycleTarget = int.parse(value),
                                  'المستهدفين',
                                  null,
                                  [TextInputType.number],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    );
                  }),
                ),
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                child: !_isLoading
                    ? Container(
                        height: 50.0,
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'حــفــظ دورة القياس',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await _addMCycle();
                            setState(() {
                              _isLoading = false;
                            });
                          },
                        ),
                      )
                    : CircularProgressIndicator(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addMCycle() async {
    try {
      if (_mCycleFormKey.currentState.validate()) {
        _mCycleFormKey.currentState.save();
        if (brchSrt.branchMCycle
                .map((e) => e.mCycleTarget
                    .fold(0, (prev, element) => prev + element.cycleTarget))
                .fold(0, (pr, el) => pr + el) !=
            ((brchSrt.qty / 100) * pointer.qty)) {
          SystemMsg.showMsg(
            _scaffoldKey,
            'يجب أن يكون التوزيع مساوي للمستهدفين',
            SystemMsg.backgroundErrorColor,
          );
          return 0;
        }
        setState(() {
          brchSrt.finishMCycle = true;
          executionOfficer.overload[executionOfficer.overload.indexWhere(
              (element) => element.nameBrch == brchSrt.nameBrch)] = brchSrt;
          brchSrt = OverloadModel();
          _currentForm = CurrentForm.DEPARTMENTS;
        });
        SystemMsg.showMsg(
          _scaffoldKey,
          'تم حفظ دورة القياس بنجاح',
          SystemMsg.backgroundSuccessColor,
        );
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      SystemMsg.timeoutError(_scaffoldKey);
    }
  }
}

enum CurrentForm { GOALS, POINTERS, DEPARTMENTS, M_CYCLE }

class PointerList extends StatelessWidget {
  final PointerModel pointerModel;
  final Function(PointerModel) onPressDelete;
  final Function(PointerModel) onPressEdit;

  const PointerList(
      {Key key, this.pointerModel, this.onPressEdit, this.onPressDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        pointerModel.name,
        textAlign: TextAlign.start,
        textDirection: TextDirection.rtl,
        softWrap: true,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
          color: Colors.redAccent,
          textDirection: TextDirection.rtl,
          size: 36,
        ),
        onPressed: () async {
          await onPressDelete(pointerModel);
        },
      ),
      onTap: () => onPressEdit(pointerModel),
    );
  }
}

/*


*/
class MeasurementOfficerForm extends StatefulWidget {
  @override
  _MeasurementOfficerFormState createState() => _MeasurementOfficerFormState();
}

class _MeasurementOfficerFormState extends State<MeasurementOfficerForm> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _measurementOfficerFormKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  MeasurementOfficerModel measurementOfficerModel = MeasurementOfficerModel();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return _getMeasurementOfficerForm();
  }

  Widget _getMeasurementOfficerForm() {
    var mainWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: SimpleDialog(
        title: Container(
          width: mainWidth,
          decoration: BoxDecoration(
            color: Colors.blueGrey,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 5,
                offset: Offset(0, 5),
              ),
            ],
          ),
          padding: EdgeInsets.all(7),
          child: Text(
            'إضافة مسئول القياس',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        children: [
          Container(
            width: mainWidth,
            padding: EdgeInsets.all(10.0),
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              controller: _scrollController,
              children: [
                Form(
                  key: _measurementOfficerFormKey,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: FormText.textFormF(
                          context,
                          // null,
                          measurementOfficerModel.name,
                          'مسئول القياس',
                          null,
                          FormValidator().validateisEmpty,
                          (value) => measurementOfficerModel.name = value,
                          'مسئول القياس',
                          null,
                          [TextInputType.text],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(10.0),
                        child: !_isLoading
                            ? Container(
                                height: 50.0,
                                width: MediaQuery.of(context).size.width,
                                child: RaisedButton(
                                  color: Colors.blue,
                                  child: Text(
                                    'حــفــظ مسئول القياس',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    await _addMeasurementOfficer();
                                    setState(() {
                                      _isLoading = false;
                                    });
                                  },
                                ),
                              )
                            : CircularProgressIndicator(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addMeasurementOfficer() async {
    try {
      if (_measurementOfficerFormKey.currentState.validate()) {
        _measurementOfficerFormKey.currentState.save();
        MeasurementOfficerModel.addMeasurementOfficer(
            this.measurementOfficerModel);
        SystemMsg.showMsg(
          _scaffoldKey,
          'تم حفظ مسئول القياس بنجاح',
          SystemMsg.backgroundSuccessColor,
        );
        Navigator.of(context).pop();
      }
    } catch (ex, st) {
      print(ex);
      print(st);
      SystemMsg.timeoutError(_scaffoldKey);
    }
  }
}

//----------------## Views Shared ##----------------------//
class DeleteAlert extends StatefulWidget {
  final Function() onPressOKBtn;
  final String questionText;
  final String dataFirstRowText;
  final String dataSecondRowText;
  final bool isTextDirectionAr;

  const DeleteAlert(
      {Key key,
      this.onPressOKBtn,
      this.questionText,
      this.dataFirstRowText,
      this.dataSecondRowText,
      this.isTextDirectionAr})
      : super(key: key);

  @override
  _DeleteAlertState createState() => _DeleteAlertState();
}

class _DeleteAlertState extends State<DeleteAlert> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    Widget okBtn = RaisedButton(
        color: Colors.redAccent,
        onPressed: () async {
          setState(() {
            _isDeleting = true;
          });
          await widget.onPressOKBtn();
          setState(() {
            _isDeleting = false;
          });
        },
        child: Text('حــذف'));

    Widget cancelBtn = FlatButton(
        color: Colors.blueGrey,
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: Text('إلغاء'));

    return AlertDialog(
      title: Container(
        child: Text(
          'تأكيد الحذف',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      content: Container(
        child: Column(
          textDirection: TextDirection.rtl,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.questionText,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.redAccent),
            ),
            Text(
              widget.dataFirstRowText,
              textDirection: widget.isTextDirectionAr
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            Text(
              widget.dataSecondRowText,
              textDirection: widget.isTextDirectionAr
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0.0, 13.0, 0.0, 0.0),
              child: !_isDeleting
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      textDirection: TextDirection.rtl,
                      children: [
                        Center(child: okBtn),
                        Center(child: cancelBtn),
                      ],
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
          ],
        ),
      ),
    );
  }
}

class SystemMsg {
  static Color backgroundErrorColor = Colors.redAccent;
  static Color backgroundSuccessColor = Colors.greenAccent;
  static Duration operationTimeout = Duration(seconds: 20);

  static timeoutError(GlobalKey<ScaffoldState> _scaffoldKey) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        'حدث خطاء في الإتصال يرجى المحاولة مرة أخرى',
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: Colors.redAccent,
    ));
  }

  static showMsg(GlobalKey<ScaffoldState> _scaffoldKey, String msg,
      Color backgroundColor) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        msg,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w300, fontSize: 16),
      ),
      duration: Duration(seconds: 4),
      backgroundColor: backgroundColor,
    ));
  }
}
