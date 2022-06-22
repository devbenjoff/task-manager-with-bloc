import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_with_bloc/firebase_options.dart';
import 'package:task_manager_with_bloc/logic/task/bloc/tasks_bloc.dart';
import 'package:task_manager_with_bloc/logic/task/repo/task_firebase_repo.dart';
import 'package:task_manager_with_bloc/logic/task/repo/task_repo.dart';
import 'package:task_manager_with_bloc/presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<TasksRepo>(
          create: (context) => TasksFirebaseRepo(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TasksBloc>(
            create: (context) =>
                TasksBloc(RepositoryProvider.of<TasksRepo>(context)),
          )
        ],
        child: MaterialApp(
          title: 'Task Manager',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          onGenerateRoute: _appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
