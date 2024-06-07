import 'package:firedart/firedart.dart';
import 'package:hive/hive.dart';
import 'package:todo_list_app/features/homePage/data/models/task_card_model/task_card_model.dart';

import '../../../../constents.dart';
import '../../../../cores/methods/check_internet_status.dart';

class HomePageRemoteSource {
  var collection = Firestore.instance.collection('users');

  Future<void> addNewTask({required TaskCardModel task}) async {
    bool statusOfInternet = await checkInternetStatus();

    if (statusOfInternet == false) {
      Box box1 = Hive.box<TaskCardModel>('changes');
      var changedTask = task.copyWith();
      changedTask.change[0] = 'add';
      await box1.put(task.key, changedTask);

      box1.values.toList().forEach((element) {
        print('key: ${element.title}, change: ${element.change}');
      });
      return;
    }

    Map<String, dynamic> data = task.toJson();

    collection.document(uId).collection('All').add(data);
    collection.document(uId).collection('Not Done').add(data);
  }

  Future<List<TaskCardModel>> getData() async {
    print(uId);
    // Get docs from collection reference
    Page<Document> querySnapshot =
        await collection.document(uId).collection('All').get();

    // Get data from docs and convert map to List
    List<TaskCardModel> allData = querySnapshot.isEmpty
        ? []
        : querySnapshot
            .map((doc) => TaskCardModel.fromJson(
                  doc.map,
                ))
            .toList();

    Box box1 = Hive.box<TaskCardModel>('All');
    for (TaskCardModel task in allData) {
      box1.put(task.key, task);
    }

    Page<Document> querySnapshot2 =
        await collection.document(uId).collection('Done').get();

    List<TaskCardModel> doneData = querySnapshot2.isEmpty
        ? []
        : querySnapshot2
            .map((doc) => TaskCardModel.fromJson(
                  doc.map,
                ))
            .toList();

    // Get data from docs and convert map to List
    Box box2 = Hive.box<TaskCardModel>('Done');
    for (TaskCardModel task in doneData) {
      box2.put(task.key, task);
    }

    Page<Document> querySnapshot3 =
        await collection.document(uId).collection('Not Done').get();

    // Get data from docs and convert map to List
    List<TaskCardModel> notDoneData = querySnapshot3.isEmpty
        ? []
        : querySnapshot3
            .map((doc) => TaskCardModel.fromJson(
                  doc.map,
                ))
            .toList();

    Box box3 = Hive.box<TaskCardModel>('Not Done');
    for (TaskCardModel task in notDoneData) {
      box3.put(task.key, task);
    }

    return allData;
  }

  Future<void> deleteTask({required TaskCardModel task}) async {
    bool statusOfInternet = await checkInternetStatus();
    if (statusOfInternet == false) {
      Box box1 = Hive.box<TaskCardModel>('changes');

      if (box1.containsKey(task.key)) {
        var changedTask = box1.get(task.key);
        changedTask.change?[3] = 'delete';

        changedTask = changedTask.copyWith(
            change: changedTask.change,
            createTime: task.createTime,
            title: task.title,
            date: task.date,
            status: task.status);

        print('key: ${changedTask.key} change: ${changedTask.change}');
        await box1.put(
            task.key, changedTask.copyWith(change: changedTask.change));
      } else {
        task.change[3] = 'delete';
        await box1.put(task.key, task.copyWith());
      }
      box1.values.toList().forEach((element) {
        print('key: ${element.title}, change: ${element.change}');
      });
      return;
    }

    var snapshotAll = await collection
        .document(uId)
        .collection('All')
        .where('key', isEqualTo: task.key)
        .limit(1)
        .get();

    var snapshot = await collection
        .document(uId)
        .collection(task.status == 1 ? 'Done' : 'Not Done')
        .where('key', isEqualTo: task.key)
        .limit(1)
        .get();

    if (snapshotAll.isNotEmpty) {
      collection
          .document(uId)
          .collection('All')
          .document(snapshot[0].id)
          .delete();
    }

    if (snapshot.isNotEmpty) {
      collection
          .document(uId)
          .collection(task.status == 1 ? 'Done' : 'Not Done')
          .document(snapshot[0].id)
          .delete();
    }
  }

