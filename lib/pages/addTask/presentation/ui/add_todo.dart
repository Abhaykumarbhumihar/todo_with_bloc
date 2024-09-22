import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/pages/addTask/presentation/bloc/add_task_bloc.dart';
import '../../../../common/responsive/screenUtils.dart';
import '../../../../common/values/app_color.dart';
import '../component/add_task_component.dart';
import '../component/datepicker_componet.dart';

class AddTodo extends StatelessWidget {
  AddTodo({super.key});

  TextEditingController dueDateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtils.width(context);
    double screenHeight = ScreenUtils.height(context);

    return SafeArea(
      child: BlocListener<AddTaskBloc, AddTaskState>(
        listener: (context, state) {
          print(state);
          if (state.categorySuccessMessage == "Category Added") {
            context.read<AddTaskBloc>().add(GetCategoryEvent());
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.backgroundColor,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              var time = timeController.text.toString();
              var date = dueDateController.text.toString();
              var taskname = taskNameController.text.toString();
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
          ),
          body: SizedBox(
            width: screenWidth,
            height: screenHeight,
            child: SingleChildScrollView(
              // Added this
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
                            taskNameController: taskNameController,
                            screenWidth: screenWidth),
                        SizedBox(height: screenHeight * 0.1),
                        BlocBuilder<AddTaskBloc, AddTaskState>(
                          builder: (context, state) {
                            return dueDate(
                                context: context,
                                screenWidth: screenWidth,
                                screenHeight: screenHeight,
                                dueDateController: dueDateController,
                                timeController: timeController,
                                datepickerclick: () {
                                  _selectDate(context);
                                },
                                timepickerclick: () {
                                  _selectTime(context);
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
      context: context,
      initialDate: DateTime.now(), // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      dueDateController.text=picked.toString();
      print(picked);
    }
  }

  _selectTime(BuildContext context) async {
    var time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if (time != null) {
      timeController.text=("${time.hour}:${time.minute}");
      print("${time.hour}:${time.minute}");
    }
  }
}
