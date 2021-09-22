import 'pretask.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

void delete_pretask(String id) {
  /// Remove item from preTasks box and Add the item to preTasksTrash box
  var item = Hive.box('preTasks').get(id);
  Hive.box('preTasks').delete(id);
  Hive.box('preTasksTrash').put(item.id, item);
}

void go_to_weekly(String id) {
  /// Remove item from preTasks box and Add the item to weeklyReturn box
  var item = Hive.box('preTasks').get(id);
  Hive.box('preTasks').delete(id);
  Hive.box('weeklyReturn').put(
      item.id,
      PreTask(
          id: id,
          title: item.title,
          description: item.description,
          importance: item.importance,
          timeStamp: item.timeStamp,
          state: 3));
}

void go_to_monthly(String id) {
  /// Remove item from preTasks box and Add the item to monthlyReturn box
  var item = Hive.box('preTasks').get(id);
  Hive.box('preTasks').delete(id);
  Hive.box('monthlyReturn').put(
      item.id,
      PreTask(
          id: id,
          title: item.title,
          description: item.description,
          importance: item.importance,
          timeStamp: item.timeStamp,
          state: 3));
}

void add_pretask(String title, double importance,
    {String description = '', state = 1}) {
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

void update_pretask(String id, {title, description, importance}) {
  var preTask = Hive.box('preTasks').get(id);
  if (title != null) {
    print(title);
    preTask.title = title;
  }
  if (description != null) {
    preTask.description = description;
  }
  if (importance != null) {
    preTask.importance = importance;
  }
  Hive.box('preTasks').put('omid is noob', 'amir is pro');
  Hive.box('preTasks').delete('omid is noob');
}

List<dynamic> all_pre_tasks() {
  return Hive.box('preTasks')
      .values
      .toList()
      .where((item) => item.state == 1)
      .toList();
}
