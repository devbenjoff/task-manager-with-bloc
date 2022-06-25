import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_manager_with_bloc/logic/task/model/task.dart';
import 'package:task_manager_with_bloc/logic/task/repo/task_repo.dart';

class TasksFirebaseRepo implements TasksRepo {
  final _collection = FirebaseFirestore.instance.collection('tasks');

  @override
  Future<List<Task>> getTasks() async {
    var snapshot = await _collection.get();

    return snapshot.docs.map((e) => Task.fromDoc(e)).toList();
  }

  @override
  Stream<List<Task>> getTasksStream() async* {
    var snapshot = _collection.snapshots();

    yield* snapshot
        .map((event) => event.docs.map((e) => Task.fromDoc(e)).toList());
  }

  @override
  Future<void> addTask(Task task) async {
    await _collection.doc().set(task.toJson());
  }
}
