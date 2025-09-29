import 'package:flutter/material.dart';

import 'package:expense_tracker/widgets/expenses.dart';

// Required to Lock Device Orientation
// import 'package:flutter/services.dart';

// k is used to Specify Global Parameters
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // //Ensure Initialization to make sure Device Orientation is locked
  // WidgetsFlutterBinding.ensureInitialized();
  // //Locking the Orientation
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((
  //   fn,
  // ) {
  //   // runApp Function Here
    runApp(
      MaterialApp(
        darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme,
          cardTheme: CardThemeData().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
            ),
          ),
          appBarTheme: AppBarTheme().copyWith(
            // backgroundColor: kDarkColorScheme.onPrimaryContainer,
            foregroundColor: kDarkColorScheme.primaryContainer,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
        theme: ThemeData().copyWith(
          colorScheme: kColorScheme,
          appBarTheme: AppBarTheme().copyWith(
            backgroundColor: kColorScheme.onPrimaryContainer,
            foregroundColor: kColorScheme.primaryContainer,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          cardTheme: CardThemeData().copyWith(
            color: kColorScheme.secondaryContainer,
            margin: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
              foregroundColor: kColorScheme.onPrimaryContainer,
            ),
          ),
          textTheme: ThemeData().textTheme.copyWith(
            bodyMedium: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 14,
            ),
            titleLarge: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ),
        themeMode: ThemeMode.system, //Default
        home: Expenses(),
      ),
    );
  // });  //Orientation Lock
}
