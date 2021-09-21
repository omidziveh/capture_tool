import 'package:capture_tool/glass/glass_widget.dart';
import 'package:capture_tool/pages/Capture_Tool/dialogs.dart';

import 'theme.dart';
import 'style.dart';

import 'pages/Calendar/calendar.dart';
import 'pages/Capture_Tool/capture_tool.dart';
import 'pages/week_return.dart';
import 'pages/month_return.dart';
import 'pages/profile.dart';

import 'glass/glass_bottom_menu.dart';
import 'glass/glass_button.dart';

import 'db/db.dart';

import 'pages/Capture_Tool/dialogs.dart';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init_db();

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
        mainAxisAlignment: MainAxisAlignment.center,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GlassBottomMenu(
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
                'ناحیه کاربری',
              ],
              icons: [
                Icons.calendar_today_outlined,
                Icons.menu,
                Icons.person_outline_rounded,
              ],
              onChange: (int index) {
                setState(() {
                  _index = index;
                });
              },
            ),
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
                  _index == 0 ? null : showPreTaskBottomSheet(context, mode: 1);
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
              backgroundColor: Color.fromRGBO(255, 255, 255, 0.9),
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
    );
  }
}
