import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/screens/planner_and_progress/planner_screen.dart';
import 'package:diary_app/screens/calender_and_events/calender.dart';
import 'package:diary_app/screens/calender_and_events/events.dart';
import 'package:diary_app/screens/diary/home.dart';
import 'package:diary_app/screens/planner_and_progress/progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

List<Widget?> body = const [EventSceen(), Calender(), Home(), Planner(), Progress()];
int selectedindex = 2;

class _BottomNavState extends State<BottomNav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body[selectedindex],
      bottomNavigationBar: SnakeNavigationBar.color(
        backgroundColor: primaryBlack,
        currentIndex: selectedindex,
        onTap: (value) {
          setState(
            () {
              selectedindex = value;
            },
          );
        },
        selectedItemColor: primaryWhite,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: primaryWhite,
        snakeViewColor: primaryRed,
        snakeShape: SnakeShape.circle,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.timelapse_outlined), label: ''),
        ],
      ),
    );
  }
}
