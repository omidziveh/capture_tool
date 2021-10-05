import 'package:capture_tool/glass/glass_widget.dart';
import 'package:capture_tool/pages/Capture_Tool/capture_tool.dart';
import 'package:capture_tool/pages/Capture_Tool/dialogs.dart';
import 'package:capture_tool/pages/Capture_Tool/popup_menu.dart';

import 'theme.dart';
import 'style.dart';
import 'default_appbar.dart';

import 'pages/Calendar/calendar.dart';
import 'pages/week_return.dart';
import 'pages/month_return.dart';
import 'pages/profile/profile.dart';

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

  Hive.box('Calendar').put('timeStep', 15);
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

class _AppState extends State<App> with TickerProviderStateMixin {
  late AnimationController _bottom_menu_controller;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _bottom_menu_controller = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _bottom_menu_controller.reverse();
    super.dispose();
  }

  @override
  int _index = 1;
  int bottom_button_width = 70;
  double popup_menu_height = 0;
  List<String> names = [
    'تقویم',
    'لیست کارها',
    'ناحیه کاربری',
  ];
  List<Widget?> pages = [
    Calendar(),
    CaptureTool(),
    Profile(),
  ];

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (popup_menu_height == 100) {
          setState(() {
            _bottom_menu_controller.reverse();
            _isPlaying = false;
            popup_menu_height = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,

        /// you can see the preTasks behind the appbar
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            PopupMenu(
              height: popup_menu_height,
              children: [
                GlassButton(
                  width: 50,
                  height: 50,
                  borderRadius: 10,
                  child: IconButton(
                    icon: Icon(Icons.pending_actions_rounded),
                    onPressed: () {
                      setState(() {
                        popup_menu_height = 0;
                        _bottom_menu_controller.reverse();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => WeekReturn()),
                        );
                      });
                    },
                    splashColor: Colors.transparent,
                  ),
                ),
                Padding(padding: EdgeInsets.only(left: 10)),
                GlassButton(
                  width: 50,
                  height: 50,
                  borderRadius: 10,
                  child: IconButton(
                    icon: Icon(Icons.archive_outlined),
                    onPressed: () {
                      setState(() {
                        _bottom_menu_controller.reverse();
                        popup_menu_height = 0;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MonthReturn(),
                          ),
                        );
                      });
                    },
                    splashColor: Colors.transparent,
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: bottom_button_width.toDouble(),
                  child: GlassButton(
                    height: 70,
                    width: 70,
                    borderRadius: 20,
                    child: IconButton(
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.menu_close,
                        progress: _bottom_menu_controller,
                      ),
                      splashColor: Colors.transparent,
                      onPressed: () {
                        setState(() {
                          _isPlaying = !_isPlaying;
                          _isPlaying
                              ? _bottom_menu_controller.forward()
                              : _bottom_menu_controller.reverse();
                          popup_menu_height = popup_menu_height == 0 ? 100 : 0;
                        });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
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
                          print(index);
                          _index = index;
                          if (index == 0 || index == 2) {
                            bottom_button_width = 0;
                            popup_menu_height = 0;
                            _isPlaying = false;
                            _bottom_menu_controller.reverse();
                          } else {
                            bottom_button_width = 70;
                          }
                        });
                      },
                    ),
                  ),
                ),
                // Padding(padding: EdgeInsets.only(left: 5)),
                AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: bottom_button_width.toDouble(),
                  child: GlassButton(
                    width: 70,
                    height: 70,
                    child: IconButton(
                      splashColor: Colors.transparent,
                      icon: Icon(
                        Icons.add_rounded,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        _index == 0
                            ? null
                            : showPreTaskBottomSheet(context, mode: 1);
                      },
                    ),
                    borderRadius: 20,
                  ),
                )
              ],
            ),
          ],
        ),
        body: pages[_index],
        appBar: (_index != 0)
            ? defaultAppBar(
                names[_index],

                /// appbar title
                context,

                /// BuildContext
              )
            : null,
      ),
    );
  }
}
