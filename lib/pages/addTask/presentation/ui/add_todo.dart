import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';
import 'package:todoapp/pages/addTask/domain/entities/category.dart';
import 'package:todoapp/pages/addTask/presentation/bloc/add_task_bloc.dart';
import 'package:todoapp/pages/tasklist/presentation/bloc/task_list_bloc.dart';

import '../../../../common/responsive/screenUtils.dart';
import '../../../../common/values/app_color.dart';
import '../../../all_list/presentation/bloc/all_list_bloc.dart';
import '../component/add_task_component.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  bool isForUpdate = false;
  AddTaskModel? addTaskModel;
  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtils.width(context);
    double screenHeight = ScreenUtils.height(context);
    var task = ModalRoute.of(context)?.settings.arguments;
    print(task);
    if (task != null) {
      addTaskModel = ModalRoute.of(context)?.settings.arguments as AddTaskModel;
      isForUpdate = true;
    } else {
      isForUpdate = false;
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<AddTaskBloc>().timeController.clear();
        context.read<AddTaskBloc>().dueDateController.clear();
        context.read<AddTaskBloc>().taskNameController.clear();
        context.read<AddTaskBloc>().state.copyWith(
            isTimeSelected: false, isDateSelected: false, isTimeShow: false);

        return true;
      },
      child: SafeArea(
        child: BlocListener<AddTaskBloc, AddTaskState>(
          listener: (context, state) {
            if (state.categorySuccessMessage == "Category Added") {
              state.categorySuccessMessage = "";
              context.read<AddTaskBloc>().add(GetCategoryEvent());
              context.read<AllListBloc>().add(GetCategoryForFilterEvent());
            } else if (state.categorySuccessMessage == "Task added") {
              state.categorySuccessMessage = "";
              context.read<AllListBloc>().add(GetTodoTaskList());
              Navigator.pop(context);
            } else if (state.categorySuccessMessage == "Task updated") {
              state.categorySuccessMessage = "";
              context.read<TaskListBloc>().add(GetAllTaskListEvent());
              Navigator.pop(context);
            }
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: AppColor.backgroundColor,
            floatingActionButton: BlocBuilder<AddTaskBloc, AddTaskState>(
              builder: (context, state) {
                return FloatingActionButton(
                  onPressed: () {
                    if (context
                        .read<AddTaskBloc>()
                        .taskNameController
                        .text
                        .isNotEmpty) {
                      var time = context
                          .read<AddTaskBloc>()
                          .timeController
                          .text
                          .toString();
                      var date = context
                          .read<AddTaskBloc>()
                          .dueDateController
                          .text
                          .toString();
                      var taskname = context
                          .read<AddTaskBloc>()
                          .taskNameController
                          .text
                          .toString();
                      TaskCategory taskCategory;
                      if (state.selectedCategory == null) {
                        taskCategory = TaskCategory(
                            categoryName: "Default", categoryId: 2);
                      } else {
                        taskCategory = state.selectedCategory!;
                      }
                      if (isForUpdate) {
                        print("CLICK FOR UPDATE TASK ${addTaskModel!.id}");
                        context.read<AddTaskBloc>().add(UpdateTodoTaskEvent(
                            AddTaskModel(
                                id: "${addTaskModel!.id}",
                                name: taskname,
                                title: taskname,
                                time: time ?? "",
                                category: taskCategory,
                                date: date ?? "")));
                      } else {
                        context.read<AddTaskBloc>().add(AddTodoTaskEvent(
                            AddTaskModel(
                                id: DateTime.now()
                                    .millisecondsSinceEpoch
                                    .toString(),
                                name: taskname,
                                title: taskname,
                                time: time ?? "",
                                category: taskCategory,
                                date: date ?? "")));
                      }
                    } else {
                      print("Please enter task name");
                    }
                  },
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  elevation: 6.0,
                  mini: false,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(screenWidth),
                  ),
                  tooltip: 'Add Item',
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                );
              },
            ),
            body: SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    appBarAddTodo(context: context, title: "New Task"),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: screenHeight * 0.03),
                          todoTitle(
                              context: context,
                              taskNameController: context
                                  .read<AddTaskBloc>()
                                  .taskNameController,
                              screenWidth: screenWidth),
                          SizedBox(height: screenHeight * 0.1),
                          BlocBuilder<AddTaskBloc, AddTaskState>(
                            builder: (context, state) {
                              return dueDate(
                                  context: context,
                                  screenWidth: screenWidth,
                                  screenHeight: screenHeight,
                                  dueDateController: context
                                      .read<AddTaskBloc>()
                                      .dueDateController,
                                  timeController: context
                                      .read<AddTaskBloc>()
                                      .timeController,
                                  isDateCrossShow: state.isDateSelected,
                                  isTimeShow: state.isTimeShow,
                                  //ye time ka field hide show krega
                                  isTimeAdded: state.isTimeSelected,
                                  // ye time field me cancel ka field hide show krega
                                  datepickerclick: () {
                                    context
                                        .read<AddTaskBloc>()
                                        .add(DateAddedEvent(true));
                                    _selectDate(context);
                                  },
                                  timepickerclick: () {
                                    context
                                        .read<AddTaskBloc>()
                                        .add(TimeAddedEvent(true));
                                    _selectTime(context);
                                  },
                                  dateClear: () {
                                    context
                                        .read<AddTaskBloc>()
                                        .dueDateController
                                        .clear();
                                    context
                                        .read<AddTaskBloc>()
                                        .add(DateAddedEvent(false));
                                  },
                                  timeClear: () {
                                    context
                                        .read<AddTaskBloc>()
                                        .timeController
                                        .clear();
                                    context
                                        .read<AddTaskBloc>()
                                        .add(TimeAddedEvent(false));
                                  });
                            },
                          ),
                          SizedBox(height: screenHeight * 0.1),
                          BlocBuilder<AddTaskBloc, AddTaskState>(
                            //buildWhen: (previous, current) => false,
                            builder: (context, state) {
                              return addetdToList(
                                context: context,
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                dropdownItems: state.category,
                                selectedCategory: state.selectedCategory,
                                addNewListCLick: () {
                                  _showDialog(context);
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    final TextEditingController textController = TextEditingController();

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('New List'),
          content: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CupertinoTextField(
              controller: textController,
              placeholder: 'Enter List Name',
            ),
          ),
          actions: [
            CupertinoDialogAction(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: Text('Add'),
              onPressed: () {
                final String inputText = textController.text;
                context.read<AddTaskBloc>().add(AddCategoryEvent(inputText));
                print('Added: $inputText');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context, initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000), lastDate: DateTime(2025),
    );
    if (picked != null) {
      context.read<AddTaskBloc>().dueDateController.text = picked.toString();
      print(picked);
    }
  }

  _selectTime(BuildContext context) async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time != null) {
      context.read<AddTaskBloc>().timeController.text =
          ("${time.hour}:${time.minute}");
      print("${time.hour}:${time.minute}");
    }
  }
}
