import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/common/extension/common_extension.dart';
import 'package:todoapp/pages/all_list/presentation/bloc/all_list_bloc.dart';

import '../../../../common/responsive/screenUtils.dart';
import '../../../../common/routes/routes.dart';
import '../../../../common/values/app_color.dart';
import '../../../addTask/presentation/bloc/add_task_bloc.dart';
import '../bloc/task_list_bloc.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtils.width(context);
    double screenHeight = ScreenUtils.height(context);
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Flexible(child: BlocBuilder<TaskListBloc, TaskListState>(
        builder: (context, state) {
          return ListView.builder(
              itemCount: state.addTodoTask?.length,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: screenWidth * 0.04,
                        right: screenWidth * 0.04,
                        bottom: screenWidth * 0.06,
                      ),
                      child: Container(
                        width: screenWidth,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: AppColor.backgroundContainerColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 5,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  state.addTodoTask![index].title,
                                  style: TextStyle(
                                    color: AppColor.appTitleTextColor,
                                    fontFamily: 'Poppins SemiBold',
                                    fontSize: screenWidth * 0.04,
                                  ),
                                ),
                                Text(
                                  state.addTodoTask![index].date!
                                      .toFormattedDate(),
                                  style: TextStyle(
                                      color: AppColor.appSubTextColor,
                                      fontFamily: 'Poppins Regular',
                                      fontSize: screenWidth * 0.03),
                                ),
                              ],
                            ),
                            Positioned(
                              right: 0.0,
                              top: -5,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                      tooltip: "Update Task",
                                      onPressed: () {
                                        if (state.addTodoTask![index].time !=
                                            "") {
                                          context
                                                  .read<AddTaskBloc>()
                                                  .timeController
                                                  .text =
                                              state.addTodoTask![index].time;

                                          context
                                              .read<AddTaskBloc>()
                                              .add(TimeAddedEvent(true));
                                        } else {
                                          context
                                              .read<AddTaskBloc>()
                                              .add(TimeAddedEvent(false));
                                        }

                                        if (state.addTodoTask![index].date !=
                                            "") {
                                          context
                                                  .read<AddTaskBloc>()
                                                  .dueDateController
                                                  .text =
                                              state.addTodoTask![index].date;
                                          context
                                              .read<AddTaskBloc>()
                                              .add(DateAddedEvent(true));
                                        } else {
                                          context
                                              .read<AddTaskBloc>()
                                              .add(DateAddedEvent(false));
                                        }

                                        context
                                                .read<AddTaskBloc>()
                                                .taskNameController
                                                .text =
                                            state.addTodoTask![index].title;

                                        context
                                            .read<AddTaskBloc>()
                                            .add(GetCategoryEvent());

                                        Future.delayed(Duration(seconds: 1));

                                        // context.read<AddTaskBloc>().add(
                                        //     SelectCategoryEvent(state
                                        //         .addTodoTask![index].category));

                                        Navigator.pushNamed(
                                            context, AppRoutes.ADD_TASK_LIST,
                                            arguments:
                                                state.addTodoTask![index]);
                                      },
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        FontAwesomeIcons.pencil,
                                        color: Colors.white,
                                        size: screenWidth * 0.04,
                                      )),
                                  IconButton(
                                      tooltip: "Delete Task",
                                      padding: EdgeInsets.zero,
                                      onPressed: () {
                                        context.read<TaskListBloc>().add(
                                            DeleteTaskEvent(
                                                state.addTodoTask![index].id));
                                        context
                                            .read<AllListBloc>()
                                            .add(GetTodoTaskList());
                                      },
                                      icon: Icon(
                                        FontAwesomeIcons.trash,
                                        color: Colors.white,
                                        size: screenWidth * 0.04,
                                      ))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                );
              });
        },
      )),
    );
  }
}
