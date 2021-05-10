import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tqm/utils/ui_utils/custom_colors.dart';

/// light theme

ThemeData darkTheme({BuildContext context, Locale locale}) {
  return ThemeData(
      scaffoldBackgroundColor: Color(0xff121212),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textSelectionTheme: TextSelectionThemeData(cursorColor: customGreyColor),
      errorColor: Color(0xffCF6679),
      primaryColor: Colors.black,
      indicatorColor: customRedColor,
      highlightColor: customRedColor.withOpacity(.5),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: customRedColor),
      platform: defaultTargetPlatform,
      unselectedWidgetColor: Colors.grey,
      accentColor: customRedColor,
      brightness: Brightness.dark,
      fontFamily: 'Nahdi',
      //locale.languageCode == 'ar' ? 'Noto' : 'Circular',
      //GoogleFonts.poppins().fontFamily
      //,
      cardColor: Color.fromRGBO(35, 31, 31, 1),
      tabBarTheme: TabBarTheme(
        unselectedLabelColor: Colors.white.withOpacity(.7),
      ),
      textTheme: Typography.material2018(platform: defaultTargetPlatform)
          .white
          .copyWith(
            bodyText1: TextStyle(color: Colors.white, fontSize: 16),
            bodyText2: TextStyle(color: Colors.white, fontSize: 14),
            caption: TextStyle(color: Colors.white, fontSize: 12),
            headline1: TextStyle(color: Colors.white, fontSize: 96),
            headline2: TextStyle(color: Colors.white, fontSize: 60),
            headline3: TextStyle(color: Colors.white, fontSize: 48),
            headline4: TextStyle(color: Colors.white, fontSize: 34),
            headline6: TextStyle(color: Colors.white, fontSize: 20),
            headline5: TextStyle(color: Colors.white, fontSize: 24),
            subtitle1: TextStyle(color: Colors.white, fontSize: 16),
            subtitle2: TextStyle(color: Colors.white, fontSize: 14),
            overline: TextStyle(color: Colors.white, fontSize: 10),
            button: TextStyle(color: Colors.white, fontSize: 16),
          ),
      iconTheme: IconThemeData(color: Colors.white),
      dividerTheme: DividerThemeData(
          color: Color.fromRGBO(113, 128, 150, 1), thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Color.fromRGBO(31, 31, 31, 1),
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
            borderSide: BorderSide(color: Color(0xffCF6679).withOpacity(.5)),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffCF6679)),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        labelStyle:
            Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.white),
        errorStyle: Theme.of(context)
            .textTheme
            .bodyText2
            .copyWith(color: Color(0xffCF6679)),
      ),
      appBarTheme: AppBarTheme(
          elevation: 0,
          brightness: Brightness.dark,
          color: Color(0xff121212),
          iconTheme: IconThemeData(color: Colors.white),
          textTheme: Typography.material2018(platform: defaultTargetPlatform)
              .white
              .copyWith(
                bodyText1: TextStyle(color: Colors.white, fontSize: 16),
                bodyText2: TextStyle(color: Colors.white, fontSize: 14),
                caption: TextStyle(color: Colors.white, fontSize: 12),
                headline1: TextStyle(color: Colors.white, fontSize: 96),
                headline2: TextStyle(color: Colors.white, fontSize: 60),
                headline3: TextStyle(color: Colors.white, fontSize: 48),
                headline4: TextStyle(color: Colors.white, fontSize: 34),
                headline5: TextStyle(color: Colors.white, fontSize: 24),
                headline6: TextStyle(color: Colors.white, fontSize: 20),
                subtitle1: TextStyle(color: Colors.white, fontSize: 16),
                subtitle2: TextStyle(color: Colors.white, fontSize: 14),
                overline: TextStyle(color: Colors.white, fontSize: 10),
                button: TextStyle(color: Colors.white, fontSize: 16),
              )));
}
