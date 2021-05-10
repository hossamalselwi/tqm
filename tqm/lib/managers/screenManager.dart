import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ScreenManager with ChangeNotifier {
  int indexMenuClick = 0;

  changeClickMenu(int index) {
    this.indexMenuClick = index;
    notifyListeners();
  }

  ThemeMode themeMode = ThemeMode.light;
  bool islight = true;

  ThemeMode changeThem(bool isNi) {
    if (isNi)
      themeMode = ThemeMode.dark;
    else
      themeMode = ThemeMode.light;

    notifyListeners();

/*if (Theme.of(context).brightness == Brightness.dark) {
                        DynamicTheme.of(context)
                            .setBrightness(Brightness.light);
                      } else {
                        DynamicTheme.of(context).setBrightness(Brightness.dark);
                      }*/
  }
}
