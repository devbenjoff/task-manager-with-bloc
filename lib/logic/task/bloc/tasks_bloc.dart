import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:task_manager_with_bloc/logic/task/model/task.dart';
import 'package:task_manager_with_bloc/logic/task/repo/task_repo.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TasksRepo _taskRepo;

  StreamSubscription? _taskSubscription;

  TasksBloc(this._taskRepo) : super(const TasksInitial()) {
    on<LoadTasksEvent>(_onTasksLoad);
    on<AddTaskEvent>(_onAddTask);
  }

  Future<void> _onTasksLoad(LoadTasksEvent event, Emitter emit) async {
    try {
      if (state is TasksLoading) {
        return;
      }
      _taskSubscription ??= _taskRepo.getTasksStream().listen(_onTasksUpdated);
      List<Task> tasks = [];

      emit(const TasksLoading());

      tasks = await _taskRepo.getTasks();
      emit(TasksLoaded(tasks));
    } catch (err) {
      emit(const TasksError());
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter emit) async {
    try {
      if (state is AddTaskLoading) {
        return;
      }

      emit(const AddTaskLoading());
      await _taskRepo.addTask(event.task);
      emit(const AddTaskDone());
    } catch (err) {
      emit(const AddTaskError());
    }
  }

  void _onTasksUpdated(List<Task> tasks) {
    add(const LoadTasksEvent());
  }
}
