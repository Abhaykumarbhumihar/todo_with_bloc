import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/common/extension/common_extension.dart';
import 'package:todoapp/pages/addTask/domain/entities/add_task_model.dart';
import 'package:todoapp/pages/addTask/domain/entities/category.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../../../pages/all_list/presentation/bloc/all_list_bloc.dart';
import '../../responsive/screenUtils.dart';
import '../../values/app_color.dart';

Widget appBar(
    {BuildContext? context,
    List<TaskCategory>? dropdownItems,
    void Function(String value)? popmenuclick,
    TaskCategory? selectedCategory}) {
  double screenWidth = ScreenUtils.width(context!);
  double containerSize = screenWidth * 0.2 - screenWidth * 0.11;

  return Container(
    width: ScreenUtils.width(context),
    height:
        ScreenUtils.height(context) * 0.1 - ScreenUtils.height(context) * 0.014,
    decoration: BoxDecoration(color: AppColor.appBarColor, boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5), // Shadow color
        spreadRadius: 2, // How much the shadow spreads
        blurRadius: 10, // Blur effect
        offset: const Offset(0, 1), // Shadow position
      )
    ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 10.0),
              width: containerSize,
              height: containerSize,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(containerSize)),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                  child: Image.asset(
                    "assets/images/check.png",
                    color: AppColor.backgroundColor,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: screenWidth * 0.06),
              child: DropdownButton<TaskCategory>(
                padding: EdgeInsets.zero,
                isExpanded: false,
                value: selectedCategory,
                hint: const Text('Select an item'),
                dropdownColor: Colors.blueAccent,
                // Background color of the dropdown
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: screenWidth * 0.1,
                ),
                // Icon for the dropdown
                style: TextStyle(
                    color: Colors.black, fontSize: screenWidth * 0.03),
                // Style for the text
                underline: const SizedBox(),
                alignment: Alignment.centerLeft,
                items: dropdownItems?.map((TaskCategory item) {
                  return DropdownMenuItem<TaskCategory>(
                    value: item,
                    child: Text(
                      item.categoryName,
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins SemiBold',
                          fontSize: screenWidth * 0.04),
                    ),
                  );
                }).toList(),
                onChanged: (TaskCategory? newValue) {
                  if (newValue?.categoryId == 000) {
                    print("Get All List item");
                    BlocProvider.of<AllListBloc>(context!)
                        .add(GetTodoTaskList());
                  } else {
                    BlocProvider.of<AllListBloc>(context!)
                        .add(SelectedCategoryForFilterEvent(newValue));
                  }
                },
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                  size: ScreenUtils.width(context) * 0.1 -
                      ScreenUtils.width(context) * 0.018,
                )),
            PopupMenuButton<String>(
              icon: Icon(
                FontAwesomeIcons.ellipsisVertical,
                color: Colors.white,
                size: ScreenUtils.width(context) * 0.1 -
                    ScreenUtils.width(context) * 0.018,
              ),
              onSelected: popmenuclick,
              itemBuilder: (BuildContext context) {
                return [
                   PopupMenuItem(
                    value: 'Task Lists',
                    child: Text('Task Lists'),
                  ),
                  const PopupMenuItem(
                    value: 'Settings',
                    child: Text('Settings'),
                  ),
                  const PopupMenuItem(
                    value: 'Send Feedback',
                    child: Text('Send Feedback'),
                  ),
                  const PopupMenuItem(
                    value: 'Follow us',
                    child: Text('Follow us'),
                  ),
                  const PopupMenuItem(
                    value: 'Invite friends',
                    child: Text('Invite friends to the app'),
                  ),
                ];
              },
            ),
          ],
        )
      ],
    ),
  );
}

