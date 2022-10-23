
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';


class ThemeServices{

  final lightTheme= ThemeData.light().copyWith(
    primaryColor: Colors.white,
    textTheme: const TextTheme(
      headline1:TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
      headline2:TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 14),
      headline3:TextStyle(color: Colors.black54,fontSize: 13,fontWeight: FontWeight.w700,),
      headline4:TextStyle(color: Colors.black45,fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'Merriweather'),
      headline5:TextStyle(color: Colors.black45,fontSize: 17),
      headline6:TextStyle(color: Colors.black54,fontSize: 11,fontWeight: FontWeight.w700,),
    ),

    appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.white
    ),
    brightness: Brightness.light,


    dividerColor: Colors.black12,
  );
  final darkTheme= ThemeData.dark().copyWith(
    secondaryHeaderColor: Colors.white,

    appBarTheme:const AppBarTheme(
        elevation: 0,
        color:Colors.black12
    ),
    textTheme: const TextTheme(
      headline1:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
      headline2:TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 14),
      headline3:TextStyle(color: Colors.white70,fontSize: 13),
      headline4:TextStyle(color: Colors.white70,fontSize: 22,fontWeight: FontWeight.bold,fontFamily: 'Merriweather'),
      headline5:TextStyle(color: Colors.white70,fontSize: 17),
      headline6:TextStyle(color: Colors.white70,fontSize: 12),
      // bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
    ),
    dividerColor: Colors.white54,
  );

  static final getStorage= GetStorage();
  static final _darkThemeKey='isDarkMode';

  static void saveThemeData(bool isDarkMode){
    getStorage.write(_darkThemeKey, isDarkMode);
  }
  static bool isSaveThemeData(){
    return getStorage.read(_darkThemeKey)?? false;
  }
  ThemeMode getThemeMode(){
    return isSaveThemeData() ? ThemeMode.light : ThemeMode.dark;
  }
  static void changeThemeMode(){
    print('theme from services $isSaveThemeData');
    isSaveThemeData()? ThemeMode.dark : ThemeMode.light;
    saveThemeData(!isSaveThemeData());
  }

}