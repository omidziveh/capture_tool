import 'dart:io';

import 'package:capture_tool/pages/Capture_Tool/dialogs.dart';
import 'package:flutter/services.dart';

import 'theme.dart';
import 'style.dart';

import 'pages/Calendar/calendar.dart';
import 'pages/Capture_Tool/capture_tool.dart';
import 'pages/week_return.dart';
import 'pages/month_return.dart';
import 'pages/profile.dart';

import 'glass/glass_bottom_menu.dart';
import 'glass/glass_button.dart';

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
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GlassButton(
            height: _index != 1 ? 0 : 70,
            width: _index != 1 ? 0 : 70,
            borderRadius: 20,
            child: IconButton(
              icon: Icon(Icons.more_vert),
              splashColor: Colors.transparent,
              onPressed: () {},
            ),
          ),
          GlassBottomMenu(
            startIndex: 1,
            borderRadius: 20,
            //width: MediaQuery.of(context).size.width * 0.7,
            width: 180,
            height: 70,
            unselectedColor: Colors.black38,
            selectedColor: Colors.black,
            titles: [
              'تقویم',
              'لیست کارها',
              // 'بازگشت هفتگی',
              // 'بازگشت ماهانه',
              'ناحیه کاربری',
            ],
            icons: [
              Icons.calendar_today_outlined,
              Icons.menu,
              // Icons.pending_actions_rounded,
              // Icons.archive_outlined,
              Icons.person_outline_rounded,
            ],
            onChange: (int index) {
              setState(() {
                _index = index;
              });
            },
          ),
          // Padding(padding: EdgeInsets.only(left: 5)),
          AnimatedContainer(
            duration: Duration(milliseconds: 1000),
            child: GlassButton(
              width: _index != 1 ? 0 : 70,
              height: _index != 1 ? 0 : 70,
              child: IconButton(
                splashColor: Colors.transparent,
                icon: Icon(
                  Icons.add_rounded,
                  color: Colors.black,
                ),
                onPressed: () {
                  _index == 0 ? null : showMyBottomSheet(context, '', '', 1);
                },
              ),
              borderRadius: 20,
            ),
          )
        ],
      ),
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
      // bottomNavigationBar: BottomNavyBar(
      //   animationDuration: Duration(milliseconds: 200),
      //   selectedIndex: _index,
      //   showElevation: true,
      //   containerHeight: MediaQuery.of(context).size.height * 0.085,
      //   onItemSelected: (int _selectedIndex) {
      //     setState(() {
      //       _index = _selectedIndex;
      //     });
      //   },
      //   items: [
      //     bottomNavyItem(Icons.calendar_today, '   تقویم   '),
      //     bottomNavyItem(Icons.list, 'لیست کارها'),
      //     bottomNavyItem(Icons.pending_actions_sharp, '   بازگشت هفتگی'),
      //     bottomNavyItem(Icons.archive_outlined, 'بازگشت ماهانه'),
      //     bottomNavyItem(Icons.person, 'ناحیه کاربری')
      //   ],
      // ),
    );
  }

  BottomNavyBarItem bottomNavyItem(var icon, String title) {
    return BottomNavyBarItem(
      icon: Icon(icon, size: MediaQuery.of(context).size.height * 0.035),
      title: FittedBox(
          fit: BoxFit.fill, child: Text(title, style: NavBarTextStyle)),
      textAlign: TextAlign.right,
      activeColor: Color.fromRGBO(0, 0, 0, 1),
      inactiveColor: Color.fromRGBO(0, 0, 0, 0.5),
    );
  }
}
