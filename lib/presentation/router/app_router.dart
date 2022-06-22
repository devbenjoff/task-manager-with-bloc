import 'package:flutter/material.dart';
import 'package:task_manager_with_bloc/presentation/screens/add_task_screen.dart';
import 'package:task_manager_with_bloc/presentation/screens/home_screen.dart';

class AppRouter {
  Route<dynamic>? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/addTask':
        return MaterialPageRoute(builder: (_) => const AddTaskScreen());

      default:
        return null;
    }
  }
}
