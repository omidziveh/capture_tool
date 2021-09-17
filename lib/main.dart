import 'package:flutter/services.dart';

import 'theme.dart';
import 'style.dart';

import 'pages/Calendar/calendar.dart';
import 'pages/Capture_Tool/capture_tool.dart';
import 'pages/week_return.dart';
import 'pages/month_return.dart';
import 'pages/profile.dart';

import 'models/pretask.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PreTaskAdapter());
  await Hive.openBox('theme');
  await Hive.openBox('preTasks');
  await Hive.openBox('weekTasks');
  await Hive.openBox('monthTasks');
  await Hive.openBox('ID');
  await Hive.openBox('Calendar');

  Hive.box('Calendar').put('duration', 30);
  Hive.box('ID').put('id', 0);

  runApp(MaterialApp(
    theme: light,
    darkTheme: dark,
    themeMode: ThemeMode.light,
    debugShowCheckedModeBanner: false,
    // themeMode: Hive.box('theme').get('isDark', defaultValue: false),
    home: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  int _index = 1;
  List<String> names = [
    'تقویم',
    'لیست کارها',
    'بازگشت هفتگی',
    'بازگشت ماهانه',
    'ناحیه کاربری',
  ];
  List<Widget?> pages = [
    Calendar(),
    CaptureTool(),
    WeekReturn(),
    MonthReturn(),
    Profile()
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_index],
      appBar: (_index != 0)
          ? AppBar(
              centerTitle: false,
              elevation: 0,
              backgroundColor: Colors.transparent,
              bottom: PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.of(context).size.height * 0.08),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10, top: 10),
                      child: Text(names[_index], style: AppBarTextStyle),
                    ),
                    Container(
                      height: 5,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
            )
          : null,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 15, top: 5),
        child: BottomNavyBar(
          selectedIndex: _index,
          showElevation: false,
          containerHeight: MediaQuery.of(context).size.height * 0.075,
          onItemSelected: (int _selectedIndex) {
            setState(() {
              _index = _selectedIndex;
            });
          },
          items: [
            BottomNavyItem(Icons.calendar_today, 'تقویم'),
            BottomNavyItem(Icons.list, 'لیست کارها'),
            BottomNavyItem(Icons.pending_actions_sharp, 'بازگشت هفتگی'),
            BottomNavyItem(Icons.archive_outlined, 'بازگشت ماهانه'),
            BottomNavyItem(Icons.person, 'ناحیه کاربری')
          ],
        ),
      ),
    );
  }

  BottomNavyBarItem BottomNavyItem(var icon, String title) {
    return BottomNavyBarItem(
      icon: Icon(icon),
      title: FittedBox(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(title, style: NavBarTextStyle),
      )),
      textAlign: TextAlign.right,
      activeColor: Color.fromRGBO(0, 0, 0, 1),
      inactiveColor: Color.fromRGBO(0, 0, 0, 0.7),
    );
  }
}
