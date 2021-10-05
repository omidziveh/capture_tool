import 'package:hive/hive.dart';

part 'event.g.dart';

@HiveType(typeId: 1)
class Event {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime startDate;

  @HiveField(2)
  DateTime finishDate;

  @HiveField(3)
  String title;

  @HiveField(4)
  String description;

  @HiveField(5)
  String goals;

  Event({
    required this.id,
    required this.startDate,
    required this.finishDate,
    required this.title,
    required this.description,
    required this.goals,
  });
}
