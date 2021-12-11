import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0.0,
    iconTheme: const IconThemeData(color: Colors.black, size: 20.0),
    actionsIconTheme: const IconThemeData(color: Colors.black, size: 20.0),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: defaultHexColor, systemNavigationBarColor: Colors.white),
    titleSpacing: 20.0,
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    elevation: 30.0,
    selectedItemColor: Colors.orange,
    unselectedItemColor: Colors.black,
  ),

  textTheme:const TextTheme(
    bodyText1:  TextStyle(
      fontSize: 18.0,
      color: Colors.black,
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      fontSize: 15.0,
      color: Colors.black,
      height: 1.4

    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.amber,
  bottomNavigationBarTheme:const BottomNavigationBarThemeData(
      elevation: 30.0,
      selectedItemColor: Colors.orange,
      unselectedItemColor: Colors.grey,
      backgroundColor: Colors.black),
  appBarTheme:const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white, size: 20.0),
    backgroundColor: Colors.black,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
    ),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 20.0),
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ),
    titleSpacing: 20.0,
  ),
  textTheme:const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ),
    bodyText2: TextStyle(
      fontSize: 12.0,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
    caption: TextStyle(
      fontFamily: 'Cairo',
      color: Colors.white
    )
  ),
  scaffoldBackgroundColor: Colors.black,
);

var uId;
bool OTB;
var defaultHexColor = HexColor('#142B52');
