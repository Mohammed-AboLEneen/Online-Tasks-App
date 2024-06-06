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
  late final int index;
  @HiveField(4)
  late final String createTime;

  TaskCardModel({
    required this.title,
    required this.date,
    required this.status,
    required this.index,
    required this.createTime,
  });

  TaskCardModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    date = json['date'];
    status = json['status'];
    index = json['index'];
    createTime = json['createTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = this.title;
    data['date'] = this.date;
    data['status'] = this.status;
    data['index'] = this.index;
    data['createTime'] = this.createTime;
    return data;
  }

  TaskCardModel copyWith({
    String? title,
    String? date,
    int? status,
    int? index,
    String? createTime,
  }) {
    return TaskCardModel(
      title: title ?? this.title,
      date: date ?? this.date,
      status: status ?? this.status,
      index: index ?? this.index,
      createTime: createTime ?? this.createTime,
    );
  }
}
