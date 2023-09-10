import 'package:flutter/material.dart';
import 'package:electroniccity/screen/guest.dart';
import '../main.dart';
import '../model/app_theme.dart';
import '../screen/home_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/Guest':
        return MaterialPageRoute(builder: (_) => const Guest());
      case '/MyGuest':
        return MaterialPageRoute(builder: (_) => const MyGuest());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          // iconTheme: AppTheme.white,
          title: const Text('Electronic City', style: TextStyle(color: AppTheme.white01)),
          centerTitle: true,
          backgroundColor: AppTheme.light,
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    });
  }
}
