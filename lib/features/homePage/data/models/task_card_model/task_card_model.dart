import 'package:hive/hive.dart';

part 'task_card_model.g.dart';

@HiveType(typeId: 0)
class TaskCardModel extends HiveObject {
  @HiveField(0)
  late final String title;
  @HiveField(1)
  late final String date;
  @HiveField(2)
  late final int status;
  @HiveField(3)
  late final String key;
  @HiveField(4)
  late final String createTime;
  @HiveField(5)
  late List<String> change = [
    'none',
    'none',
    'none',
    'none',
  ]; // 0:add, 1:edit, 2:status, 3:delete

  TaskCardModel({
    required this.title,
    required this.date,
    required this.status,
    required this.key,
    required this.createTime,
  });

  TaskCardModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    status = json['status'];
    key = json['index'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['date'] = date;
    data['status'] = status;
    data['key'] = key;
    data['createTime'] = createTime;
    return data;
  }

  TaskCardModel copyWith(
      {String? title,
      String? date,
      int? status,
      String? key,
      String? createTime,
      List<String>? change}) {
    var task = TaskCardModel(
      title: title ?? this.title,
      date: date ?? this.date,
      status: status ?? this.status,
      key: key ?? this.key,
      createTime: createTime ?? this.createTime,
    );

    task.change = change ?? this.change;
    return task;
  }
}
