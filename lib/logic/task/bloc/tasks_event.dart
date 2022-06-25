part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {
  const TasksEvent();
}

class LoadTasksEvent extends TasksEvent {
  const LoadTasksEvent();
}

class AddTaskEvent extends TasksEvent {
  final Task task;
  const AddTaskEvent({required this.task});
}
