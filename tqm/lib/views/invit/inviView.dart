//----------------## Initiative Page المبادرات ##----------------------//
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tqm/models/Stratige/Goal.dart';
import 'package:tqm/models/Stratige/Pointer.dart';
import 'package:tqm/models/Stratige/Stratige.dart';
import 'package:tqm/models/Stratige/intiative/intiativeModel.dart';
import 'package:tqm/services/Stratege/stratigeService.dart';
import 'package:tqm/views/goal/goalView.dart';
import 'package:tqm/views/shareView/FormText.dart';

StratigeService _stratigeService = StratigeService();

class InitiativePage extends StatefulWidget {
  @override
  _InitiativePageState createState() => _InitiativePageState();
}

class _InitiativePageState extends State<InitiativePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final GlobalKey<FormState> _initiativeFormKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  //File _image;
  final picker = ImagePicker();
  InitiativeModel initiative = InitiativeModel();

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('إضافة مبادرة'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        controller: _scrollController,
        children: [_getInitiativeForm()],
      ),
    );
  }

  Widget _getInitiativeForm() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Form(
        key: _initiativeFormKey,
        child: Container(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                alignment: Alignment.center,
                child: Text(
                  'بيانات المبادرة',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 30),
                ),
              ),
              Container(
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                    },
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Color(0xffFDCF09),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(85),
                        child: initiative.initiativeImg == null
                            ? Center(
                                child: Icon(
                                Icons.photo,
                                size: 36,
                              ))
                            : Image.file(
                                initiative.initiativeImg,
                                width: 200,
                                height: 200,
                                fit: BoxFit.fitHeight,
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                child: FormText.textFormF(
                  context,
                  // null,
                  initiative.name,
                  'إسم المبادرة',
                  null,
                  FormValidator().validateisEmpty,
                  (value) => initiative.name = value,
                  'إسم المبادرة',
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
                        padding: EdgeInsets.all(5.0),
                        alignment: Alignment.center,
                        child: Text(
                          initiative.initiativeFile == null
                              ? 'الملف التعريفي'
                              : initiative.initiativeFile.toString(),
                          //textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text('إضافة ملف تعريفي'),
                        color: Colors.blue,
                        onPressed: () async {
                          var result = await FilePicker.getFile(
                            type: FileType.any,
                            //allowedExtensions: ['pdf','wmv']
                          );
                          if (result != null) {
                            setState(() {
                              initiative.initiativeFile = result;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(width: 1.5),
                      bottom: BorderSide(width: 1.5)),
                ),
                child: Container(
                  padding: EdgeInsets.fromLTRB(7.0, 0.0, 7.0, 0.0),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'المؤشرات',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.right,
                        ),
                      ),
                      Container(
                        child: ListView.separated(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          controller: _scrollController,
                          itemCount: initiative.initiativePointers.length,
                          itemBuilder: (_, index) {
                            return InitiativePointersList(
                              initiativePointerModel:
                                  initiative.initiativePointers[index],
                              onPressDelete: _onDeleteInitiativePointers,
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
                      Container(
                        margin: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
                        alignment: Alignment.centerLeft,
                        child: FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) {
                                return InitiativePointersAlert(
                                  addInitiativePointers: _addInitiativePointers,
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
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
                            'حــفــظ المبادرة',
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 20,
                            ),
                          ),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await _addInitiative();
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

  _onDeleteInitiativePointers(InitiativePointersModel initiativePointer) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteAlert(
            questionText: 'هل تريد بالتأكيد حذف المؤشر؟',
            dataFirstRowText: initiativePointer.pointer.name,
            dataSecondRowText: '',
            isTextDirectionAr: true,
            onPressOKBtn: () {
              setState(() {
                initiative.initiativePointers.remove(initiativePointer);
              });
              Navigator.of(context).pop();
            },
          );
        });
  }

  _addInitiativePointers(List<PointerModel> pointers) {
    setState(() {
      initiative.initiativePointers.clear();
      initiative.initiativePointers
          .addAll(pointers.map((e) => InitiativePointersModel(e.id, e, 0)));
    });
  }

  _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Container(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('اختيار صورة'),
                  onTap: () {
                    _imageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_camera),
                  title: Text('إلتقاط صورة'),
                  onTap: () {
                    _imageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  _imageFromGallery() async {
    final pickedImage =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedImage != null) {
      setState(() {
        initiative.initiativeImg = File(pickedImage.path);
      });
    }
  }

  _imageFromCamera() async {
    final pickedImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedImage != null) {
      setState(() {
        initiative.initiativeImg = File(pickedImage.path);
      });
    }
  }

  Future<void> _addInitiative() async {
    try {
      if (_initiativeFormKey.currentState.validate()) {
        _initiativeFormKey.currentState.save();
        if (initiative.initiativePointers.isNotEmpty) {
          await Future.delayed(Duration(seconds: 5));
          SystemMsg.showMsg(
            _scaffoldKey,
            'تم حفظ المبادرة بنجاح',
            SystemMsg.backgroundSuccessColor,
          );
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
}

class InitiativePointersList extends StatelessWidget {
  final InitiativePointersModel initiativePointerModel;
  final Function(InitiativePointersModel) onPressDelete;

  const InitiativePointersList(
      {Key key, this.initiativePointerModel, this.onPressDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.all(1.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              child: Text(initiativePointerModel.pointer.name),
            ),
          ),
          Container(
            width: 100,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border(
                  right: BorderSide(width: 1), left: BorderSide(width: 1)),
            ),
            padding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
            child: FormText.textFormF(
              context,
              //null,
              initiativePointerModel.coverageRatio.toString(),
              'النسبة',
              null,
              FormValidator().validateNumberNonZero,
              (value) =>
                  initiativePointerModel.coverageRatio = int.parse(value),
              'النسبة',
              null,
              [TextInputType.number],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(1.0, 0.0, 1.0, 0.0),
            child: IconButton(
              padding: EdgeInsets.all(0.0),
              icon: Icon(
                Icons.delete,
                color: Colors.redAccent,
                textDirection: TextDirection.rtl,
                size: 32,
              ),
              onPressed: () async {
                await onPressDelete(initiativePointerModel);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class InitiativePointersAlert extends StatefulWidget {
  final Function(List<PointerModel>) addInitiativePointers;

  const InitiativePointersAlert({Key key, this.addInitiativePointers})
      : super(key: key);

  @override
  _InitiativePointersAlertState createState() =>
      _InitiativePointersAlertState();
}

class _InitiativePointersAlertState extends State<InitiativePointersAlert> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  final ScrollController _scrollController = ScrollController();

  getStr() async {
    var sss = await _stratigeService.getData();
    setState(() {
      dumpStratigeList = sss.map((stratige) {
        return DropdownMenuItem(child: Text(stratige.name), value: stratige);
      }).toList();
    });
  }

  List<DropdownMenuItem<StratigeModel>> dumpStratigeList;

  StratigeModel selectedStratige;
  GoalModel selectedGoal;
  List<PointerModel> pointers = [];

  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    getStr();
  }

  @override
  Widget build(BuildContext context) {
    var mainWidth = MediaQuery.of(context).size.width;
    return Container(
      width: mainWidth,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
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
                'المؤشرات المرتبطة بالمبادرة',
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
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'الإستراتيجية'),
                        value: selectedStratige,
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        iconSize: 24,
                        items: dumpStratigeList,
                        onChanged: (value) {
                          setState(() {
                            selectedStratige = value;
                            selectedGoal = null;
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(labelText: 'الأهداف'),
                        value: selectedGoal,
                        icon: Icon(Icons.arrow_drop_down_outlined),
                        iconSize: 24,
                        isExpanded: true,
                        items: selectedStratige == null
                            ? null
                            : selectedStratige.goals.map((goal) {
                                return DropdownMenuItem(
                                    child: Text(
                                      goal.name,
                                      softWrap: true,
                                    ),
                                    value: goal);
                              }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedGoal = value;
                            pointers.clear();
                          });
                        },
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'المؤشرات',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                controller: _scrollController,
                                shrinkWrap: true,
                                itemCount: selectedGoal == null ||
                                        selectedGoal.pointers == null
                                    ? 0
                                    : selectedGoal.pointers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                    child: Container(
                                      child: CheckboxListTile(
                                        title: Text(
                                            selectedGoal.pointers[index].name),
                                        value: pointers.contains(
                                            selectedGoal.pointers[index]),
                                        onChanged: (bool val) {
                                          //print('val: $val');
                                          setState(() {
                                            if (val) {
                                              pointers.add(
                                                  selectedGoal.pointers[index]);
                                            } else {
                                              pointers.remove(
                                                  selectedGoal.pointers[index]);
                                            }
                                          });
                                          //print('pointers.length');
                                          //print(pointers.length);
                                        },
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10.0),
                      child: !_isLoading
                          ? Container(
                              height: 50.0,
                              width: mainWidth,
                              child: RaisedButton(
                                color: Colors.blue,
                                child: Text(
                                  'إضافة المؤشرات للمبادرة',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                  if (pointers != null && pointers.isNotEmpty) {
                                    widget.addInitiativePointers(pointers);
                                    Navigator.of(context).pop();
                                  } else {
                                    SystemMsg.showMsg(
                                      _scaffoldKey,
                                      'يجب تحديد المؤشرات أولاً',
                                      SystemMsg.backgroundErrorColor,
                                    );
                                  }
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
      ),
    );
  }
}
