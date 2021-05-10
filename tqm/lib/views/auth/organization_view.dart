import 'dart:io';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tqm/managers/organization_manager.dart';
import 'package:tqm/models/orgModel.dart';
import 'package:tqm/models/organization.dart';
import 'package:tqm/services/orgService.dart';
import 'package:tqm/shared_widgets/custom_bottom_sheet_widget.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/network_utils/StateAPi.dart';
import 'package:tqm/utils/tools/uploadImg.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/auth/widget/imageWidget.dart';
import 'package:tqm/views/shareView/FormText.dart';
import 'package:tqm/views/shareView/myCountry.dart';
import 'package:textfield_tags/textfield_tags.dart';

final OrgService _orgService = OrgService();
final LocalStorage _localStorage = LocalStorage();

class OrganizationView extends StatefulWidget {
  @override
  _OrganizationViewState createState() => _OrganizationViewState();
}

class _OrganizationViewState extends State<OrganizationView>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> _scaffoldKeyc =
      GlobalKey<ScaffoldState>();

  GlobalKey<FormState> _key = new GlobalKey();

  bool _validate = false;

  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UiUtilities uiUtilities = UiUtilities();
  TextEditingController nameTextEditingController = TextEditingController();
  List<String> teams = [];
  final nameFocusNode = FocusNode();
  final addressFocusNode = FocusNode();
  final urlFocusNode = FocusNode();

  final numFocusNode = FocusNode();
  FocusNode submitFoucs = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameFocusNode.dispose();
    addressFocusNode.dispose();
    urlFocusNode.dispose();
    numFocusNode.dispose();
    submitFoucs.dispose();
    super.dispose();
  }

  onFieldSubmName(String term) {
    nameFocusNode.unfocus();
    FocusScope.of(context).requestFocus(addressFocusNode);
  }

  onFieldSubmAddress(String term) {
    addressFocusNode.unfocus();
    FocusScope.of(context).requestFocus(numFocusNode);
  }

  onFieldSubmNum(String term) {
    numFocusNode.unfocus();
    FocusScope.of(context).requestFocus(urlFocusNode);
  }

  onFieldSubmUrl(String term) {
    urlFocusNode.unfocus();
    FocusScope.of(context).requestFocus(submitFoucs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: customRedColor,
          leading: Container(),
          actions: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Center(
                child: Text(
                  'X',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              ),
            )
          ],
          title: Text(
            'بيانات الحساب',
            style: Theme.of(context)
                .textTheme
                .headline6
                .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        key: _scaffoldKeyc,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200,
                floating: true,
                pinned: true,
                snap: true,
                leading: Container(),
                actions: <Widget>[
                  Text('الدولة'),
                  Text('مدينة'),
                ],
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
                        Center(child: AccountCardWidget()),
                        SizedBox(
                          height: 7,
                        ),
                        Center(
                            child: TextButton(
                          child: Text(
                            'تحديث صورة المؤسسة',
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                .copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: customRedColor),
                          ),
                          onPressed: () {},
                        )),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    )

                        /* Image.asset(
                                "assets/image/logo.png",
                      fit: BoxFit.cover,
                      
                      
                  ),*/
                        )),
              ),
            ];
          },
          body: SafeArea(
            child: StreamBuilder<OrgModel>(
                stream: _orgService.getOrg().asStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return StateNetWork.connectionWaitWidegt();
                  }

                  return Form(
                    key: _key,
                    autovalidate: _validate,
                    child: _getFormUI(snapshot.data),
                  );
                }),
          ),
        ));
  }

  _sendToServer(OrgModel orgModel) async {
    if (_key.currentState.validate()) {
      _key.currentState.save();
      final UiUtilities uiUtilities = UiUtilities();

      var messag = '';
      try {
        BotToast.showLoading(
            allowClick: false,
            clickClose: false,
            backButtonBehavior: BackButtonBehavior.ignore);

        bool sata = false;
        sata = await _orgService.update(orgModel);

        BotToast.closeAllLoading();
        if (sata) {
          messag = 'تم تحديث  بيانات المؤسسة';
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
      uiUtilities.actionAlertWidget(context: context, alertType: 'error');
      uiUtilities.alertNotification(
          context: context, message: 'Fields cannot be Empty!');
    }
  }

  Widget _getFormUI(OrgModel orgModel) {
    return ListView(
      padding: EdgeInsets.all(24),
      children: [
        Column(children: <Widget>[
          SizedBox(
            height: 20,
          ),
          FormText.textFormWithNode(
              context: context,
              focusNode: nameFocusNode,
              initialValue: orgModel.name,
              hintText: 'اسم المنشأة',
              validator: FormValidator().validateisEmpty,
              onSaved: (String value) {
                orgModel.name = value;
              },
              onFieldSubmitted: onFieldSubmName,
              validText: ' اسم المنشأة',
              autofocse: false,
              icon: null),
          FormText.textFormWithNode(
            context: context,
            focusNode: addressFocusNode,
            initialValue: orgModel.address,
            hintText: 'عنوان المنشأة',
            validator: FormValidator().validateisEmpty,
            onSaved: (String value) {
              orgModel.address = value;
            },
            onFieldSubmitted: onFieldSubmAddress,
            validText: 'عنوان المنشأة',
            autofocse: false,
            icon: null,
            suffixIcon: GestureDetector(
              onTap: () {
                /* Navigator.of(context).push(new MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (c) {
                        //return BspAddressmapscreen();
                      }));*/
              },
              child: Icon(
                Icons.location_on_outlined,
                semanticLabel: 'Select Location ',
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FormText.textFormWithNode(
            context: context,
            focusNode: numFocusNode,
            initialValue: orgModel.numBasic,
            hintText: ' رقم المنشأة الرسمي',
            validator: FormValidator().validateisEmpty,
            onSaved: (String value) {
              orgModel.numBasic = value;
            },
            onFieldSubmitted: onFieldSubmNum,
            validText: ' رقم المنشأة الرسمي',
            autofocse: false,
            icon: new Icon(
              Icons.format_list_numbered,
              textDirection: TextDirection.ltr,
              semanticLabel: ' رقم المنشأة الرسمي',
            ),
          ),
          new SizedBox(height: 10.0),
          FormText.textFormWithNode(
            context: context,
            focusNode: urlFocusNode,
            initialValue: orgModel.webSite,
            hintText: ' WebSite:  ',
            validator: FormValidator().validateisEmpty,
            onSaved: (String value) {
              orgModel.webSite = value;
            },
            onFieldSubmitted: onFieldSubmUrl,
            validText: 'WebSite:',
            autofocse: false,
            textInputAction: TextInputAction.done,
            icon: new Icon(
              Icons.format_list_numbered,
              textDirection: TextDirection.ltr,
              semanticLabel: 'عنوان الموقع',
            ),
          ),
          SizedBox(
            height: 10,
          ),
          MyCountryView(
            countryInti: orgModel.country,
            stateInti: orgModel.city,
            onCountryChanged: (value) {
              orgModel.country = value;
            },
            onStateChanged: (value) {
              orgModel.city = value;
            },
          ),
          TextFieldTags(
            textFieldStyler: TextFieldStyler(
              helperText: '',
              cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
              hintStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.grey),
              hintText: 'مواقع التواصل الاجتماعي',
              textFieldBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: customGreyColor)),
              textStyle: Theme.of(context).textTheme.bodyText1,
              textFieldEnabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: customGreyColor)),
              textFieldFocusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: customGreyColor)),
            ),
            //[tagsStyler] is required and shall not be null
            tagsStyler: TagsStyler(
              //These are properties you can tweek for customization of tags
              tagTextStyle: Theme.of(context)
                  .textTheme
                  .bodyText1
                  .copyWith(color: Colors.white),
              tagDecoration: BoxDecoration(
                color: customRedColor,
                borderRadius: BorderRadius.circular(5.0),
              ),
              tagCancelIcon:
                  Icon(Icons.cancel, size: 18.0, color: Colors.white),
              tagPadding: const EdgeInsets.all(8.0),
            ),
            onTag: (tag) {
              //This give you tags entered
              print('onTag ' + tag);
              setState(() {
                teams.add(tag);
              });
            },
            onDelete: (tag) {
              print('onDelete ' + tag);
              setState(() {
                teams.remove(tag);
              });
            },
          ),
        ]),
        Container(
          alignment: Alignment.centerRight,
          padding:
              EdgeInsets.only(top: 11.0, left: 25.0, right: 25.0, bottom: 10),
          //  decoration: BoxDecoration(color: Colors.black12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: Row(
              children: [
                Text('وثائق المنشاة '),
                MaterialButton(
                  minWidth: 20,
                  onPressed: () {},
                  child: Icon(
                    Icons.add,
                    size: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        // DocsView(data: orgModel.docs),

        TextButton(
          focusNode: submitFoucs,
          onPressed: () async {
            _sendToServer(orgModel);
            await _localStorage.saveOrgNameInfo(name: orgModel.name);
          },
          child: Text(
            'حفظ',
            style: Theme.of(context)
                .textTheme
                .button
                .copyWith(color: Colors.white),
          ),
          style: TextButton.styleFrom(
              backgroundColor: customRedColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        )
      ],
    );
  }
}

class AccountCardWidget extends StatefulWidget {
  const AccountCardWidget({
    Key key,
  }) : super(key: key);

  @override
  _AccountCardWidgetState createState() => _AccountCardWidgetState();
}

class _AccountCardWidgetState extends State<AccountCardWidget>
    with TickerProviderStateMixin {
  File _imageFile;
  List<Options> options;

  final UiUtilities uiUtilities = UiUtilities();

  getProfileFromCamera() async {
    await uiUtilities
        .getImage(imageSource: ImageSource.camera)
        .then((file) async {
      File croppedFile = await uiUtilities.getCroppedFile(file: file.path);

      if (croppedFile != null) {
        setState(() {
          _imageFile = croppedFile;
        });

        var task = await UpLoadFile.uploadFile(croppedFile, 'logo')
            .then((value) => showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                      title: Text("Files Uploaded Successfully :)")),
                ).then((value) => Navigator.pop(context)));
        /*if (task != null) {
          return 
        }*/
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

      var task = await UpLoadFile.uploadFile(croppedFile, 'logo');

      if (task != null) {
        return showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(title: Text("Files Uploaded Successfully :)")),
        ).then((value) => Navigator.pop(context));
      }
    });
  }

  AnimationController controller;

  String image = '';
  getUrl() async {
    var image1 = await UpLoadFile.getUrlImg();
    setState(() {
      image = image1;
    });
  }

  @override
  void initState() {
    getUrl();
    super.initState();

    options = [
      Options(
          label: 'التقاط صورة',
          onTap: () {
            Navigator.pop(context);
            getProfileFromCamera();
          }),
      Options(
          label: 'من الاستديو',
          onTap: () {
            Navigator.pop(context);
            getProfileFromGallery();
          }),
    ];
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    animation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeInToLinear));
    controller.forward();
  }

  Animation<double> animation;

  Widget _image() {
    return AnimatedBuilder(
      builder: (context, child) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 1200),
          opacity: animation.value,
          child: child,
        );
      },
      animation: animation,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                // showPhoto(context, model.image);
              },
              child: AccountScreenImageCard(
                extraTag: 'logo',
                path: image,
              )),
          Positioned(
              // height: 20,
              // width: 20,
              top: 0,
              right: 20,
              child: InkWell(
                child: InkWell(
                  child: Container(
                      width: 27,
                      height: 27,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: Icon(
                        Icons.edit,
                        size: 24,
                        color: Colors.white,
                      )),
                ),
                onTap: () {
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
              ))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _image();
/*
    InkWell(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                AccountScreenImageCard(
                  extraTag: 'logo',
                  path: image,
                )
                // image
                /*hero(
                  context,
                  width: double.infinity,
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  */
  }
}

///////////////////////////////
///
///
///
////////////
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///

///
////////
////////////////
////////////////////
////////////////////////
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
///
