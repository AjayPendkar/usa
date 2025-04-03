import 'package:get/get.dart';
import 'package:myrichardson/view/agreement/agreement_screen.dart';
import 'package:myrichardson/view/babric_request/babric_address.dart';
import 'package:myrichardson/view/babric_request/bbic_request_screen.dart';
import 'package:myrichardson/view/babric_request/request_acceptable.dart';
import 'package:myrichardson/view/contact_us/contact_us_details.dart';
import 'package:myrichardson/view/contact_us/contect_us_screen.dart';
import 'package:myrichardson/view/dashboard/dashboard_screen.dart';
import 'package:myrichardson/view/event/event_screen.dart';
import 'package:myrichardson/view/event/thingsToDo/thingsToDo.dart';
import 'package:myrichardson/view/my_issue/my_issue_screen.dart';
import 'package:myrichardson/view/new_issue/new_issue_screen.dart';
import 'package:myrichardson/view/new_issue/new_issue_submitted.dart';
import 'package:myrichardson/view/news/news_screen.dart';
import 'package:myrichardson/view/profile/user_profile.dart';
import 'package:myrichardson/view/recycle_day/recycleday_screen.dart';
import 'package:myrichardson/view/trash/trash_day_screen.dart';
import 'package:myrichardson/view/water/water_screen.dart';

import 'app_routes.dart';

class AppPage {
  static final pages = [
    GetPage(name: Routes.DashboardScreen, page: () => DashboardScreen()),
    GetPage(name: Routes.NewIssueScreen, page: () => NewIssueScreen()),
    GetPage(name: Routes.WaterScreen, page: () => WaterScreen()),
    GetPage(name: Routes.TrashScreen, page: () => TrashScreen()),
    GetPage(name: Routes.MyIssueScreen, page: () => MyIssueScreen()),
    GetPage(name: Routes.BBICCollection, page: () => BABICRequestScreen()),
    GetPage(name: Routes.UserProfile, page: () => UserProfile()),
    GetPage(name: Routes.ContactUsDetails, page: () => ContactDetails()),
    GetPage(name: Routes.RecycleDayScreen, page: () => RecycleDayScreen()),
    GetPage(name: Routes.ContactScreen, page: () => ContactScreen()),
    GetPage(name: Routes.PrivacyScreen, page: () => NewsScreen()),
    GetPage(name: Routes.Agreement, page: () => Agreement()),
    GetPage(name: Routes.EventScreen, page: () => EventScreen()),
    GetPage(name: Routes.ThingsToDoScreen, page: () => ThingsToDoScreen()),
    GetPage(
        name: Routes.SearchAddressBabric, page: () => SearchAddressBabric()),
    GetPage(name: Routes.RequestAcceptable, page: () => RequestAcceptable()),
    GetPage(name: Routes.IssueSubmitted, page: () => IssueSubmitted()),
  ];
}
