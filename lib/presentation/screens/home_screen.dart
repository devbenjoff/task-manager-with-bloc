import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager_with_bloc/logic/task/bloc/tasks_bloc.dart';
import 'package:task_manager_with_bloc/logic/task/model/task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    BlocProvider.of<TasksBloc>(context).add(const LoadTasksEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Container(
              width: double.infinity,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 164, 165, 167)
                        .withOpacity(0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 90, 92, 94)
                                .withOpacity(0.5),
                            offset: const Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: CircleAvatar(
                        backgroundImage: Image.network(
                                'http://t3.gstatic.com/licensed-image?q=tbn:ANd9GcR1HSu5RipPNVJX2SVVae0MLEHla44BsEnLfEOKedU46818JXoLPjcwG4Vi5grRNykG')
                            .image,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: InkWell(
                      onTap: () => Navigator.of(context).pushNamed('/addTask'),
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          color: const Color(0xff135BFF),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xff135BFF).withOpacity(0.5),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          BlocBuilder<TasksBloc, TasksState>(
            builder: (context, state) {
              if (state is TasksInitial) {
                return const SizedBox();
              }
              if (state is TasksLoading) {
                return const Center(
                  child: Text('Tasks loading'),
                );
              }
              if (state is TasksError) {
                return const Center(
                  child: Text('Error occured while loading tasks'),
                );
              }
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: (state as TasksLoaded).tasks.length,
                  itemBuilder: (context, index) {
                    Task task = state.tasks[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 5),
                      child: Container(
                        height: 150,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xffCFEBFF),
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.black),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              task.description,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromARGB(255, 100, 98, 98)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: const [
                                Icon(
                                  Icons.gps_fixed_outlined,
                                  color: Color.fromARGB(255, 18, 127, 216),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Travnik',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 18, 127, 216)),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  const Divider(
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.lock_clock,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text('08:30')
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      )),
    );
  }
}
