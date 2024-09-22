import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/common/component/home_component/home_componnt.dart';
import 'package:todoapp/common/responsive/screenUtils.dart';
import 'package:todoapp/common/routes/routes.dart';
import 'package:todoapp/common/values/app_color.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final List<String> _dropdownItems = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Finished'
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtils.width(context);
    double screenHeight = ScreenUtils.height(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: AppColor.backgroundColor,
        body: Container(
          width: screenWidth,
          height: screenHeight,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  appBar(
                      context: context,
                      dropdownItems: _dropdownItems,
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
                      }),
                  const SizedBox(height: 15),
                  todoLisst(context: context)
                ],
              ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child:   Container(

                  padding: EdgeInsets.only(bottom: 10,left: 10,right: 10,top: 10),
                  color: AppColor.appBarColor,
                  child: Row(
                                children: <Widget>[
                   Icon(FontAwesomeIcons.microphone,
                      color: Colors.white,
                    size: screenWidth * 0.06,),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                        fontFamily: "Poppins Medium",
                      ),
                      decoration: InputDecoration(
                        isDense: true,
                        hintText: "Enter Quick Task Here",
                        hintStyle: TextStyle(
                          color: Colors.white38,
                          fontSize: screenWidth * 0.04,
                          fontFamily: "Poppins Medium",
                        ),

                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan, width: 1),
                        ),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white30, width: 1),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan, width: 2),
                        ),

                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.cyan),
                        ),
                        // Optional: remove border
                        contentPadding:
                        const EdgeInsets.symmetric(vertical: 5), // Adjust padding
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                   Icon(FontAwesomeIcons.microphone,
                       color: Colors.white,
                     size: screenWidth * 0.06,),
                                ],
                              ),
                ))
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(bottom: screenHeight*0.08
            ),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.ADD_TASK_LIST);
            },
            mini:true,
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
    );
  }
}
