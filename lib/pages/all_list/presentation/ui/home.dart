import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/common/component/home_component/home_componnt.dart';
import 'package:todoapp/common/responsive/screenUtils.dart';
import 'package:todoapp/common/routes/routes.dart';
import 'package:todoapp/common/values/app_color.dart';

import '../bloc/all_list_bloc.dart';
class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = ScreenUtils.width(context);
    double screenHeight = ScreenUtils.height(context);

    return BlocConsumer<AllListBloc, AllListState>(
      listener: (context, state) {

        if (state.errorMessage!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage??"")),
          );
        }
        if (state.successMessage!.isNotEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.successMessage??"")),
          );
        }
      },
      builder: (context, state) {

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
                      const SizedBox(height: 15),
                      ListView.builder(
                        itemCount: state.addTodoTask!.length,
                        itemBuilder: (context, index) {
                          return todoLisst(
                            context: context,
                            addTaskModel: state.addTodoTask![index],
                          );
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.only(
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
                                  borderSide: BorderSide(
                                      color: Colors.cyan, width: 1),
                                ),
                                disabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white30, width: 1),
                                ),
                                focusedBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.cyan, width: 2),
                                ),
                                border: const UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.cyan),
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 5), // Adjust padding
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
        );
      },
    );
  }
}