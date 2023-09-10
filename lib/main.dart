// ignore_for_file: use_build_context_synchronously, invalid_return_type_for_catch_error, avoid_print, unused_local_variable, unused_field
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:electroniccity/model/app_theme.dart';
import 'package:electroniccity/route/routegenerator.dart';
import 'package:upgrader/upgrader.dart';

import 'screen/guest.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}
class MyAppState extends State<MyApp>{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(), // standard dark theme
      themeMode: ThemeMode.system,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }

}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    return Scaffold(
      body: UpgradeAlert(
        child: const HomeScreen()
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isLightMode = brightness == Brightness.light;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: !kIsWeb && Platform.isAndroid ? Brightness.dark : Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return Scaffold(
      backgroundColor: isLightMode ? AppTheme.background : AppTheme.nearlyBlack,
      body: WillPopScope(
        onWillPop: () => _confirmExit(context),
        child: Guest(),
      ),
    );
  }

  _confirmExit(BuildContext context) {
    return showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                backgroundColor: AppTheme.white,
                title: const Text('Exit MyIAA',),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No', style: TextStyle(color: AppTheme.red),),
                  ),
                  TextButton(
                    onPressed: () => exit(0),
                    child: const Text('Yes', style: TextStyle(color: AppTheme.red),),
                  ),
                ],
              ),
            );
  }
}

class HexColor extends Color{
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor){
    if(hexColor.length == 6 ){

      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);

  }

}