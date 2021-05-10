import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';

/// light theme

///
//final Locale locale = Locale('ar');

ThemeData lightTheme({
  BuildContext context,
  Locale locale,
}) {
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme: TextSelectionThemeData(cursorColor: customGreyColor),
      errorColor: Color.fromRGBO(229, 62, 62, 1),
      platform: defaultTargetPlatform,
      highlightColor: customRedColor.withOpacity(.5),
      primaryColor: bBasicColor,
      canvasColor: Colors.white,
      indicatorColor: customRedColor,
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: customRedColor),
      unselectedWidgetColor: Colors.grey,
      brightness: Brightness.light,
      fontFamily: 'Nahdi',
      //fontFamily: locale.languageCode == 'ar' ? 'Cairo' : 'Circular'
      // GoogleFonts.poppins().fontFamily

      cardColor: Color.fromRGBO(250, 250, 250, 1),
      accentColor: customRedColor,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        alignLabelWithHint: true,
        hintStyle: Theme.of(context).textTheme.bodyText1,
        contentPadding: EdgeInsets.all(15.0),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300], width: .5),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300], width: .5),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        disabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE5E5E5)),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB00020).withOpacity(.5)),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffB00020)),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        labelStyle: Theme.of(context).textTheme.bodyText2,
        errorStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Color.fromRGBO(229, 62, 62, 1)),
      ),
      iconTheme: IconThemeData(color: Colors.black),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.black.withOpacity(.5),
      ),
      textTheme: Typography.material2018(platform: defaultTargetPlatform)
          .white
          .copyWith(
            bodyText1: TextStyle(color: Colors.black, fontSize: 16),
            bodyText2: TextStyle(color: Colors.black, fontSize: 14),
            caption: TextStyle(color: Colors.black, fontSize: 12),
            headline1: TextStyle(color: Colors.black, fontSize: 96),
            headline2: TextStyle(color: Colors.black, fontSize: 60),
            headline3: TextStyle(color: Colors.black, fontSize: 48),
            headline4: TextStyle(color: Colors.black, fontSize: 34),
            headline5: TextStyle(color: Colors.black, fontSize: 24),
            headline6: TextStyle(color: Colors.black, fontSize: 20),
            subtitle1: TextStyle(color: Colors.black, fontSize: 16),
            subtitle2: TextStyle(color: Colors.black, fontSize: 14),
            overline: TextStyle(color: Colors.black, fontSize: 10),
            button: TextStyle(color: Colors.black, fontSize: 16),
          ),
      dividerTheme: DividerThemeData(color: Color(0xffEDF2F7), thickness: 1),
      appBarTheme: AppBarTheme(
          elevation: 0,
          brightness: Brightness.light,
          color: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          textTheme: Typography.material2018(platform: defaultTargetPlatform)
              .white
              .copyWith(
                bodyText1: TextStyle(color: Colors.black, fontSize: 16),
                bodyText2: TextStyle(color: Colors.black, fontSize: 14),
                caption: TextStyle(color: Colors.black, fontSize: 12),
                headline1: TextStyle(color: Colors.black, fontSize: 96),
                headline2: TextStyle(color: Colors.black, fontSize: 60),
                headline3: TextStyle(color: Colors.black, fontSize: 48),
                headline4: TextStyle(color: Colors.black, fontSize: 34),
                headline5: TextStyle(color: Colors.black, fontSize: 24),
                headline6: TextStyle(color: Colors.black, fontSize: 20),
                subtitle1: TextStyle(color: Colors.black, fontSize: 16),
                subtitle2: TextStyle(color: Colors.black, fontSize: 14),
                overline: TextStyle(color: Colors.black, fontSize: 10),
                button: TextStyle(color: Colors.black, fontSize: 16),
              )));
}

///dark theme
