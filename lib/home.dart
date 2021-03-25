import 'package:conic/pages/coin_list/coin_list.dart';
import 'package:conic/pages/index/index.dart';
import 'package:conic/pages/more/more.dart';
import 'package:conic/pages/news/news.dart';
import 'package:conic/pages/portfolio/portfolio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home_filled)),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart)),
            BottomNavigationBarItem(icon: Icon(Icons.pie_chart)),
            BottomNavigationBarItem(icon: Icon(Icons.compass_calibration)),
            BottomNavigationBarItem(icon: Icon(Icons.more_horiz_outlined)),
          ],
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return Index();
            case 1:
              return CoinList();
            case 2:
              return Portfolio();
            case 3:
              return News();
            case 4:
              return More();
            default:
              return Index();
          }
        },
      ),
    );
  }
}
