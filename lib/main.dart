import 'dart:ffi';

import 'package:english_words/english_words.dart';
import 'package:expense_tracker/api/country_service.dart';
import 'package:expense_tracker/country_card.dart';
import 'package:expense_tracker/country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: Consumer<MyAppState>(
        builder: (context, appState, child) {
          return MaterialApp(
            title: 'Countries',
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: appState.lightMode
                  ? const Color(0xfffafafa)
                  : const Color(0xff202c37),
              colorScheme: ColorScheme.fromSeed(
                seedColor: appState.lightMode
                    ? const Color(0xfffafafa)
                    : const Color(0xff2b3945),
                primary: appState.lightMode
                    ? const Color(0xff2b3945)
                    : const Color(0xfffafafa),
                onPrimaryFixed: appState.lightMode
                    ? const Color(0xfffafafa)
                    : const Color(0xfffafafa),
              ).copyWith(
                brightness:
                    appState.lightMode ? Brightness.light : Brightness.dark,
              ),
              textTheme: GoogleFonts.nunitoSansTextTheme(
                TextTheme(
                  bodyLarge: TextStyle(
                    color: appState.lightMode
                        ? const Color(0xff111517)
                        : const Color(0xffffffff),
                  ),
                  bodyMedium: TextStyle(
                    color: appState.lightMode
                        ? const Color(0xff111517)
                        : const Color(0xffffffff),
                  ),
                  titleLarge: TextStyle(
                    color: appState.lightMode
                        ? const Color(0xff111517)
                        : const Color(0xffffffff),
                  ),
                ).apply(
                  bodyColor: appState.lightMode
                      ? const Color(0xff111517)
                      : const Color(0xffffffff),
                  displayColor: appState.lightMode
                      ? const Color(0xff111517)
                      : const Color(0xffffffff),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(
                  color: appState.lightMode
                      ? const Color(0xff111517)
                      : const Color(0xffffffff),
                ),
                prefixIconColor: appState.lightMode
                    ? const Color(0xff111517)
                    : const Color(0xffffffff),
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: appState.lightMode
                    ? const Color(0xfffafafa)
                    : const Color(0xff2b3945),
                titleTextStyle: GoogleFonts.nunitoSans(
                  color: appState.lightMode
                      ? const Color(0xff111517)
                      : const Color(0xffffffff),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                iconTheme: IconThemeData(
                  color: appState.lightMode
                      ? const Color(0xff111517)
                      : const Color(0xffffffff),
                ),
              ),
              cardTheme: CardTheme(
                color: appState.lightMode
                    ? const Color(0xffffffff)
                    : const Color(0xff2b3945),
              ),
            ),
            home: MyHomePage(),
          );
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var lightMode = true;
  void toggleLightMode() {
    lightMode = !lightMode;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: const Text(
              'Where in the world',
            ),
            actions: <Widget>[
              IconButton(
                icon: appState.lightMode
                    ? Icon(Icons.light_mode)
                    : Icon(Icons.dark_mode),
                tooltip: appState.lightMode
                    ? 'Set to dark mode'
                    : 'Set to light mode',
                onPressed: () {
                  appState.toggleLightMode();
                },
              ),
            ],
          ),
          body: SafeArea(
            child: Container(
              alignment: Alignment.center,
              child: CountryList(),
            ),
          ),
        );
      },
    );
  }
}
