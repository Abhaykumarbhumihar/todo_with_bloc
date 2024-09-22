import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../responsive/screenUtils.dart';
import '../../values/app_color.dart';

Widget appBar(
    {BuildContext? context,
    List<String>? dropdownItems,
    void Function(String value)? popmenuclick}) {
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
              child: DropdownButton<String>(
                padding: EdgeInsets.zero,
                isExpanded: false,
                value: "Item 1",
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
                items: dropdownItems?.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      "Al Lists",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins SemiBold',
                          fontSize: screenWidth * 0.04),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
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
                  const PopupMenuItem(
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



Widget addetdToList(
    {BuildContext? context,
    double? screenWidth,
    double? screenHeight,
    List<String>? dropdownItems}) {
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
              child: DropdownButton<String>(
                padding: EdgeInsets.zero,
                isExpanded: true,
                value: "Item 1",
                hint: const Text('Select an item'),
                dropdownColor: Colors.blueAccent,
                // Background color of the dropdown
                icon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: screenWidth! * 0.06,
                ),
                // Icon for the dropdown
                style: const TextStyle(color: Colors.black, fontSize: 20),
                // Style for the text
                underline: const SizedBox(),
                alignment: Alignment.centerLeft,
                items: dropdownItems?.map((String item) {
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      "Al Lists",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins Medium',
                          fontSize: screenWidth * 0.04),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {},
              ),
            ),
          ),
          Icon(
            FontAwesomeIcons.outdent,
            color: Colors.white,
            size: screenWidth * 0.07,
          )
        ],
      )
    ],
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

Widget todoLisst({
  BuildContext? context,
}) {
  double screenWidth = ScreenUtils.width(context!);
  double screenHeight = ScreenUtils.height(context);
  return Expanded(
    child: Padding(
      padding: EdgeInsets.only(
        left: screenWidth * 0.04,
        right: screenWidth * 0.04,
        bottom: screenWidth * 0.06,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Tomorrow",
            style: TextStyle(
              color: AppColor.appSubTextColor,
              fontSize: screenWidth * 0.04,
              fontFamily: 'Poppins Medium',
            ),
          ),
          SizedBox(
            height: screenHeight * 0.01 + screenHeight * 0.008,
          ),
          Container(
            width: screenWidth,
            padding: const EdgeInsets.all(12.0),
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
                  padding:
                      EdgeInsets.only(bottom: screenHeight * 0.021, right: 4.0),
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
                      "Flutter animation",
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
                        fontSize: screenWidth * 0.04 - screenWidth * 0.004,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
