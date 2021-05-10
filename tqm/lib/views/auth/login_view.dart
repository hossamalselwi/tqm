import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tqm/managers/auth_manager.dart';
import 'package:tqm/models/user.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';

final AuthManager _authManager = AuthManager();
final LocalStorage _localStorage = LocalStorage();

class LoginView extends StatelessWidget {
  final UiUtilities uiUtilities = UiUtilities();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            Image.asset(
              'assets/tasky_logo.png',
              width: 120,
              height: 120,
            ),
            SizedBox(
              height: 10,
            ),
            Center(
                child: Text(
              'Tasky',
              style: Theme.of(context).textTheme.headline4.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: GoogleFonts.fugazOne().fontFamily),
            )),
            Spacer(),
            Text(
              'Login or Create a new account',
              style: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: Colors.grey),
            ),
            SizedBox(
              height: 15,
            ),
            TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.only(left: 10, right: 10),
                shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey, width: .5),
                    borderRadius: BorderRadius.circular(45)),
                backgroundColor: Colors.white70,
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/ic_google.svg',
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Continue with Google',
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ),
              onPressed: () async {
                BotToast.showLoading(
                    allowClick: false,
                    clickClose: false,
                    backButtonBehavior: BackButtonBehavior.ignore);
                bool isSuccess = await _authManager.loginUserwithGoogle();
                BotToast.closeAllLoading();
                if (isSuccess) {
                  Data data = await _localStorage.getUserInfo();
                  uiUtilities.actionAlertWidget(
                      context: context, alertType: 'success');
                  uiUtilities.alertNotification(
                      context: context, message: _authManager.message);

                  Future.delayed(Duration(seconds: 3), () {
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        data.organizationId == null ? '/organizationView' : '/',
                        (route) => false);
                  });
                } else {
                  uiUtilities.actionAlertWidget(
                      context: context, alertType: 'error');
                  uiUtilities.alertNotification(
                      context: context, message: _authManager.message);
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: Platform.isIOS,
              child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45)),
                  backgroundColor: Colors.black87,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/ic_apple.svg',
                        width: 30,
                        height: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Signin with Apple',
                        style: Theme.of(context)
                            .textTheme
                            .button
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
                onPressed: () async {
                  BotToast.showLoading(
                      allowClick: false,
                      clickClose: false,
                      backButtonBehavior: BackButtonBehavior.ignore);
                 // bool isSuccess = await _authManager.loginUserwithApple();
                  BotToast.closeAllLoading();
                  //if (isSuccess) 
                  {
                    Data data = await _localStorage.getUserInfo();
                    uiUtilities.actionAlertWidget(
                        context: context, alertType: 'success');
                    uiUtilities.alertNotification(
                        context: context, message: _authManager.message);

                    Future.delayed(Duration(seconds: 3), () {
                      Navigator.pushNamedAndRemoveUntil(
                          context,
                          data.organizationId == null
                              ? '/organizationView'
                              : '/',
                          (route) => false);
                    });
                  } 
                  //else 
                  {
                    uiUtilities.actionAlertWidget(
                        context: context, alertType: 'error');
                    uiUtilities.alertNotification(
                        context: context, message: _authManager.message);
                  }
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
////////////////////
////////////////////
///
///
///////
///
///
///
///
///////////////////////////////////
///
///
/////////////////////
///
///
///
///
///
///
///
////////////////////////////
////////////////////
///
///
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////
///
///
///
///