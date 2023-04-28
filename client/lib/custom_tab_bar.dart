// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({required this.controller, required this.tabs});

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabBarScalling = screenWidth > 1400
        ? 0.3
        : screenWidth > 1100
            ? 0.4
            : 0.5;

    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.05),
      child: Container(
        width: screenWidth * tabBarScalling,
        child: Theme(
          data: ThemeData(
              highlightColor: Color.fromARGB(0, 255, 140, 53),
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent),
          child: TabBar(
            controller: controller,
            tabs: tabs,
            indicatorColor: Color.fromARGB(255, 182, 98, 45),
          ),
        ),
      ),
    );
  }
}
