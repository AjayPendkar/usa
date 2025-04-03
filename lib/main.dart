import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myrichardson/utils/loader.dart';
import 'package:myrichardson/routes/app_page.dart';
import 'package:myrichardson/routes/app_routes.dart';
import 'package:myrichardson/utils/library.dart';
import 'package:myrichardson/utils/shared_preference/shared_preference.dart';
import 'package:myrichardson/view/agreement/agreement_screen.dart';
import 'package:myrichardson/view/dashboard/dashboard_screen.dart';

import 'model/notification_model.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

bool isItFirstTimeToCallDashboardDayData = true;

NotificationModel? notificationModelWarningMessage;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPreference.init();
  bool agreement = AppPreference.getBool(AppStrings.agreement);
  initializeDateFormatting('pt_BR', null);

  isItFirstTimeToCallDashboardDayData = true;

  AppPreference.set(AppStrings.notification, false);

  runApp(Loading(
    child: GetMaterialApp(
        navigatorKey: navigatorKey,
        getPages: AppPage.pages,
        initialRoute: agreement ? Routes.DashboardScreen : Routes.Agreement,
        debugShowCheckedModeBanner: false,
        home: agreement ? DashboardScreen() : Agreement()),
  ));
}
