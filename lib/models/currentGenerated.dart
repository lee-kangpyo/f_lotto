import 'package:hive/hive.dart';

part 'currentGenerated.g.dart';
// flutter pub run build_runner build
@HiveType(typeId: 3)
class CurrentGenerated extends HiveObject {
  @HiveField(0)
  late List<int> lottoNumber;

  @HiveField(1)
  late DateTime createDate;
}