
import 'package:intl/intl.dart';

getCurDate(){
  var curDay = DateTime.now();
  DateFormat formatDate = DateFormat('MM월dd일');
  DateFormat formatTime = DateFormat('HH:mm');
  var result = {"ymd":formatDate.format(curDay), "time":formatTime.format(curDay), "date":curDay};
  //print(result);
  return result;
}