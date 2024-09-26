import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/pages/tasklist/presentation/bloc/task_list_bloc.dart';

import '../../../../common/component/home_component/home_componnt.dart';
import '../../../../common/responsive/screenUtils.dart';
import '../../../../common/values/app_color.dart';

class TaskList extends StatelessWidget {
  const TaskList({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtils.width(context);
    double screenHeight = ScreenUtils.height(context);
    return BlocListener<TaskListBloc, TaskListState>(
      listener: (context, state) {},
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: AppColor.backgroundColor,
          body: Container(
            width: screenWidth,
            height: screenHeight,
            child: Column(
              children: [
                appBarcommono(context: context, title: "Task Lists"),
                Flexible(child: BlocBuilder<TaskListBloc, TaskListState>(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            "${state.addTodoTask![index].title}",
                                            style: TextStyle(
                                              color: AppColor.appTitleTextColor,
                                              fontFamily: 'Poppins SemiBold',
                                              fontSize: screenWidth * 0.04,
                                            ),
                                          ),
                                          Text(
                                            "Wed, Oct 16, 2024",
                                            style: TextStyle(
                                                color: AppColor.appSubTextColor,
                                                fontFamily: 'Poppins Regular',
                                                fontSize: screenWidth * 0.03),
                                          ),
                                        ],
                                      ),
                                      Positioned(
                                        right: 0.0,
                                        top: screenHeight * 0.019,
                                        child: Row(
                                          children: <Widget>[
                                            Icon(
                                              FontAwesomeIcons.pencil,
                                              color: Colors.white,
                                              size: screenWidth * 0.06,
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Icon(
                                              FontAwesomeIcons.trash,
                                              color: Colors.white,
                                              size: screenWidth * 0.06,
                                            )
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
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
