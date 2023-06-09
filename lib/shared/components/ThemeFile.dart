import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../colors/colors.dart';

  ThemeDatalight()=>ThemeData(

    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      elevation: 0,
      // centerTitle: true,
    ),
    scaffoldBackgroundColor: Colors.white,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      unselectedItemColor: Colors.black54,
      backgroundColor: Colors.white,
      selectedItemColor:HexColor('#0b3f8b'),
      ),
    textTheme: TextTheme(
      subtitle1:  TextStyle(
        fontSize: 16,

        height: 1.5
      )
    ),
  );