import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tqm/managers/screenManager.dart';
import 'package:tqm/utils/local_storage.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';
import 'package:tqm/views/dashboard/orgtags.dart';

import 'side_menu_item.dart';
import '../search/search_view.dart';

import '../../utils/network_utils/StateAPi.dart';

ScreenManager screenManager = ScreenManager();
final LocalStorage _localStorage = LocalStorage();
double kDefaultPadding = 12;

class SideMenu extends StatefulWidget {
  SideMenu({
    Key key,
  }) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  int select = 0;
  bool isNeight = false;
  String nameAccount;

  getName() async {
    var nameAccount1 = await _localStorage.getName();
    setState(() {
      nameAccount = nameAccount1;
    });
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  List<Map> drawerItems = [
    {'icon': Icons.home, 'title': 'الرئيسية', 'pageRoute': '/deptNameView'},
    //{'icon': Icons.admin_panel_settings_outlined, 'title': 'الادارة'},
    {'icon': Icons.timeline_outlined, 'title': 'الاستراتيجية '}, //inviView
    {'icon': Icons.timeline_outlined, 'title': 'مؤشرات الاداء '},

    {'icon': Icons.timeline_outlined, 'title': 'التقارير  '},
    {'icon': Icons.search_outlined, 'title': ' بحث '},
    {'icon': Icons.settings_applications_outlined, 'title': ' الاعدادات  '},
    {'icon': Icons.account_tree, 'title': ' الحساب  '},
    {'icon': Icons.room_service, 'title': 'المبادرات '},
    // {'icon': Icons.settings_applications_outlined, 'title': ' الاعدادات  '},
    /*{
    'icon': Icons.logout,
    'title' : 'تسجيل الخروج  '
  },*/
  ];

  /*changeSelect(int value) {
    setState(() {
      select = value;
    });
  }*/

  void onMenuIconPressed(int index) {
    ScreenManager serviceapp =
        Provider.of<ScreenManager>(context, listen: false);

    if (index == serviceapp.indexMenuClick) return;

    if (index < 4) serviceapp.changeClickMenu(index);

    setState(() {
      select = index;
    });

    Navigator.of(context).pop();

    //changeSelect(index);

    //select = index;
  }

  void chageThem(bool islit) {
    ScreenManager serviceapp =
        Provider.of<ScreenManager>(context, listen: false);

    if (islit == serviceapp.islight) return;

    serviceapp.changeThem(islit);
  }

  @override
  Widget build(BuildContext context) {
    //ProviderServices serviceapp = Provider.of<ProviderServices>(context);

    Widget iii = StreamBuilder<String>(
      stream: _localStorage.getName().asStream(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;

        if (snapshot.hasError) {
          return StateNetWork.hasErrorStrWidegt('Error: ${snapshot.error}');
        } else {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return StateNetWork.connectionNoneWidegt();
              break;
            case ConnectionState.waiting:
              {
                return StateNetWork.connectionWaitWidegt();
              }

              break;
            case ConnectionState.active:
              return StateNetWork.connectionActiveWidegt('\$${snapshot.data}');

              break;
            case ConnectionState.done:
              {
                return Text(
                  snapshot.data[0].toString(),
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: kGrayColor),
                );
              }

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

    return Consumer<ScreenManager>(
      builder: (context, screenManager, child) => Container(
        height: double.infinity,
        padding: EdgeInsets.only(top: 12),
        //color: kBgLightColor,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    //customRedColor

                    // iii,
                    Text(
                      nameAccount.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .button
                          .copyWith(color: kGrayColor),
                    ),

                    Center(
                      child: InkWell(
                        onTap: () => Navigator.of(context)
                            .pushNamed('/accountView')
                            .then((value) {
                          getName();
                        }),
                        child: StreamBuilder<String>(
                            stream: _localStorage.getPicture().asStream(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return CircleAvatar(
                                  radius: 20,
                                  backgroundImage: ExactAssetImage(
                                    'assets/avatar.png',
                                  ),
                                  backgroundColor: Colors.primaries[Random()
                                          .nextInt(Colors.primaries.length)]
                                      .withOpacity(.4),
                                );
                              }
                              return CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(
                                  '${snapshot.data}',
                                ),
                                backgroundColor: Colors.primaries[Random()
                                        .nextInt(Colors.primaries.length)]
                                    .withOpacity(.4),
                              );
                            }),
                      ),
                    ),
                    /* ImageIcon(
                      AssetImage(
                        'assets/image/logo.png',
                      ),
                      color: customRedColor,
                    ),*/
                    Spacer(),
                    CloseButton(),
                  ],
                ),

                SizedBox(height: kDefaultPadding),

                // Menu Items
                SideMenuItem(
                  press: () {
                    onMenuIconPressed(0);
                  },
                  title: drawerItems[0]['title'],
                  icon: Icon(
                    drawerItems[0]['icon'],
                    size: 25,
                    color: screenManager.indexMenuClick == 0 && select == 0
                        ? customRedColor //kPrimaryColor
                        : kGrayColor,
                  ),
                  isActive: screenManager.indexMenuClick == 0 && select == 0,
                ),
                SideMenuItem(
                  press: () {
                    onMenuIconPressed(1);
                  },
                  title: drawerItems[1]['title'],
                  icon: SvgPicture.asset(
                    'assets/lightning_bolt.svg',
                    color: screenManager.indexMenuClick == 1 && select == 1
                        ? customRedColor //kPrimaryColor
                        : kPrimaryColor,
                  ),
                  isActive: screenManager.indexMenuClick == 1 && select == 1,
                ),
                SideMenuItem(
                  press: () {
                    onMenuIconPressed(2);
                  },
                  title: drawerItems[2]['title'],
                  icon: Icon(
                    drawerItems[2]['icon'],
                    size: 25,
                    color: screenManager.indexMenuClick == 2 && select == 2
                        ? customRedColor // kPrimaryColor
                        : bBasicColor,
                  ),
                  isActive: screenManager.indexMenuClick == 2 && select == 2,
                ),
                SideMenuItem(
                  press: () {
                    onMenuIconPressed(30);
                  },

                  title: drawerItems[3]['title'],
                  icon: SvgPicture.asset(
                    'assets/inbox.svg',
                    color: select == 30
                        ? customRedColor // kPrimaryColor
                        : bBasicColor,
                  ),
                  isActive: select == 30,
                  // showBorder: false,
                ),
                SideMenuItem(
                  press: () {
                    onMenuIconPressed(40);
                    showSearch(
                      context: context,
                      delegate: SearchView(),
                    );
                  },

                  title: drawerItems[4]['title'],
                  icon: Icon(
                    drawerItems[4]['icon'],
                    size: 25,
                    color: select == 40
                        ? customRedColor //kPrimaryColor
                        : bBasicColor,
                  ),
                  isActive: select == 40,
                  //showBorder: false,
                ),
                SideMenuItem(
                  press: () {
                    onMenuIconPressed(5);
                  },

                  title: drawerItems[5]['title'],
                  icon: Icon(
                    drawerItems[5]['icon'],
                    size: 25,
                    color: select == 5
                        ? customRedColor //kPrimaryColor
                        : bBasicColor,
                  ),
                  isActive: select == 5,
                  // showBorder: false,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Row(children: [
                    SizedBox(width: 2),
                    Switch.adaptive(
                      onChanged: (value) {
                        setState(() {
                          isNeight = value;
                        });
                        screenManager.changeThem(isNeight);
                      },
                      value: isNeight,
                      activeColor: customRedColor,
                      activeTrackColor: customRedColor.withOpacity(.5),
                      inactiveThumbColor: customGreyColor,
                      inactiveTrackColor: customGreyColor,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'الوضع الليلي ',
                      style: Theme.of(context).textTheme.button.copyWith(
                            color: (isNeight) ? bBasicColor : kGrayColor,
                          ),
                    ),
                    Spacer(),
                  ]),
                ),
                SideMenuItem(
                  press: () {
                    onMenuIconPressed(3);
                  },

                  title: drawerItems[6]['title'],
                  icon: SvgPicture.asset(
                    'assets/user_circle.svg',
                    color: screenManager.indexMenuClick == 3 && select == 3
                        ? customRedColor
                        : kGrayColor,
                  ),

                  isActive: screenManager.indexMenuClick == 3 && select == 3,
                  // showBorder: false,
                ),
                SideMenuItem(
                  press: () {
                    onMenuIconPressed(7);
                    Navigator.of(context).pushNamed('/inviView');
                  },

                  title: drawerItems[7]['title'],
                  icon: Icon(
                    drawerItems[7]['icon'],
                    size: 25,
                    color: select == 7
                        ? customRedColor //kPrimaryColor
                        : bBasicColor,
                  ),
                  isActive: select == 7,
                  // showBorder: false,
                ),

                SizedBox(height: kDefaultPadding * 2),

                OrgTags(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

////////////////
/////////////////
///
///
///
///
///
////////
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
///////////////////
///
///
///
///
///
///
///
///
///