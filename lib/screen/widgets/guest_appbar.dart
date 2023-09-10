import 'package:flutter/material.dart';
import 'package:electroniccity/model/app_theme.dart';

Widget appBar(BuildContext context) {
  var brightness = MediaQuery.of(context).platformBrightness;
  bool isLightMode = brightness == Brightness.light;

  return SizedBox(
    height: AppBar().preferredSize.height,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Electronic City',
                      style: TextStyle(
                        fontSize: 22,
                        color: isLightMode ? AppTheme.light : AppTheme.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
              ),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40),
                    child: Icon(
                      Icons.home_outlined,
                      color: isLightMode ? AppTheme.light : AppTheme.white,
                    ),
                  ),
                  onTap: () {
                      Navigator.of(context).pushNamed('/Guest');
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child:
                InkWell(
                  borderRadius: BorderRadius.circular(AppBar().preferredSize.height),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: isLightMode ? AppTheme.light : AppTheme.white,
                    ),
                  ),
                  onTap: () {
                      Navigator.of(context).pushNamed('/');
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
