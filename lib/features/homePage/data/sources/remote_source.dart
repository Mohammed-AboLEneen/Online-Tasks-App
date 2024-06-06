import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_app/features/homePage/data/models/task_card_model.dart';

import '../../../../constents.dart';

class HomePageRemoteSource {
  var collection = FirebaseFirestore.instance.collection('users');

  Future<void> addNewTask({required TaskCardModel task}) async {
    Map<String, dynamic> data = task.toJson();

    collection.doc(uId).collection('All').add(data);
    collection.doc(uId).collection('Not Done').add(data);
  }

  Future<List<TaskCardModel>> getData({required String topic}) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot =
        await collection.doc(uId).collection(topic).get();

    // Get data from docs and convert map to List
    List<TaskCardModel> allData = querySnapshot.docs
        .map((doc) => TaskCardModel.fromJson(
              doc.data() as Map<String, dynamic>,
            ))
        .toList();

    print(allData);

    return allData;
  }

  Future<void> deleteTask({required int key, required int status}) async {
    var snapshotAll = await collection
        .doc(uId)
        .collection('All')
        .where('index', isEqualTo: key)
        .get();

    var snapshot = await collection
        .doc(uId)
        .collection(status == 1 ? 'Done' : 'Not Done')
        .where('index', isEqualTo: key)
        .get();

    if (snapshotAll.docs.isNotEmpty) {
      snapshotAll.docs.first.reference.delete();
    }

    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.first.reference.delete();
    }
  }

  Future<void> editTask({required TaskCardModel task}) async {
    var snapshotAll = await collection
        .doc(uId)
        .collection('All')
        .where('index', isEqualTo: task.index)
        .get();
    var snapshot = await collection
        .doc(uId)
        .collection(task.status == 1 ? 'Done' : 'Not Done')
        .where('index', isEqualTo: task.index)
        .get();

    if (snapshotAll.docs.isNotEmpty) {
      snapshotAll.docs.first.reference.update(task.toJson());
    }

    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.first.reference.update(task.toJson());
    }
  }

  Future<void> changeTaskStatus({
    required TaskCardModel task,
  }) async {
    var snapshotAll = await collection
        .doc(uId)
        .collection('All')
        .where('index', isEqualTo: task.index)
        .get();
    var snapshotNotDone = await collection
        .doc(uId)
        .collection('Not Done')
        .where('index', isEqualTo: task.index)
        .get();

    var snapshotDone = await collection
        .doc(uId)
        .collection('Done')
        .where('index', isEqualTo: task.index)
        .get();

    snapshotAll.docs.first.reference.update(task.toJson());

    int newStatus = 0;
    if (task.status == 1) {
      newStatus = 0;
    } else {
      newStatus = 1;
    }

    if (newStatus == 1) {
      collection
          .doc(uId)
          .collection('Done')
          .add(task.copyWith(status: newStatus).toJson());

      if (snapshotNotDone.docs.isNotEmpty) {
        snapshotNotDone.docs.first.reference.delete();
      }
    } else {
      collection
          .doc(uId)
          .collection('Not Done')
          .add(task.copyWith(status: newStatus).toJson());

      if (snapshotDone.docs.isNotEmpty) {
        snapshotDone.docs.first.reference.delete();
      }
    }
  }
}
