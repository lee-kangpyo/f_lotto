import 'package:hive/hive.dart';

part 'FilterNumbers.g.dart';
// flutter pub run build_runner build
@HiveType(typeId: 2)
class FilterNumbers extends HiveObject {
  @HiveField(0)
  late Map<int, int> filterNumber;
}



