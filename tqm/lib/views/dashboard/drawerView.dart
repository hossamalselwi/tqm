import 'package:flutter/material.dart';
import '../../utils/ui_utils/custom_colors.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

List<Map> drawerItems = [
  {'icon': Icons.home, 'title': 'الرئيسية', 'pageRoute': '/deptNameView'},
  {'icon': Icons.admin_panel_settings_outlined, 'title': 'الادارة'},
  {
    'icon': Icons.timeline_outlined,
    'title': 'الاستراتيجية ',
    'pageRoute': '/dashboard'
  },
  {'icon': Icons.timeline_outlined, 'title': 'مؤشرات الاداء '},
  {'icon': Icons.timeline_outlined, 'title': 'التقارير  '},
  {'icon': Icons.search_outlined, 'title': ' بحث '},
  {'icon': Icons.settings_applications_outlined, 'title': ' الاعدادات  '},
  /*{
    'icon': Icons.logout,
    'title' : 'تسجيل الخروج  '
  },*/

  {'icon': Icons.account_tree, 'title': ' الحساب  '},
];

////

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: bBasicColor,
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150.0,
                    height: 120.0,
                    child: ImageIcon(
                      AssetImage(
                        'assets/image/logo.png',
                      ),
                      color: customRedColor,
                    ),
                  ),
                  // Text('منصة قيم ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  //Text('لادارة الجودة الشاملة ',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ListView(shrinkWrap: true, children: [
              for (int i = 0; i < drawerItems.length; i++)
                ListTile(
                  dense: true,
                  onTap: () {
                    switch (drawerItems[i]['title']) {
                      case 'تسجيل الدخول  ':
                        Navigator.of(context).push(new MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (c) {
                              // return LoginPage();
                              //LoginScreen();
                            }));

                        break;
                    }
                  },
                  title: Text(drawerItems[i]['title'],
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: customRedColor, fontWeight: FontWeight.bold)),
                  leading: Icon(
                    drawerItems[i]['icon'],
                    color: customRedColor,
                  ),
                ),
              ExpansionTile(
                title: Text("اعدادات الاسماء"),
                children: <Widget>[
                  Text("اسماء الاقسام"),
                  Text(" اسماء الوظائف")
                ],
              )
            ]

                /*drawerItems.map(
                (element) => Padding(
                padding: const EdgeInsets.fromLTRB(9,8,9,8),
                child: 
                InkWell(
                  onTap: (){
                    switch (element['title']) {
                case 'تسجيل الدخول  ':

                  Navigator.of(context).push(new MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (c) {
                       // return LoginPage();
                        //LoginScreen();
                      }));
                 
                  break;
                    }

                  },
                                  child: Row(
                    children: [
                      Icon(element['icon'],color: customRedColor,size: 24,),
                      SizedBox(width: 10,),
                      Text(element['title'],style: TextStyle(color: customRedColor,
                      fontWeight: FontWeight.normal,fontSize: 14))
                    ],
                  ),
                ),
              )
              )
              .toList(),*/
                ),
          ),
          Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'حول قيم',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'تواصل معنا',
                style: TextStyle(color: Colors.white, fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }
}
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
///
///