  Future<void> editTask({required TaskCardModel task}) async {
    bool statusOfInternet = await checkInternetStatus();
    if (statusOfInternet == false) {
      Box box1 = Hive.box<TaskCardModel>('changes');

      // print('task: ${t.title}, key: ${t.key} change: ${t.change}');
      if (box1.containsKey(task.key)) {
        var changedTask = box1.get(task.key);
        changedTask.change?[1] = 'edit';
        changedTask = changedTask.copyWith(
            change: changedTask.change,
            createTime: task.createTime,
            title: task.title,
            date: task.date,
            status: task.status);

        print('key: ${changedTask.key} change: ${changedTask.change}');
        await box1.put(
            task.key, changedTask.copyWith(change: changedTask.change));
      } else {
        var changedTask = task.copyWith();
        changedTask.change[1] = 'edit';
        await box1.put(task.key, changedTask);
      }

      box1.values.toList().forEach((element) {
        print('key: ${element.title}, change: ${element.change}');
      });
      return;
    }

    var snapshotAll = await collection
        .document(uId)
        .collection('All')
        .where('key', isEqualTo: task.key)
        .get();
    var snapshot = await collection
        .document(uId)
        .collection(task.status == 1 ? 'Done' : 'Not Done')
        .where('key', isEqualTo: task.key)
        .get();

    if (snapshotAll.isNotEmpty) {
      collection
          .document(uId)
          .collection('All')
          .document(snapshotAll[0].id)
          .update(task.toJson());
    }

    if (snapshot.isNotEmpty) {
      collection
          .document(uId)
          .collection(task.status == 1 ? 'Done' : 'Not Done')
          .document(snapshot[0].id)
          .update(task.toJson());
    }
  }

  Future<void> changeTaskStatus({
    required TaskCardModel task,
  }) async {
    // this condition will be applied only if there is task status is already in the box and converted.
    int newStatus = task.status;
    if (task.change[2] != 'status') {
      if (task.status == 1) {
        newStatus = 0;
      } else {
        newStatus = 1;
      }
    }
    bool statusOfInternet = await checkInternetStatus();
    if (statusOfInternet == false) {
      Box box1 = Hive.box<TaskCardModel>('changes');

      if (box1.containsKey(task.key)) {
        TaskCardModel changedTask = box1.get(task.key);
        changedTask.change[2] = 'status';

        changedTask = changedTask.copyWith(
            change: changedTask.change,
            createTime: task.createTime,
            title: task.title,
            date: task.date,
            status: newStatus);

        print('key: ${changedTask.key} change: ${changedTask.change}');
        await box1.put(
            task.key, changedTask.copyWith(change: changedTask.change));
      } else {
        var changedTask = task.copyWith();
        changedTask.change[2] = 'status';

        changedTask = changedTask.copyWith(
            change: changedTask.change,
            createTime: task.createTime,
            title: task.title,
            date: task.date,
            status: newStatus);
        await box1.put(task.key, changedTask);
      }
      box1.values.toList().forEach((element) {
        print('key: ${element.title}, change: ${element.change}');
      });
      return;
    }

    var snapshotAll = await collection
        .document(uId)
        .collection('All')
        .where('key', isEqualTo: task.key)
        .limit(1)
        .get();

    var snapshotNotDone = await collection
        .document(uId)
        .collection('Not Done')
        .where('key', isEqualTo: task.key)
        .limit(1)
        .get();

    var snapshotDone = await collection
        .document(uId)
        .collection('Done')
        .where('key', isEqualTo: task.key)
        .limit(1)
        .get();

    collection
        .document(uId)
        .collection('All')
        .document(snapshotAll[0].id)
        .update(task.copyWith(status: newStatus).toJson());

    print('newStatus: ${newStatus}');
    if (newStatus == 1) {
      if (snapshotDone.isEmpty) {
        collection
            .document(uId)
            .collection('Done')
            .add(task.copyWith(status: newStatus).toJson());
      }

      if (snapshotNotDone.isNotEmpty) {
        collection
            .document(uId)
            .collection('Not Done')
            .document(snapshotNotDone[0].id)
            .delete();
      }
    } else {
      if (snapshotNotDone.isEmpty) {
        collection
            .document(uId)
            .collection('Not Done')
            .add(task.copyWith(status: newStatus).toJson());
      }

      if (snapshotDone.isNotEmpty) {
        collection
            .document(uId)
            .collection('Done')
            .document(snapshotDone[0].id)
            .delete();
      }
    }
  }
}
