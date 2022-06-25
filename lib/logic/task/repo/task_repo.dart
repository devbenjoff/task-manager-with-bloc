import 'package:task_manager_with_bloc/logic/task/model/task.dart';

abstract class TasksRepo {
  Future<List<Task>> getTasks();
  Stream<List<Task>> getTasksStream();
  Future<void> addTask(Task task);
}
