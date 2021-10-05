import 'package:capture_tool/db/models/event/event.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

void addEvent(
  String title,
  DateTime startDate,
  DateTime finishDate,
  String? description,
  String? goals,
) {
  var uuid = Uuid();
  String id = uuid.v1();
  Event event = Event(
    id: id,
    title: title,
    description: description == null ? '' : description,
    goals: goals == null ? '' : goals,
    startDate: startDate,
    finishDate: finishDate,
  );
  Hive.box('events').put(id, event);
}
