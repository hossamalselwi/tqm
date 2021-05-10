import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:tqm/services/barchService.dart';
import 'package:tqm/utils/ui_utils/SizeSceen.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/shareView/FormText.dart';
import 'package:tqm/views/shareView/myCountry.dart';
import '../../models/barch.dart';

class BarchPage extends StatefulWidget {
  final Barch data;

  BarchPage({
    Key key,
    this.data,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return new _BarchPageState();
  }
}

class _BarchPageState extends State<BarchPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;
  FocusNode nameFoucs = FocusNode();
  FocusNode addressFoucs = FocusNode();

  FocusNode countryFoucs = FocusNode();
  FocusNode cityFoucs = FocusNode();

  FocusNode emailFoucs = FocusNode();
  FocusNode submitFoucs = FocusNode();

  @override
  void dispose() {
    nameFoucs.dispose();
    addressFoucs.dispose();
    countryFoucs.dispose();
    cityFoucs.dispose();
    emailFoucs.dispose();
    submitFoucs.dispose();
    super.dispose();
  }

  onFieldSubmName(String term) {
    nameFoucs.unfocus();
    FocusScope.of(context).requestFocus(addressFoucs);
  }

  onFieldSubmAddress(String term) {
    addressFoucs.unfocus();
    FocusScope.of(context).requestFocus(countryFoucs);
  }

  onFieldSubmCountry(String term) {
    countryFoucs.unfocus();
    FocusScope.of(context).requestFocus(cityFoucs);
  }

  onFieldSubmCty(String term) {
    cityFoucs.unfocus();
    FocusScope.of(context).requestFocus(emailFoucs);
  }

  onFieldSubmEmail(String term) {
    emailFoucs.unfocus();
    FocusScope.of(context).requestFocus(submitFoucs);
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig.screenHeight = screenSize.height;
    SizeConfig.screenWidth = screenSize.width;

    return new Scaffold(
      appBar: AppBar(
          title: Text(widget.data.id == '0' ? 'الفروع' : widget.data.name,
              style: Theme.of(context).textTheme.headline6)),
      extendBody: true,
      body: Form(
        key: _key,
        autovalidate: _validate,
        child: _getFormUI(),
      ),
    );
  }

  Widget _getFormUI() {
    return new ListView(
      padding: EdgeInsets.all(24),
      children: <Widget>[
        Divider(),
        new SizedBox(height: 5.0),

        FormText.textFormWithNode(
            context: context,
            focusNode: nameFoucs,
            initialValue: widget.data.name,
            hintText: 'اسم الفرع',
            validator: FormValidator().validateisEmpty,
            onSaved: (String value) {
              widget.data.name = value;
            },
            onFieldSubmitted: onFieldSubmName,
            validText: 'اسم الفرع',
            autofocse: true,
            icon: null),
        new SizedBox(height: 5.0),
        FormText.textFormWithNode(
          context: context,
          focusNode: addressFoucs,
          initialValue: widget.data.address,
          hintText: 'عنوان الفرع',
          validator: FormValidator().validateisEmpty,
          onSaved: (String value) {
            widget.data.address = value;
          },
          onFieldSubmitted: onFieldSubmAddress,
          validText: 'عنوان الفرع',
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

        MyCountryView(
          //countryInti: widget.data.id == '0' ? widget.data.countryid : "الدولة",
          // stateInti: widget.data.id == '0' ? widget.data.city : "مقاطعة",
          onCountryChanged: (value) {
            widget.data.countryid = value;
          },
          onStateChanged: (value) {
            widget.data.city = value;
          },
        ),
        new SizedBox(height: 15.0),
        FormText.textFormWithNode(
          context: context,
          focusNode: emailFoucs,
          initialValue: widget.data.email,
          hintText: 'ايميل الفرع',
          validator: FormValidator().validateisEmpty,
          onSaved: (String value) {
            widget.data.email = value;
          },
          onFieldSubmitted: onFieldSubmEmail,
          validText: 'ايميل الفرع',
          autofocse: false,
          textInputAction: TextInputAction.done,
          icon: new Icon(
            Icons.email,
            textDirection: TextDirection.ltr,
          ),
        ),

        new SizedBox(height: 15.0),

        Divider(),

        new SizedBox(height: 15.0),

        Container(
          alignment: Alignment.centerRight,
          padding:
              EdgeInsets.only(top: 11.0, left: 25.0, right: 25.0, bottom: 10),
          //  decoration: BoxDecoration(color: Colors.black12),
          child: Text('وثائق الفرع'),
        ),
        // DocsView(data: widget.data.dos),
        SizedBox(height: 25),
        TextButton(
          focusNode: submitFoucs,
          style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              backgroundColor: Colors.black),
          onPressed: () async {
            _sendToServer();
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(widget.data.id == '0' ? 'إنشاء فرع' : 'تعديل الفرع ',
                style: Theme.of(context)
                    .textTheme
                    .button
                    .copyWith(color: Colors.white)),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  BrchSerivce _brchSerivce = BrchSerivce();

  _sendToServer() async {
    if (_key.currentState.validate()) {
      final UiUtilities uiUtilities = UiUtilities();

      _key.currentState.save();

      BotToast.showLoading(
          allowClick: false,
          clickClose: false,
          backButtonBehavior: BackButtonBehavior.ignore);
      bool isSaved = false;
      String message = 'تم اضافة الفرع ';

      if (widget.data.id == '0')
        isSaved = await _brchSerivce.add(widget.data);
      else {
        isSaved = await _brchSerivce.update(widget.data);
        message = 'تم تعديل الفرع ';
      }

      BotToast.closeAllLoading();
      if (isSaved) {
        uiUtilities.actionAlertWidget(context: context, alertType: 'success');
        uiUtilities.alertNotification(
            context: context, message: '$message : ${widget.data.name}');

        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop();
          // Navigator.of(context).pop();
        });
      } else {
        uiUtilities.actionAlertWidget(context: context, alertType: 'error');
        uiUtilities.alertNotification(
            context: context, message: 'taskManager.message');
      }
    } else {
      setState(() {
        _validate = true;
      });
      /* uiUtilities.actionAlertWidget(
                        context: context, alertType: 'error');
                    uiUtilities.alertNotification(
                        context: context, message: 'Fields cannot be empty');*/
    }
  }
}
