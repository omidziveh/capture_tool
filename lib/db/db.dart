import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/pre_task/pretask.dart';

Future<void> init_db() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PreTaskAdapter());
  await Hive.openBox('theme');
  await Hive.openBox('preTasks');
  await Hive.openBox('weeklyReturn');
  await Hive.openBox('monthlyReturn');
  await Hive.openBox('preTasksTrash');
  await Hive.openBox('ID');
  await Hive.openBox('Calendar');
}