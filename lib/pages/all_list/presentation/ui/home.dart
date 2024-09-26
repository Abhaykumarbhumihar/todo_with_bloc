import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/common/component/home_component/home_componnt.dart';
import 'package:todoapp/common/responsive/screenUtils.dart';
import 'package:todoapp/common/routes/routes.dart';
import 'package:todoapp/common/values/app_color.dart';
import 'package:todoapp/pages/all_list/presentation/component/all_list_component.dart';

import '../../../addTask/domain/entities/add_task_model.dart';
import '../../../addTask/domain/entities/category.dart';
import '../../../addTask/presentation/bloc/add_task_bloc.dart';
import '../bloc/all_list_bloc.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  TextEditingController taskNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtils.width(context);
    double screenHeight = ScreenUtils.height(context);

    return BlocListener<AllListBloc, AllListState>(
      listener: (context, state) {},
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.backgroundColor,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(ScreenUtils.height(context) * 0.1),
            child: BlocBuilder<AllListBloc, AllListState>(
              builder: (context, state) {
                return appBar(
                    context: context,
                    dropdownItems: state.category,
                    selectedCategory: state.selectedCategory,
                    popmenuclick: (String value) {
                      print(value);
                      switch (value) {
                        case 'Task Lists':
                          print('Task Lists selected');
                          Navigator.pushNamed(context, "/task_list");
                          break;
                        case 'Settings':
                          print('Settings selected');
                          break;
                        case 'Send Feedback':
                          print('Send Feedback selected');
                          break;
                        case 'Follow us':
                          print('Follow us selected');
                          break;
                        case 'Invite friends':
                          print('Invite friends selected');
                          break;
                      }
                    });
              },
            ),
          ),
          body: Container(
            width: screenWidth,
            height: screenHeight,
            child: Stack(
              children: [
                BlocBuilder<AllListBloc, AllListState>(
                  builder: (context, state) {
                    return state.addTodoTask!.isNotEmpty
                        ? SizedBox(
                            width: screenWidth,
                            height: screenHeight,
                            child: taskList(state, screenWidth),
                          )
                        : const SizedBox.shrink();
                  },
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.only(
                        bottom: 10, left: 10, right: 10, top: 10),
                    color: AppColor.appBarColor,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.microphone,
                          color: Colors.white,
                          size: screenWidth * 0.06,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          flex: 1,
                          child: TextField(
                            controller: taskNameController,
                            onChanged: (value) {
                              if (value.isEmpty) {
                                print("EMPTY EMPTY");
                                context
                                    .read<AllListBloc>()
                                    .add(QuickTextChange(true));
                              } else {
                                context
                                    .read<AllListBloc>()
                                    .add(QuickTextChange(false));
                              }
                            },
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: screenWidth * 0.04,
                              fontFamily: "Poppins Medium",
                            ),
                            decoration: customInputDecoration(
                              isDense: true,
                              hintText: "Enter Quick Task Here",
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        BlocBuilder<AllListBloc, AllListState>(
                          builder: (context, state) {
                            print("CHECKING CHECKING CHEKCING ");
                            print(state.isQuickTextEmpty);
                            return AnimatedOpacity(
                              opacity: state.isQuickTextEmpty ? 0.0 : 1.0,
                              duration: Duration(seconds: 2),
                              child: IconButton(
                                  onPressed: () {
                                    if (!state.isQuickTextEmpty) {
                                      /**add task*/
                                      TaskCategory taskCategory = TaskCategory(
                                          categoryName: "Default",
                                          categoryId: 2);
                                      context.read<AddTaskBloc>().add(
                                          AddTodoTaskEvent(AddTaskModel(
                                              name: taskNameController.text
                                                  .toString(),
                                              title: taskNameController.text
                                                  .toString(),
                                              time: "",
                                              category: taskCategory,
                                              date: "")));

                                      /**clear text controller*/
                                      taskNameController.clear();
                                      context
                                          .read<AllListBloc>()
                                          .add(QuickTextChange(true));

                                      /**refresh tasklik*/
                                      context
                                          .read<AllListBloc>()
                                          .add(GetTodoTaskList());
                                    }
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.check,
                                    color: Colors.white,
                                    size: screenWidth * 0.06,
                                  )),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          floatingActionButton: Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.08),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.ADD_TASK_LIST);
              },
              mini: true,
              backgroundColor: Colors.white,
              foregroundColor: Colors.white,
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth),
              ),
              tooltip: 'Add Item',
              child: const Icon(
                Icons.add,
                color: AppColor.backgroundColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
