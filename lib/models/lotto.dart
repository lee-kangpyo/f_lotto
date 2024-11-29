import 'package:hive/hive.dart';

part 'lotto.g.dart';
// flutter pub run build_runner build
@HiveType(typeId: 1)
class Lotto extends HiveObject {
  @HiveField(0)
  late List<int> lottoNumber;

  @HiveField(1)
  late DateTime createDate;
}