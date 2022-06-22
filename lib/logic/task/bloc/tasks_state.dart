part of 'tasks_bloc.dart';

@immutable
abstract class TasksState {
  const TasksState();
}

class TasksInitial extends TasksState {
  const TasksInitial();
}

class TasksLoading extends TasksState {
  const TasksLoading();
}

class TasksLoaded extends TasksState {
  final List<Task> tasks;

  const TasksLoaded(this.tasks);
}

class TasksError extends TasksState {
  const TasksError();
}
