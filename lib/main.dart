// ignore_for_file: camel_case_types
import 'package:diary_app/color_and_fonts/colors.dart';
import 'package:diary_app/model/Diary.dart';
import 'package:diary_app/model/Events.dart';
import 'package:diary_app/model/planner.dart';
import 'package:diary_app/notification/notification.dart';
import 'package:diary_app/screens/intro_screens/splash_screen.dart';
import 'package:diary_app/varibles_and_functions/variables.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  settingsDb = await Hive.openBox('Settings');
  Hive.registerAdapter(DiaryAdapter());
  Hive.registerAdapter(EventsAdapter());
  Hive.registerAdapter(PlannerAdapter());
  await Hive.openBox<Diary>('diarydb');
  await Hive.openBox<Events>('eventsdb');
  await Hive.openBox<Planner>('plannerdb');

  await NotificationServices.initialiseNotiifcation(null);
  runApp(const MyDiary());
}

class MyDiary extends StatelessWidget {
  const MyDiary({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          iconButtonTheme: const IconButtonThemeData(
            style: ButtonStyle(
              padding: MaterialStatePropertyAll(
                EdgeInsets.all(0),
              ),
            ),
          ),
          switchTheme: const SwitchThemeData(
            trackColor: MaterialStatePropertyAll(primaryRed),
            trackOutlineColor: MaterialStatePropertyAll(Colors.transparent),
          ),
          popupMenuTheme: const PopupMenuThemeData(color: primaryWhite),
          appBarTheme: const AppBarTheme(
              backgroundColor: primaryRed, foregroundColor: primaryWhite),
          bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          iconTheme: const IconThemeData(color: primaryBlack)),
      home: const SplashScreen(),
    );
  }
}
