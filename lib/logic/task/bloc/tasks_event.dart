part of 'tasks_bloc.dart';

@immutable
abstract class TasksEvent {
  const TasksEvent();
}

class LoadTasksEvent extends TasksEvent {
  const LoadTasksEvent();
}
