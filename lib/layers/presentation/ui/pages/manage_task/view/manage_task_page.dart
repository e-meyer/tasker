import 'package:flutter/material.dart';
import 'package:tasker/layers/core/injector/injector.dart';
import 'package:tasker/layers/core/utils/constants.dart';
import 'package:tasker/layers/domain/entities/task_entity.dart';
import 'package:tasker/layers/presentation/controllers/task_controller.dart';

import '../../../widgets/custom_appbar_widget.dart';
import '../components/manage_task_datepicker.dart';
import '../components/manage_task_textfield.dart';

class ManageTaskPage extends StatefulWidget {
  const ManageTaskPage({super.key, this.task});

  final TaskEntity? task;

  @override
  State<ManageTaskPage> createState() => _ManageTaskPageState();
}

class _ManageTaskPageState extends State<ManageTaskPage> {
  final _formKey = GlobalKey<FormState>();
  var dateTime = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();
  final TaskController taskController = serviceLocator.get<TaskController>();

  bool isEditing = false;
  late final String previousTitle;

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      final task = widget.task!;
      previousTitle = task.title;
      titleController.text = task.title;
      descController.text = task.description;
      refresh(task.expirationDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    isEditing = widget.task != null;
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: isEditing ? 'Edit Task' : 'Add Task',
        trailing: null,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.85,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ManageTaskDatepicker(dateTime: dateTime, refresh: refresh),
                  const SizedBox(height: 50),
                  ManageTaskTextfield(
                      labelText: 'Task Title', controller: titleController),
                  const SizedBox(height: 50),
                  ManageTaskTextfield(
                      labelText: 'Description', controller: descController),
                  const SizedBox(height: 90),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kPrimaryColor,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 90),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    onPressed: () {
                      final bool response;
                      if (_formKey.currentState!.validate()) {
                        if (isEditing) {
                          response = taskController.editTask(
                            TaskEntity(
                              title: titleController.text,
                              description: descController.text,
                              expirationDate: dateTime,
                              isDone: widget.task!.isDone,
                            ),
                            previousTitle,
                          );
                        } else {
                          response = taskController.saveTask(
                            TaskEntity(
                              title: titleController.text,
                              description: descController.text,
                              expirationDate: dateTime,
                              isDone: false,
                            ),
                          );
                        }
                        if (!response) {
                          _showAlertDialog(context);
                        } else {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            showSnackBar(),
                          );
                        }
                      }
                    },
                    child: Text(
                      isEditing ? 'Save Task' : 'Create Task',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showSnackBar() {
    return SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Text(
        isEditing ? 'Task saved successfully' : 'Task created successfully',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 16,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: kSecondaryColor,
      margin: const EdgeInsets.all(10),
      elevation: 2,
      behavior: SnackBarBehavior.floating,
    );
  }

  _showAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.only(top: 10.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          title: Text(
            'Task already exists',
            style: TextStyle(
              fontSize: 22,
              color: kSecondaryColor,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text(
                  'The title of the given task already exists. Please choose another title.',
                  style: TextStyle(
                    fontSize: 18,
                    color: kSecondaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: const BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(32.0),
                        bottomRight: Radius.circular(32.0)),
                  ),
                  child: Text(
                    'OK',
                    style: TextStyle(
                      fontSize: 18,
                      color: kMainBackground,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  refresh(DateTime newTime) {
    setState(() {
      dateTime = newTime;
    });
  }
}
