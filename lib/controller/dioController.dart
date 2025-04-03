import 'package:dio/dio.dart';

typedef ApiClientCallback = void Function(int value);

String contactEndPoint =
    "/ps/admin.nsf/api/data/collections/name/MyRichardsonContacts?count=200";
String waterEndPoint =
    "/ps/admin.nsf/api/data/collections/name/ActiveWateringDay";
String trashEndPoint = "/ps/admin.nsf/activeTrashDay";
String recycleEndPoint = "/ps/admin.nsf/activeRecyclingDay";
String issueTypeEndPoint =
    "/ps/admin.nsf/api/data/collections/name/myRichardsonLookupIssueTypes?sortorder=ascending&sortcolumn=issueType&count=200";

// String addressEndPoint="/nip/land.nsf/api/data/collections/name/AddressLookup?count=100&sortorder=ascending&sortcolumn=FullStreetAddress&search=";
String addressEndPoint =
    "/nip/land.nsf/api/data/collections/name/AddressLookup?count=100&search=";

String notificationEndPoint =
    "/ps/admin.nsf/api/data/collections/name/ActiveNotifications";
String holidayEndPoint =
    "/ps/admin.nsf/api/data/collections/name/RecyclingHolidays?count=200";
String dayEndPoint = "/ps/babic.nsf/getDayInfo?";

// testing urls
String myIssueEndPoint = "/TEST/issues.nsf/MyRichardsonGetIssuesByProfile?";
String issueSubmitEndPoint =
    "/test/BABIC.nsf/api/data/documents?form=ReportIssueMobile&computewithform=true";
String babricEndPoint = "/TEST/BABIC.nsf/MyRichardsonOrderBABICTEST";

//prod url
// String myIssueEndPoint = "/PS/issues.nsf/MyRichardsonGetIssuesByProfile?";
// String issueSubmitEndPoint =
//     "/PS/BABIC.nsf/api/data/documents?form=ReportIssueMobile&computewithform=true";
// String babricEndPoint = "/PS/BABIC.nsf/MyRichardsonOrderBABIC?OpenAgent";

//  "/test/myrichardson.nsf/getDayInfo?";

//https://discovery.cor.gov/public/TEST/issues.nsf/MyRichardsonGetIssuesByProfile?OpenAgent&keys=Johnathan:john@gmail
class DioApiClient {
  static const Duration timeoutDuration = Duration(seconds: 60000);

  Dio? dio;

  DioApiClient() {
    var logger = LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: false);

    final baseUrl = "https://discovery.cor.gov/public";

    var unAuthOptions = BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: timeoutDuration,
        receiveTimeout: timeoutDuration,
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Charset': 'utf-8'
        });

    dio = Dio(unAuthOptions);
    dio!.interceptors.add(logger);
  }
  static const baseUrlSearchMap =
      "https://maps.cor.gov/arcgis/rest/services/CompositeRichardson/GeocodeServer/findAddressCandidates";
  static const baseUrlPlaceMap =
      "https://maps.cor.gov/arcgis/rest/services/CompositeRichardson/GeocodeServer/reverseGeocode";
}
