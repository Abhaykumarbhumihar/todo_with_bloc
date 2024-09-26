import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../common/component/home_component/home_componnt.dart';
import '../../../../common/responsive/screenUtils.dart';
import '../../../../common/values/app_color.dart';
import '../../domain/entities/category.dart';
import '../bloc/add_task_bloc.dart';

Widget appBarAddTodo({BuildContext? context, String? title}) {
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
            const Icon(
              CupertinoIcons.arrow_left,
              color: Colors.white,
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
      ],
    ),
  );
}

Widget todoTitle({
  BuildContext? context,
  double? screenWidth,
  TextEditingController? taskNameController,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      title(
        context: context!,
        screenWidth: screenWidth!,
        title: "What is to be done?",
      ),
      Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: taskNameController,
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
          Icon(
            FontAwesomeIcons.microphone,
            color: Colors.white,
            size: screenWidth * 0.06,
          ),
        ],
      )
    ],
  );
}

Widget dueDate(
    {BuildContext? context,
    double? screenWidth,
    double? screenHeight,
    TextEditingController? dueDateController,
    TextEditingController? timeController,
    bool isTimeAdded =
        false, // ye time field me cancel ka field hide show krega
    bool isDateCrossShow = false,
    bool isTimeShow = false, //ye time ka field hide show krega
    void Function()? datepickerclick,
    void Function()? timepickerclick,
    void Function()? dateClear,
    void Function()? timeClear}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      title(context: context, screenWidth: screenWidth, title: "Due date"),
      Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: dueDateController,
              enabled: false,
              style: TextStyle(
                color: Colors.white,
                fontSize: screenWidth! * 0.04,
                fontFamily: "Poppins Medium",
              ),
              decoration: customInputDecoration(
                isDense: true,
                hintText: "Date not set",
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: datepickerclick,
              icon: Icon(
                FontAwesomeIcons.calendarDay,
                color: Colors.white,
                size: screenWidth * 0.06,
              )),
          isDateCrossShow
              ? IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: dateClear,
                  icon: Icon(
                    FontAwesomeIcons.circleXmark,
                    color: Colors.white,
                    size: screenWidth * 0.06,
                  ))
              : SizedBox(),
        ],
      ),
      const SizedBox(height: 15),
      isTimeShow
          ? Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: timeController,
                    enabled: false,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: screenWidth! * 0.04,
                      fontFamily: "Poppins Medium",
                    ),
                    decoration: customInputDecoration(
                      isDense: true,
                      hintText: "Time not set (all day)",
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                IconButton(
                    onPressed: timepickerclick,
                    icon: Icon(
                      FontAwesomeIcons.clock,
                      color: Colors.white,
                      size: screenWidth * 0.06,
                    )),
                isTimeAdded
                    ? IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: timeClear,
                        icon: Icon(
                          FontAwesomeIcons.circleXmark,
                          color: Colors.white,
                          size: screenWidth * 0.06,
                        ))
                    : SizedBox.shrink()
              ],
            )
          : SizedBox.shrink(),
    ],
  );
}

Widget addetdToList(
    {BuildContext? context,
    double? screenWidth,
    double? screenHeight,
    List<TaskCategory>? dropdownItems,
    TaskCategory? selectedCategory,
    void Function()? addNewListCLick}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      title(context: context, screenWidth: screenWidth, title: "Add to List"),
      Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(right: screenWidth! * 0.08),
              child: DropdownButton<TaskCategory>(
                padding: EdgeInsets.zero,
                isExpanded: true,
                value: selectedCategory,
                hint: const Text('Select an item'),
                dropdownColor: Colors.blueAccent,
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: screenWidth! * 0.06,
                ),
                style: const TextStyle(color: Colors.black, fontSize: 20),
                underline: const SizedBox(),
                alignment: Alignment.centerLeft,
                items: dropdownItems?.map((TaskCategory item) {
                  return DropdownMenuItem<TaskCategory>(
                    value: item,
                    child: Text(
                      item.categoryName,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins Medium',
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (TaskCategory? newValue) {
                  if (newValue != null) {
                    print('Selected category: ${newValue.categoryName}');
                    BlocProvider.of<AddTaskBloc>(context!)
                        .add(SelectCategoryEvent(newValue));
                  }
                },
              ),
            ),
          ),
          IconButton(
              onPressed: addNewListCLick,
              icon: Icon(
                FontAwesomeIcons.outdent,
                color: Colors.white,
                size: screenWidth * 0.07,
              ))
        ],
      )
    ],
  );
}

InputDecoration customInputDecoration({
  required String hintText,
  Color hintTextColor = Colors.white38,
  Color enabledBorderColor = Colors.cyan,
  Color focusedBorderColor = Colors.cyan,
  double enabledBorderWidth = 1.0,
  double focusedBorderWidth = 2.0,
  EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(vertical: 5),
  bool isDense = true,
  double fontSize = 14.0,
}) {
  return InputDecoration(
    isDense: isDense,
    hintText: hintText,
    hintStyle: TextStyle(
      color: hintTextColor,
      fontSize: fontSize,
      fontFamily: "Poppins Medium",
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide:
          BorderSide(color: enabledBorderColor, width: enabledBorderWidth),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide:
          BorderSide(color: focusedBorderColor, width: focusedBorderWidth),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: enabledBorderColor),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide:
          BorderSide(color: enabledBorderColor, width: enabledBorderWidth),
    ),
    contentPadding: contentPadding,
  );
}
