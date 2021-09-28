import 'pretask.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

void done_pretask(String id, [Box? startBox]) {
  /// this line set a default value for startBox:
  startBox ??= Hive.box('preTasks');

  /// Remove item from startBox and add it to donePreTasks box
  var item = startBox.get(id);
  startBox.delete(id);
  Hive.box('donePreTasks').put(item.id, item);
}

void delete_pretask(String id, [Box? startBox]) {
  startBox ??= Hive.box('preTasks');

  /// Remove item from preTasks box and Add the item to preTasksTrash box
  var item = startBox.get(id);
  startBox.delete(id);
  Hive.box('preTasksTrash').put(item.id, item);
}

void go_to_weekly(String id, [Box? startBox]) {
  startBox ??= Hive.box('preTasks');

  /// Remove item from preTasks box and Add the item to weeklyReturn box
  var item = startBox.get(id);
  startBox.delete(id);
  Hive.box('weeklyReturn').put(item.id, item);
}

void go_to_monthly(String id, [Box? startBox]) {
  startBox ??= Hive.box('preTasks');

  /// Remove item from preTasks box and Add the item to monthlyReturn box
  var item = startBox.get(id);
  startBox.delete(id);
  Hive.box('monthlyReturn').put(item.id, item);
}

void add_pretask(String title, double importance,
    {String description = '', state = 1}) {
  /// get title, importance, description and state then create a uuid and add
  /// them to preTasks box

  var uuid = Uuid();
  String id = uuid.v1();
  DateTime timeStamp = DateTime.now();
  PreTask preTask = PreTask(
      id: id,
      title: title,
      description: description,
      importance: importance,
      timeStamp: timeStamp,
      state: state);
  Hive.box('preTasks').put(id, preTask);
}

void update_pretask(String id,
    {title, description, importance, Box? startBox}) {
  /// get id and title, description and importance and change the task with
  /// <id> of id and change the values that changed

  startBox ??= Hive.box('preTasks');

  var preTask = startBox.get(id);
  if (title != null) {
    preTask.title = title;
  }
  if (description != null) {
    preTask.description = description;
  }
  if (importance != null) {
    preTask.importance = importance;
  }
}

List<dynamic> all_pre_tasks({Box? box}) {
  box ??= Hive.box('preTasks');
  return box.values.toList();
}
