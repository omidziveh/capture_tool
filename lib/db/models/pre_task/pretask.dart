import 'package:hive/hive.dart';

part 'pretask.g.dart';

@HiveType(typeId: 0)
class PreTask {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  double importance;

  @HiveField(4)
  DateTime timeStamp;

  @HiveField(5)
  int state;  /// 0 : Deleted, 1 : Capture Tool , 2 : Weekly Return , 3 : Monthly Return

  PreTask({
    required this.id,
    required this.title,
    required this.description,
    required this.importance,
    required this.timeStamp,
    required this.state,
  });
}
