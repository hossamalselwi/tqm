import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:groovin_widgets/groovin_widgets.dart';
import 'package:provider/provider.dart';
import 'package:tqm/managers/organization_manager.dart';
import 'package:tqm/managers/screenManager.dart';
import 'package:tqm/managers/user_manager.dart';
import 'package:tqm/models/organization.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/utils/ui_utils/ui_utils.dart';
import 'package:tqm/views/dashboard/side_menu.dart';
import 'package:tqm/views/overview/over_view.dart';
import 'package:tqm/views/account/account_view.dart';
import 'package:tqm/views/stratige/StratgeView.dart';
import 'package:tqm/views/stratige/stratige_view.dart';
import 'package:tqm/views/task/task_view.dart';
import '../shareView/appBar.dart';

//final FirebaseMessaging _messaging = FirebaseMessaging.instance;
final LocalStorage _localStorage = LocalStorage();
final OrganizationManager _organizationManager = OrganizationManager();
final UserManager _userManager = UserManager();

class DashboardView extends StatefulWidget {
  final int currentIndex;

  const DashboardView({Key key, this.currentIndex = 0}) : super(key: key);
  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final UiUtilities uiUtilities = UiUtilities();
  String team;

  final List<Widget> _pages = [
    OverView(),
    StratigeView(),
    TaskView(),
    AccountView()
  ];

  _onChanged(int index) {
    ScreenManager serviceapp =
        Provider.of<ScreenManager>(context, listen: false);

    if (index == serviceapp.indexMenuClick) return;

    serviceapp.changeClickMenu(index);
  }

  @override
  void initState() {
    /* setState(() {
      _currentIndex = widget.currentIndex;
    });*/
    checkAuth();
    //initialNotification(context: context);
    uploadNotificationToken();
    super.initState();
  }

  void uploadNotificationToken() async {
    /* print(_messaging);
    if (_messaging != null) {
      await _messaging.getToken().then((token) async {
        await _userManager.sendNotificationToken(token: token);
      });
    }*/
  }

  Future onSelectNotification(String payload) async {
    debugPrint("payload : $payload");
  }

  @override
  Widget build(BuildContext context) {
    ScreenManager serviceScreen = Provider.of<ScreenManager>(context);

    return serviceScreen.indexMenuClick == null
        ? Scaffold(body: Center(child: CupertinoActivityIndicator()))
        : Scaffold(
            appBar: appBarApp(context, 'نظرة عامة '),
            drawer: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 250),
                child: Drawer(child: SideMenu())
                //  DrawerScreen(),
                ),

            // Drawer(child: DrawerScreen()) ,

            body: _pages[serviceScreen.indexMenuClick],

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: serviceScreen.indexMenuClick,
              onTap: _onChanged,
              selectedIconTheme:
                  Theme.of(context).iconTheme.copyWith(color: customRedColor),
              selectedLabelStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: customRedColor),
              unselectedIconTheme:
                  Theme.of(context).iconTheme.copyWith(color: customGreyColor),
              unselectedLabelStyle: Theme.of(context)
                  .textTheme
                  .bodyText2
                  .copyWith(color: customGreyColor),
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: true,
              backgroundColor:
                  Theme.of(context).bottomNavigationBarTheme.backgroundColor,
              selectedItemColor: customRedColor,
              unselectedItemColor: customGreyColor,
              items: [
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/chart_pie.svg'),
                    label: 'نظرة عامة',
                    activeIcon: SvgPicture.asset(
                      'assets/chart_pie.svg',
                      color: customRedColor,
                    )),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/lightning_bolt.svg'),
                    label: 'الاستراتيجية',
                    activeIcon: SvgPicture.asset(
                      'assets/lightning_bolt.svg',
                      color: customRedColor,
                    )),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/inbox.svg'),
                    label: 'المهام المنجزة',
                    activeIcon: Icon(
                      Icons.timeline_outlined,
                      size: 25,
                      color: customRedColor,
                    )
                    /* SvgPicture.asset(
                      'assets/inbox.svg',
                      color: customRedColor,
                    )*/
                    ),
                BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/user_circle.svg'),
                    label: 'الحساب',
                    activeIcon: SvgPicture.asset(
                      'assets/user_circle.svg',
                      color: customRedColor,
                    ))
              ],
            ),
          );
  }

  void getUserTeam() async {
    Organization organization = await _organizationManager.getOrganization();
    _localStorage.getUserInfo().then((data) {
      if (data.team == null && organization != null)
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Update your Team',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(fontWeight: FontWeight.w600),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                content: SizedBox(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Material(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: Colors.grey, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: OutlineDropdownButton(
                            inputDecoration: InputDecoration(
                              alignLabelWithHint: true,
                              hintStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .hintStyle,
                              contentPadding: EdgeInsets.fromLTRB(15, 1, 15, 1),
                              floatingLabelBehavior: FloatingLabelBehavior.auto,
                              focusedBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .focusedBorder,
                              enabledBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .enabledBorder,
                              disabledBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .disabledBorder,
                              errorBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .errorBorder,
                              focusedErrorBorder: Theme.of(context)
                                  .inputDecorationTheme
                                  .focusedErrorBorder,
                              fillColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor,
                              filled: true,
                              labelStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .labelStyle,
                              errorStyle: Theme.of(context)
                                  .inputDecorationTheme
                                  .errorStyle,
                            ),
                            items: organization.data.docs
                                .map((value) => DropdownMenuItem<String>(
                                    value: '$value',
                                    child: Text(
                                      '$value',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    )))
                                .toList(),
                            value: team,
                            hint: Text(
                              'Select your team',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            onChanged: (value) {
                              setState(() {
                                team = value;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: customRedColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8))),
                          onPressed: () async {
                            Navigator.pop(context);
                            if (team == null) {
                              uiUtilities.actionAlertWidget(
                                  context: context, alertType: 'error');
                              uiUtilities.alertNotification(
                                  context: context, message: 'Select a team');
                            } else {
                              BotToast.showLoading(
                                  allowClick: false,
                                  clickClose: false,
                                  backButtonBehavior:
                                      BackButtonBehavior.ignore);
                              bool isUpdated =
                                  await _userManager.updateUserTeam(team: team);
                              BotToast.closeAllLoading();
                              if (isUpdated) {
                                uiUtilities.actionAlertWidget(
                                    context: context, alertType: 'success');
                                uiUtilities.alertNotification(
                                    context: context,
                                    message: _userManager.message);
                              } else {
                                uiUtilities.actionAlertWidget(
                                    context: context, alertType: 'error');
                                uiUtilities.alertNotification(
                                    context: context,
                                    message: _userManager.message);
                              }
                            }
                          },
                          child: Text(
                            'Update team',
                            style: Theme.of(context)
                                .textTheme
                                .button
                                .copyWith(color: Colors.white),
                          ))
                    ],
                  ),
                ),
              );
            });
    });
  }

  void checkAuth() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    _auth.userChanges().listen((user) {
      if (user != null) {
        getUserTeam();
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, '/loginView', (route) => false);
      }
    });
  }
}

////
////////////////////////////////////////
///
///
///
///
//////////////
///
///////////////////////////////
/////////////////
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
////////////////////
/////////////////
/////////////////
///
///////
//////////////////////////////////////
///
///
///
///
////////////////////////////
///
///
///
///
///
///
////////////////////
///
///
///
///
///
///
///
