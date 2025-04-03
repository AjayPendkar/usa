import 'package:intl/intl.dart';
import 'package:myrichardson/utils/library.dart';

cstToNormalDateConvert({datePass}) {
  DateFormat dateFormatCST = DateFormat('MM/dd/yyyy hh:mm:ss aaa \'CST\'');
  DateFormat dateFormatCDT = DateFormat('MM/dd/yyyy hh:mm:ss aaa \'CDT\'');
  DateFormat dateFormat = dateFormatCST;
  if (datePass != null && datePass.contains("CDT")) {
    dateFormat = dateFormatCDT;
  }

  DateTime date = dateFormat.parse(datePass, true).toUtc();
  String myIssueDate = DateFormat('MM/dd/yyyy').format(
    DateTime.parse(date.toString()),
  );
  return myIssueDate;
}

formatDate({datePass}) {
  String date =
      DateFormat(AppStrings.dateFormatRecycle).format(DateTime.parse(datePass));
  return date;
}
