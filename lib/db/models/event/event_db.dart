import 'package:capture_tool/db/models/event/event.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

void updateEvent(
  Event defaultEvent, {
  String? id,
  String? title,
  DateTime? startDate,
  DateTime? finishDate,
  String? description,
  String? goals,
  int? showState,
}) {
  Event event = Event(
    id: id ?? defaultEvent.id,
    title: title ?? defaultEvent.title,
    description: description ?? defaultEvent.description,
    goals: goals ?? defaultEvent.goals,
    startDate: startDate ?? defaultEvent.startDate,
    finishDate: finishDate ?? defaultEvent.finishDate,
    showState: showState ?? defaultEvent.showState,
  );
  Hive.box('events').put(id ?? defaultEvent.id, event);
}

void deleteEvent(String id) {
  Hive.box('events').delete(id);
}

void addEvent(
  String title,
  DateTime startDate,
  DateTime finishDate,
  String? description,
  String? goals,
  int? showState,
) {
  var uuid = Uuid();
  String id = uuid.v1();
  Event event = Event(
    id: id,
    title: title,
    description: description ?? '',
    goals: goals ?? '',
    startDate: startDate,
    finishDate: finishDate,
    showState: showState ?? 0,
  );
  Hive.box('events').put(id, event);
}
