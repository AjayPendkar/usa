import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myrichardson/controller/dashboard/dashboard_controller.dart';
import 'package:myrichardson/utils/common_widgets/drawer_widget.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/dashboard/widget/dashboard_daytext.dart';
import 'package:myrichardson/view/dashboard/widget/discliamer_bottom.dart';
import 'package:myrichardson/view/dashboard/widget/list_of_card.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  @override
  Widget build(BuildContext context) {
    Screen.setScreenSize(context);
    return SafeArea(
      child: Scaffold(
        appBar: TitleAppBar(
            title: AppStrings.my_app_name,
            icon: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () {
                  if (_scaffoldKey.currentState!.isDrawerOpen == false) {
                    _scaffoldKey.currentState!.openDrawer();
                  } else {
                    _scaffoldKey.currentState!.openEndDrawer();
                  }
                })),
        body: GestureDetector(
          onTap: () {
            _scaffoldKey.currentState!.openEndDrawer();
          },
          child: Scaffold(
            backgroundColor: AppColor.backgroundColor,
            key: _scaffoldKey,
            drawer: DrawerWidget(),
            body: GetBuilder<DashboardController>(
              init: DashboardController(),
              builder: (_) => Stack(
                children: [
                  Padding(
                    padding: AppPreference.getBool(AppStrings.notification)
                        ? onlyPadding(
                            top: AppPreference.getBool(AppStrings.notification)
                                ? 70
                                : Screen.screenHeight * 0.09,
                            bottom: 45)
                        : onlyPadding(
                            top: Screen.screenHeight * 0.09, bottom: 50),
                    child: ListOfCards(),
                  ),
                  Align(alignment: Alignment.topCenter, child: DayText()),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: DisclaimerBottom())
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
