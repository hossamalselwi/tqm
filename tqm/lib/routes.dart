import 'package:flutter/material.dart';
import 'package:tqm/views/dept/deptView.dart';

import 'package:tqm/views/splash/Splash.dart';

import 'models/empModel.dart';
import 'utils/ui_utils/custom_colors.dart';
import 'views/account/account_view.dart';
import 'views/auth/loginOrg.dart';
import 'views/auth/organization_view.dart';
import 'views/barch/newListBrch.dart';
import 'views/dashboard/dashboard_view.dart';
import 'views/empeloys/employDetials.dart';
import 'views/empeloys/employs.dart';
import 'views/invit/inviView.dart';
import 'views/invit/listInviView.dart';
import 'views/job/JobsEmpView.dart';
import 'views/job/jobsView.dart';
import 'views/names/home.dart';
import 'views/stratige/addStartegeView.dart';
import 'views/stratige/create_stratige_view.dart';
import 'views/barch/BarchOne.dart';
import 'models/barch.dart';

//////////////////////////
///
//////////////////////////////////
///

/*r(Widget child,context)
{
  return Navigator.of(context).push(
  PageRouteBuilder(
    transitionDuration: Duration(milliseconds: 1000),
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return child;
    },
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) {
      return Align(
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      );
    },
  ),
);

}*/

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => SplashScreen(),
        );
      case '/dashboard':
        final int currentIndex = settings.arguments ?? 0;
        return MaterialPageRoute(
            builder: (_) => DashboardView(currentIndex: currentIndex));

      /*case '/createNewTaskView':
        return MaterialPageRoute(builder: (_) => CreateNewTaskView());*/
      case '/loginView':
        return MaterialPageRoute(builder: (_) => LoginPage());

      case '/organizationView':
        return MaterialPageRoute(builder: (_) => OrganizationView());

      case '/homeNames':
        return MaterialPageRoute(builder: (_) => HomeNames());
      case '/brshView':
        return MaterialPageRoute(builder: (_) => BrshView());
      case '/deptView':
        return MaterialPageRoute(builder: (_) => DeptView());
      case '/jobView':
        return MaterialPageRoute(builder: (_) => JobView());

      case '/empsView':
        return MaterialPageRoute(builder: (_) => EmpsView());

      case '/empDetials':
        final EmpModel empModel = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => EmpDetials(
                  data: empModel,
                ));
      case '/barchPage':
        final model = settings.arguments;

        return MaterialPageRoute(
            builder: (_) => BarchPage(
                  data: model,
                ));

      case '/jobEmpView':
        final EmpModel empModel = settings.arguments;
        return MaterialPageRoute(
            builder: (_) => JobsEmpPage(
                  data: empModel,
                ));

      case '/AddStratigeView':
        return MaterialPageRoute(builder: (_) => AddStratigeView());

      case '/initiativePage':
        return MaterialPageRoute(builder: (_) => InitiativePage());

      case '/inviView':
        return MaterialPageRoute(builder: (_) => InviView());

      //InviView

      case '/accountView':
        return MaterialPageRoute(builder: (_) => AccountView());
      case '/createInboxView':
        return MaterialPageRoute(
            builder: (_) => CreateInboxView(), fullscreenDialog: true);
      default:
        return MaterialPageRoute(
            builder: (context) => Scaffold(
                  appBar: AppBar(
                    backgroundColor: customRedColor,
                    iconTheme: IconThemeData(color: Colors.white),
                  ),
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
/////////////////
///
///
///////////
///
////////////////
/////////////////
/////////////////
/////////////////
/////////////////////////
///
///
///
///
///

/////////////////////////
/////////////////////////
///////////////
///
///////////////////////////////////
///
///
///////////////////////
////////////////////////////////
//////////////////////////
/////////////////////////////////////////////
///
///
///
/////////////////////////////////////////
/////////////////////////////////////
///
///
///
///
///
///
///
///
////////////////////////////
///
///
//////////////////
////////////////////////////
///////////////////////
////////////////
///
///
///
///
///
////////////////
///////
///////////////////
///
///
///
///////
///
///
