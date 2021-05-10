import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:tqm/managers/auth_manager.dart';
import 'package:tqm/models/Users.dart';
import 'package:tqm/models/user.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/ui_utils/SizeSceen.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/shareView/DefaultButton.dart';

final AuthManager _authManager = AuthManager();
final LocalStorage _localStorage = LocalStorage();

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  UserModel data = new UserModel();

  LoginPage();

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool _validate = false;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    SizeConfig.screenHeight = screenSize.height;
    SizeConfig.screenWidth = screenSize.width;

    return new Scaffold(
      body: new Center(
        child: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: Center(
              child: new Form(
                key: _key,
                autovalidate: _validate,
                child: _getFormUI(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getFormUI() {
    return new Column(
      children: <Widget>[
        new Image.asset(
          'assets/image/logo.png',
          height: 200,
          width: 200,
        ),
        new SizedBox(height: 30.0),
        new TextFormField(
          keyboardType: TextInputType.emailAddress,
          autofocus: false,
          style: Theme.of(context).textTheme.bodyText1,
          decoration: InputDecoration(
            hintText: 'اسم المستخدم',
            labelText: 'اسم المستخدم',
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
            prefixIcon: new Icon(
              Icons.account_box_outlined,
              textDirection: TextDirection.ltr,
              semanticLabel: 'username',
            ),
          ),
          validator: FormValidatorLogin().validateEmpty,
          onSaved: (String value) {
            widget.data.username = value;
          },
        ),
        new SizedBox(height: 20.0),
        new TextFormField(
            autofocus: false,
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: 'كلمة المرور',
              labelText: 'كلمة المرور',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              prefixIcon: new Icon(
                Icons.lock_open,
                textDirection: TextDirection.ltr,
                semanticLabel: 'password',
              ),
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  semanticLabel:
                      _obscureText ? 'show password' : 'hide password',
                ),
              ),
            ),
            validator: FormValidatorLogin().validatePassword,
            onSaved: (String value) {
              widget.data.password = value;
            }),
        new SizedBox(height: 15.0),
        new Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: DefaultButton(
              backColor: bBasicColor,
              text: 'تسجيل الدخول ',
              foreColor: Colors.white,
              radioborder: 25,
              press: _sendToServer,
            )),
        new FlatButton(
          child: Text(
            'نسيت كلمة السر ?',
            style: TextStyle(
                color: Colors.black54,
                fontSize: 12,
                fontWeight: FontWeight.normal),
          ),
          onPressed: _showForgotPasswordDialog,
        ),
        new FlatButton(
          onPressed: _sendToRegisterPage,
          child: Text('لست مشترك? مراسلة الادارة ',
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.normal)),
        ),
      ],
    );
  }

  _sendToRegisterPage() {
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterPage()),
    );*/
  }

  int i = 0;

  _sendToServer() async {
    if (_key.currentState.validate()) {
      // No any error in validation
      _key.currentState.save();

      BotToast.showLoading(
          allowClick: false,
          clickClose: false,
          backButtonBehavior: BackButtonBehavior.ignore);

      bool isSuccess = await _authManager.loginUserwithEmail(
          widget.data.username, widget.data.password);
      final UiUtilities uiUtilities = UiUtilities();

      BotToast.closeAllLoading();
      if (isSuccess) {
        Data data = await _localStorage.getUserInfo();

        uiUtilities.actionAlertWidget(context: context, alertType: 'success');
        uiUtilities.alertNotification(
            context: context, message: _authManager.message);

        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushNamedAndRemoveUntil(
              context,
              data.organizationId == null ? '/organizationView' : '/',
              (route) => false);
        });
      } else {
        uiUtilities.actionAlertWidget(context: context, alertType: 'error');
        uiUtilities.alertNotification(
            context: context, message: _authManager.message);
      }

      /*     
if(i>0)
{

Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Index()),
    ); 
}
i++;*/

    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }

  Future<Null> _showForgotPasswordDialog() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: const Text('Please enter your email'),
            contentPadding: EdgeInsets.all(5.0),
            content: new TextField(
              decoration: new InputDecoration(hintText: "email"),
              onChanged: (String value) {
                widget.data.username = value;
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Ok"),
                onPressed: () async {
                  widget.data.username = "";
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          );
        });
  }
}

class FormValidatorLogin {
  static FormValidatorLogin _instance;

  factory FormValidatorLogin() => _instance ??= new FormValidatorLogin._();

  FormValidatorLogin._();

  String validatePassword(String value) {
    String patttern = r'(^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{6,}$)';
    RegExp regExp = new RegExp(patttern);
    if (value.isEmpty) {
      return "Password is Required";
    }
    /* else if (value.length < 8) {
      return "Password must minimum eight characters";
    }
     else if (!regExp.hasMatch(value)) {
      return "Password at least one uppercase letter, one lowercase letter and one number";
    }*/
    return null;
  }

  String validateEmpty(String value) {
    /*String pattern =
        r'^(([^<&gt;()[\]\\.,;:\s@\"]+(\.[^<&gt;()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    */
    if (value.isEmpty) {
      return "Username is Required";
    }
    /*else if (!regExp.hasMatch(value)) 
    {
      return "Invalid Email";
    } */
    else {
      return null;
    }
  }
}