Widget appBarcommono({BuildContext? context, String? title}) {
  double screenWidth = ScreenUtils.width(context!);
  double containerSize = screenWidth * 0.2 - screenWidth * 0.10;

  return Container(
    padding: EdgeInsets.symmetric(horizontal: 14),
    width: ScreenUtils.width(context),
    height:
        ScreenUtils.height(context) * 0.1 - ScreenUtils.height(context) * 0.014,
    decoration: BoxDecoration(color: AppColor.appBarColor, boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5), // Shadow color
        spreadRadius: 2, // How much the shadow spreads
        blurRadius: 10, // Blur effect
        offset: const Offset(0, 1), // Shadow position
      )
    ]),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(
              CupertinoIcons.arrow_left,
              color: Colors.white,
              size: screenWidth * 0.06,
            ),
            SizedBox(
              width: screenWidth * 0.08,
            ),
            Text(title!,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins SemiBold',
                    fontSize: screenWidth * 0.04))
          ],
        ),
        Icon(
          FontAwesomeIcons.outdent,
          color: Colors.white,
          size: screenWidth * 0.06,
        )
      ],
    ),
  );
}

Widget title({BuildContext? context, String? title, double? screenWidth}) {
  return Text(
    "$title",
    style: TextStyle(
      color: AppColor.appSubTextColor,
      fontSize: screenWidth! * 0.04,
      fontFamily: 'Poppins Medium',
    ),
  );
}

Widget taskList(AllListState state, double screenWidth) {
  return GroupedListView<AddTaskModel, String>(
    elements: state.addTodoTask!,
    groupBy: (AddTaskModel task) {
      // Check if task.date is null or empty
      if (task.date == null || task.date.isEmpty) {
        return "No Date"; // Group for tasks without a date
      }
      try {
        // Try parsing the date
        return DateFormat('yyyy-MM-dd').format(DateTime.parse(task.date));
      } catch (e) {
        return "Invalid Date"; // Group for invalid dates
      }
    },
    groupHeaderBuilder: (AddTaskModel task) {
      // Get current date
      DateTime currentDate = DateTime.now();
      DateTime taskDate;

      // Determine the header text
      String headerText;
      if (task.date == null || task.date.isEmpty) {
        headerText = "No Date";
      } else {
        try {
          taskDate = DateTime.parse(task.date);
          // Compare with today and tomorrow
          if (_isSameDay(currentDate, taskDate)) {
            headerText = "Today";
          } else if (_isSameDay(currentDate.add(Duration(days: 1)), taskDate)) {
            headerText = "Tomorrow";
          } else {
            headerText = DateFormat('EEE, MMM d, yyyy').format(taskDate);
          }
        } catch (e) {
          headerText = ""; // Fallback for invalid dates
        }
      }


      return Padding(
        padding: const EdgeInsets.only(left: 18.0, top: 6, bottom: 12),
        child: Text(
          headerText, // Format the date header
          style: TextStyle(
            color: AppColor.appSubTextColor,
            fontSize: screenWidth * 0.04,
            fontFamily: 'Poppins Medium',
          ),
        ),
      );
    },
    itemBuilder: (context, AddTaskModel task) {
      return todoList(context: context, addTaskModel: task);
    },
    order: GroupedListOrder.ASC, // Sort order
  );
}

Widget todoList({BuildContext? context, AddTaskModel? addTaskModel}) {
  double screenWidth = ScreenUtils.width(context!);
  double screenHeight = ScreenUtils.height(context);


  print( addTaskModel!.id+" "+addTaskModel.time+" "+addTaskModel.title);
  return Padding(
    padding: EdgeInsets.only(
      left: screenWidth * 0.04,
      right: screenWidth * 0.04,
      bottom: screenWidth * 0.06,
    ),
    child: Container(
      width: screenWidth,
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 12.0),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.021, right: 4.0),
            child: Checkbox(
              value: true,
              onChanged: (value) {},
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${addTaskModel?.title}",
                style: TextStyle(
                  color: AppColor.appTitleTextColor,
                  fontFamily: 'Poppins SemiBold',
                  fontSize: screenWidth * 0.04,
                ),
              ),
              Text(
                "${addTaskModel!.date!.toFormattedDate()}",
                style: TextStyle(
                  color: AppColor.appSubTextColor,
                  fontFamily: 'Poppins Regular',
                  fontSize: screenWidth * 0.04 - screenWidth * 0.004,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

bool _isSameDay(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
