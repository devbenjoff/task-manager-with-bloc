import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import 'package:task_manager_with_bloc/logic/task/bloc/tasks_bloc.dart';
import 'package:task_manager_with_bloc/logic/task/model/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _dateFormat = intl.DateFormat('HH:mm');
  final _titleController = TextEditingController();
  final _descriptionControler = TextEditingController();
  final _locationController = TextEditingController();
  DateTime? _selectedStartTime;
  DateTime? _selectedEndTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Container(
              constraints: const BoxConstraints.expand(),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Create Task',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Task title',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          hintText: 'Title',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: _descriptionControler,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15.0))),
                          hintText: 'Description',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _buildDateRow(),
                  _buildButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildDateRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Starts',
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 5,
              ),
              _buildDateContainer(true, _selectedStartTime),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  'Ends',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              _buildDateContainer(false, _selectedEndTime),
            ],
          ),
        ),
      ],
    );
  }

  _buildDateContainer(bool isStart, DateTime? date) {
    return InkWell(
      onTap: () => _showDatePicker(context, isStart),
      child: Padding(
        padding:
            EdgeInsets.only(left: isStart ? 0 : 10, right: isStart ? 10 : 0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: const BorderRadius.all(
              Radius.circular(15.0),
            ),
          ),
          child:
              Center(child: Text(_dateFormat.format(date ?? DateTime.now()))),
        ),
      ),
    );
  }

  _showDatePicker(BuildContext context, bool isStart) {
    showCupertinoModalPopup(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            height: MediaQuery.of(context).copyWith().size.height * 0.25,
            color: Colors.white,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.time,
              onDateTimeChanged: (value) {
                if (isStart) {
                  _selectedStartTime = value;
                  setState(() {});
                }

                _selectedEndTime = value;

                setState(() {});
              },
              initialDateTime: DateTime.now(),
              minimumYear: 2000,
              maximumYear: 3000,
            ),
          );
        });
  }

  Widget _buildButton() {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          InkWell(
            onTap: () {
              var task = Task(
                  title: _titleController.text,
                  description: _descriptionControler.text);
              context.read<TasksBloc>().add(AddTaskEvent(task: task));
            },
            child: Container(
              width: double.infinity,
              height: 50,
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
              child: const Center(
                child: Text(
                  'Create task',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DateFormat {}
