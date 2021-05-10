import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
//import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:tqm/models/docsModel.dart';
import 'package:tqm/models/empModel.dart';
import 'package:tqm/services/empService.dart';
import 'package:tqm/shared_widgets/custom_bottom_sheet_widget.dart';
import 'package:tqm/utils/network_utils/StateAPi.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/shareView/DefaultButton.dart';
import 'package:tqm/views/shareView/FormText.dart';

EmpService _empService = EmpService();

class EmpDetials extends StatefulWidget {
  final EmpModel data;
  String typeOp;

  EmpDetials({Key key, this.data, this.typeOp = 'New'}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _EmpOnePageState();
  }
}

class _EmpOnePageState extends State<EmpDetials> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  final UiUtilities uiUtilities = UiUtilities();
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = TextEditingController();
  List<String> teams = [];
  final nameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final urlFocusNode = FocusNode();

  final numFocusNode = FocusNode();

  File _imageFile;
  List<Options> options;

  getProfileFromCamera() async {
    await uiUtilities
        .getImage(imageSource: ImageSource.camera)
        .then((file) async {
      File croppedFile = await uiUtilities.getCroppedFile(file: file.path);

      if (croppedFile != null) {
        setState(() {
          _imageFile = croppedFile;
        });
      }
    });
  }

  getProfileFromGallery() async {
    await uiUtilities
        .getImage(imageSource: ImageSource.gallery)
        .then((file) async {
      File croppedFile = await uiUtilities.getCroppedFile(file: file.path);

      if (croppedFile != null) {
        setState(() {
          _imageFile = croppedFile;
        });
      }
    });
  }

  @override
  void initState() {
    if (widget.data.id != '-1') widget.typeOp = 'Edit';

    options = [
      Options(
          label: 'التقاط صورة',
          onTap: () {
            Navigator.pop(context);
            getProfileFromCamera();
          }),
      Options(
          label: 'اختيار من الجهاز',
          onTap: () {
            Navigator.pop(context);
            getProfileFromGallery();
          }),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget docStream = StreamBuilder<List<DocsModel>>(
      stream: _empService.getDoc(widget.data.id).asStream(),
      builder: (BuildContext context, AsyncSnapshot<List<DocsModel>> snapshot) {
        List<Widget> children;
        if (snapshot.hasError) {
          return StateNetWork.hasErrorStrWidegt('Error: ${snapshot.error}');
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return StateNetWork.connectionNoneWidegt();
              break;
            case ConnectionState.waiting:
              return StateNetWork.connectionWaitWidegt();
              break;
            case ConnectionState.active:
              return StateNetWork.connectionActiveWidegt('\$${snapshot.data}');

              break;
            case ConnectionState.done:
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: NeverScrollableScrollPhysics(),
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if (widget.data.docs == null) {
                    widget.data.docs = new List<DocsModel>();
                  }

                  widget.data.docs.add(snapshot.data[index]);
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      snapshot.data[index].path,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );

              break;
          }
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        );
      },
    );

    _delete() async {
      final UiUtilities uiUtilities = UiUtilities();

      try {
        BotToast.showLoading(
            allowClick: false,
            clickClose: false,
            backButtonBehavior: BackButtonBehavior.ignore);

        bool s = await _empService.delete(widget.data.id);
        BotToast.closeAllLoading();

        if (s) {
          Navigator.of(context).pop();

          uiUtilities.alertNotification(
              context: context,
              message: 'تم حدف بيانات الموظف :(${widget.data.id})');
        } else {
          uiUtilities.alertNotification(
              context: context,
              message: 'حدث خطا اثناء الحدف تاكد من اتصالك بالانترنت');
        }
      } catch (eee) {
        BotToast.closeAllLoading();

        uiUtilities.alertNotification(
            context: context,
            message: 'حدث خطا اثناء الحدف تاكد من اتصالك بالانترنت');
      }
    }

    showAlertDialog(BuildContext context) {
      // set up the button
      Widget okButton = FlatButton(
        child: Text("موافق "),
        onPressed: () {
          _delete();
          Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.redAccent,
            child: Icon(
              Icons.help,
              color: Colors.white,
            )),
        content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'هل انت متاكد من حدف',
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                softWrap: true,
              ),
              Text(
                widget.data.name,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 10, color: Colors.black87),
              ),
            ]),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: customRedColor,
          actions: [
            InkWell(
              onTap: () {
                if (widget.typeOp == 'New')
                  Navigator.pop(context);
                else {
                  showAlertDialog(context);
                  //عرض ديالوج الحدف
                }
              },
              child: Center(
                child: Text(
                  widget.typeOp == 'New' ? 'الغاء ' : 'حدف الموظف ',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
          title: Text(
            widget.typeOp == 'New' ? 'موظف جديد' : widget.data.name,
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: new Center(
            child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 130,
                floating: true,
                pinned: true,
                snap: true,
                /*actions: <Widget>[
                 /* Text('الدولة'),
                  Text('مدينة'),*/
                ],*/
                leading: Container(),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    /* title: 
                    Container(
                      decoration: BoxDecoration(color: Colors.black26),
                      child: Text('مؤسسة جديدة',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                    ),*/
                    background: Container(
                      //color: Colors.red,
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Center(
                            child: _imageFile == null
                                ? GestureDetector(
                                    onTap: () async {
                                      Platform.isIOS
                                          ? showCupertinoModalPopup<void>(
                                              context: context,
                                              builder: (context) {
                                                return CustomBottomSheetWidget(
                                                  options: options,
                                                );
                                              })
                                          : showModalBottomSheet<void>(
                                              context: context,
                                              builder: (context) {
                                                return CustomBottomSheetWidget(
                                                  height: 205,
                                                  options: options,
                                                );
                                              });
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: DottedBorder(
                                        borderType: BorderType.Circle,
                                        radius: Radius.circular(6),
                                        color: customGreyColor,
                                        dashPattern: [6, 3, 6, 3],
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(45)),
                                          child: Container(
                                            height: 100,
                                            width: 100,
                                            color:
                                                customGreyColor.withOpacity(.2),
                                            child: Center(
                                                child: Icon(
                                              MaterialIcons.person_add,
                                              color: customGreyColor,
                                            )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor: Colors.primaries[Random()
                                            .nextInt(Colors.primaries.length)]
                                        .withOpacity(.2),
                                    radius: 60,
                                    backgroundImage: _imageFile == null
                                        ? ExactAssetImage(
                                            'assets/image/user.jpg')
                                        : FileImage(_imageFile),
                                  ),
                          ),

                          /* Center(
                            child: TextButton(
                          child: Text(
                            'تعديل صورة الموظف',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: customRedColor),
                          ),
                          onPressed: () {
                            Platform.isIOS
                                ? showCupertinoModalPopup<void>(
                                    context: context,
                                    builder: (context) {
                                      return CustomBottomSheetWidget(
                                        options: options,
                                      );
                                    })
                                : showModalBottomSheet<void>(
                                    context: context,
                                    builder: (context) {
                                      return CustomBottomSheetWidget(
                                        height: 205,
                                        options: options,
                                      );
                                    });
                          },
                        )),*/
                        ],
                      ),

                      /* Image.asset(
                                "assets/image/logo.png",
                      fit: BoxFit.cover,
                      
                      
                  ),*/
                    )),
              ),
            ];
          },
          body: SafeArea(
              child: Form(
            key: _key,
            autovalidate: _validate,
            child: _getFormUI(),
          )),
        )));
  }

  Widget _getFormUI() {
    return ListView(padding: EdgeInsets.all(24), children: [
      //new SizedBox(height: 2.0),
      FormText.textFormIconLess(context, widget.data.name.toString(),
          'اسم الموظف', FormValidator().validateisEmpty, (String value) {
        widget.data.name = value;
      }, 'اسم الموظف', null),
      new SizedBox(height: 5.0),
      FormText.textFormF(
          context,
          widget.data.numIdityfy,
          ' رقم  الهوية',
          new Icon(
            Icons.format_list_numbered,
            textDirection: TextDirection.ltr,
            semanticLabel: ' رقم  الهوية',
          ),
          FormValidator().validateisEmpty, (String value) {
        widget.data.numIdityfy = value;
      }, 'رقم  الهوية', null),
      FormText.textFormF(
        context,
        widget.data.address,
        'العنوان',
        null,
        FormValidator().validateisNull,
        (String value) {
          widget.data.address = value;
        },
        'العنوان',
        GestureDetector(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
                fullscreenDialog: true,
                builder: (c) {
                  //return BspAddressmapscreen();
                }));
          },
          child: Icon(
            Icons.public_rounded,
            semanticLabel: 'Select Location ',
          ),
        ),
      ),
      FormText.textFormF(
          context,
          widget.data.email,
          ' ايميل الموظف',
          Icon(
            Icons.email,
            textDirection: TextDirection.ltr,
            semanticLabel: 'الايميل ',
          ),
          FormValidator().validateisEmail, (String value) {
        widget.data.email = value;
      }, 'الايميل', null),
      FormText.textFormF(
          context,
          widget.data.phone,
          ' جوال الموظف',
          new Icon(
            Icons.phone,
            textDirection: TextDirection.ltr,
            semanticLabel: 'جوال الموظف',
          ),
          FormValidator().validateisNull
          // FormValidator().validateisEmpty
          , (String value) {
        widget.data.phone = value;
      }, 'الجوال ', null),
      new SizedBox(height: 5.0),
      Text(' : الوثائق  :'),
      Row(
        children: [
          /* widget.data.docs.isEmpty  || widget.typeOp=='New'
                      ? Padding(
                          padding: EdgeInsets.only(
                              left: _taskManager.assignees.length < 3
                                  ? 35
                                  : 100.0),
                          child: FlutterImageStack(
                            imageList: _taskManager.imagesList,
                            extraCountTextStyle:
                                Theme.of(context).textTheme.subtitle2,
                            imageBorderColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            imageRadius: 40,
                            imageCount: _taskManager.assignees.length,
                            imageBorderWidth: 1,
                            showTotalCount: true,
                            backgroundColor: Colors.primaries[
                                    Random().nextInt(Colors.primaries.length)]
                                .withOpacity(.5),
                            totalCount: _taskManager.assignees.length - 1,
                          ),
                        )
                      : SizedBox.shrink(),*/

          FutureBuilder<List<DocsModel>>(
              future: _empService.getDoc(widget.data.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting &&
                    !snapshot.hasData) {
                  return CupertinoActivityIndicator();
                }
                if (snapshot.connectionState == ConnectionState.done &&
                    !snapshot.hasData) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: DottedBorder(
                      borderType: BorderType.Circle,
                      radius: Radius.circular(6),
                      color: customGreyColor,
                      dashPattern: [6, 3, 6, 3],
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        child: Container(
                          height: 45,
                          width: 45,
                          color: customGreyColor.withOpacity(.2),
                          child: Center(
                              child: Icon(
                            MaterialIcons.book,
                            color: customGreyColor,
                          )),
                        ),
                      ),
                    ),
                  );
                }

                return GestureDetector(
                  onTap: () async {
                    if (Platform.isIOS) {
                      showCupertinoModalBottomSheet(
                        context: context,
                        builder: (context) {
                          /* return TaskAssigneeWidget(
                                    data: snapshot.data,
                                  );*/
                        },
                      );
                    } else {
                      showMaterialModalBottomSheet(
                        context: context,
                        builder: (context) {
                          /* return TaskAssigneeWidget(
                                    data: snapshot.data,
                                  );*/
                        },
                      );
                    }
                  },
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: DottedBorder(
                      borderType: BorderType.Circle,
                      radius: Radius.circular(6),
                      color: customGreyColor,
                      dashPattern: [6, 3, 6, 3],
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(45)),
                        child: Container(
                          height: 45,
                          width: 45,
                          color: customGreyColor.withOpacity(.2),
                          child: Center(
                              child: Icon(
                            MaterialIcons.person_add,
                            color: customGreyColor,
                          )),
                        ),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
      new SizedBox(height: 15.0),
      TextButton(
        onPressed: _sendToServer,
        child: Text(
          widget.data.id != '-1' ? 'تعديل' : 'اضافة ',
          style:
              Theme.of(context).textTheme.button.copyWith(color: Colors.white),
        ),
        style: TextButton.styleFrom(
            backgroundColor: customRedColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            )),
      )

      /* new FlatButton(
            onPressed: _sendToRegisterPage,
            child: Text('حدف',
                style: TextStyle(color: Colors.black54)),
          ),*/
    ]);
  }

  Future<void> _showMyDialog(String message, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('  '),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
                Text(widget.data.name),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('موافق'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _sendToServer() async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      final UiUtilities uiUtilities = UiUtilities();

      var messag = 'تم حفظ بيانات الموظف';
      try {
        BotToast.showLoading(
            allowClick: false,
            clickClose: false,
            backButtonBehavior: BackButtonBehavior.ignore);

        bool sata = false;
        if (widget.typeOp == 'New') {
          sata = await _empService.add(widget.data);
        } else {
          sata = await _empService.update(widget.data);
          messag = 'تم تعديل بيانات الموظف';
        }

        BotToast.closeAllLoading();
        if (sata) {
          Navigator.of(context).pop();
          uiUtilities.alertNotification(context: context, message: messag);
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
      setState(() {
        _validate = true;
      });
    }
  }
}
