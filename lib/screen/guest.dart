import 'package:electroniccity/drawer/drawer_user_controller.dart';
import 'package:electroniccity/drawer/home_drawer.dart';
import 'package:electroniccity/screen/home_screen.dart';
import 'package:flutter/material.dart';

class Guest extends StatefulWidget {
  const Guest({super.key});

  @override
  NavigationHomeScreenState createState() => NavigationHomeScreenState();
}

class NavigationHomeScreenState extends State<Guest> {
  Widget? screenView;
  DrawerIndex? drawerIndex;

  @override
  void initState() {
    drawerIndex = DrawerIndex.Home;
    screenView = const MyGuest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          body: DrawerUserController(
            screenIndex: drawerIndex,
            drawerWidth: MediaQuery.of(context).size.width * 0.75,
            onDrawerCall: (DrawerIndex drawerIndexdata) {
              changeIndex(drawerIndexdata);
            },
            screenView: screenView,
          ),
        ),
      ),
    );
  }

  void changeIndex(DrawerIndex drawerIndexdata) {
    if (drawerIndex != drawerIndexdata) {
      drawerIndex = drawerIndexdata;
      switch (drawerIndex) {
        case DrawerIndex.Home:
          setState(() {
            Navigator.of(context).pushNamed('/MyGuest');
          });
          break;
        case DrawerIndex.Announcement:
          setState(() {
            Navigator.of(context).pushNamed('/Announcements');
          });
          break;
        case DrawerIndex.Programme:
          setState(() {
            Navigator.of(context).pushNamed('/Programmes');
          });
          break;
        case DrawerIndex.News:
          setState(() {
            Navigator.of(context).pushNamed('/News');
          });
          break;
        case DrawerIndex.Upcoming:
          setState(() {
            Navigator.of(context).pushNamed('/Events');
          });
          break;
        case DrawerIndex.Alumni:
          setState(() {
            Navigator.of(context).pushNamed('/Alumni');
          });
          break;
        case DrawerIndex.About:
          setState(() {
            Navigator.of(context).pushNamed('/About');
          });
          break;
        default:
          break;
      }
    }
  }
}
