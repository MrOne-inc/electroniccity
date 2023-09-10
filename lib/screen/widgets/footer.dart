import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:electroniccity/model/app_theme.dart';

Widget bottomBar() {
  return SizedBox(
      height: AppBar().preferredSize.height,
      child: DefaultTabController(
        length: 5, // Number of tabs
        child: Scaffold(
          bottomNavigationBar: ConvexAppBar.badge(const {3: ''},
            items: const [
              TabItem(icon: Icons.home_outlined, title: 'Home'),
              TabItem(icon: Icons.security, title: 'Services'),
              TabItem(icon: Icons.add_circle, title: 'Local'),
              TabItem(icon: Icons.camera_alt, title: 'Camera'),
              TabItem(icon: Icons.add_alert, title: 'Alerts'),
            ],
            activeColor: AppTheme.light,
            backgroundColor: AppTheme.background,
            color: AppTheme.light,
          ),
        ),)
  );
}