import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/pages/tasklist/presentation/bloc/task_list_bloc.dart';
import 'package:todoapp/pages/tasklist/presentation/ui/task_list_data.dart';

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
                const TaskListView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
