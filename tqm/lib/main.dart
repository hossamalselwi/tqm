import 'package:bot_toast/bot_toast.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'managers/screenManager.dart';
import 'shared_widgets/theme/darkTheme.dart';
import 'shared_widgets/theme/lightTheme.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'routes.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await Hive.initFlutter();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<ScreenManager>.value(value: ScreenManager())
  ], child: MyApp()));

  //runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenManager>(
      builder: (context, screenManager, child) => StreamBuilder<User>(
          stream: _auth.userChanges(),
          builder: (context, snapshot) {
            return MaterialApp(
              title: 'TQM الجودة الشاملة',
              builder: BotToastInit(),
              theme: lightTheme(context: context),
              darkTheme: darkTheme(context: context),
              themeMode: screenManager.themeMode,
              initialRoute: '/',
              onGenerateRoute: Routes.generateRoute,
              debugShowCheckedModeBanner: false,
              localizationsDelegates: [
                //AppLocalizations.delegate,
                //
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              locale: const Locale('ar', 'YE'),
              supportedLocales: [
                const Locale('en'),
                const Locale('nl'),
                const Locale('ar'),
              ],
              navigatorObservers: [
                BotToastNavigatorObserver(),
              ],
              localeResolutionCallback:
                  (Locale locale, Iterable<Locale> supportedLocales) {
                return locale;
              },
            );
          }),
    );
  }
}

//////
///
/////////////////
/////////////////
/////////////////
////////////////////
////////
/////////////////
///
//////////////
///
///
///
///
///////////////////////
///
///////
///////
////////
/////////
/////////////
//////
///////
/////////////////////
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
///
///
///
///
