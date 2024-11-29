import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lotto/models/FilterNumbers.dart';
import 'package:lotto/models/currentGenerated.dart';
import 'package:lotto/provider/count_provider.dart';
import 'package:lotto/screens/RecentCreated.dart';
import 'package:lotto/util/color.dart';
import 'package:lotto/util/date.dart';
import 'package:lotto/util/lotto.dart';
import 'package:lotto/util/modal_util.dart';
import 'package:lotto/widgets/GenerateLotto/AddRemoveModalWidget.dart';
import 'package:lotto/widgets/GenerateLotto/LottoContainer.dart';
import 'package:lotto/widgets/common/CardContainer.dart';
import 'package:provider/provider.dart';
import 'package:collection/collection.dart';

/// 스크린
class GenerateLotto extends StatefulWidget {
  const GenerateLotto({super.key});

  @override
  State<GenerateLotto> createState() => _GenerateLottoState();
}



class _GenerateLottoState extends State<GenerateLotto> {
  List<List<int>?> lottoNumbers = [];
  List<Map<String, dynamic>?> generateTime = [];
  bool isActive = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var updateNumberMap = Provider.of<CountProvider>(context, listen: false).updateNumberMap;
    final filterBox = Hive.box<FilterNumbers>('filterNumbers');
    final filter = filterBox.get('filterNumbers');
    if(filter != null) updateNumberMap(filter.filterNumber);
  }

  @override
  Widget build(BuildContext context) {
    var cp = Provider.of<CountProvider>(context);

    writeHistory (number, date) async {
      const _maxSize = 20;
      var _box = Hive.box<CurrentGenerated>('currentGenerated');
      if (_box.length >= _maxSize) {
        _box.deleteAt(0); // 가장 오래된 값 삭제
      }
      _box.add(CurrentGenerated()..lottoNumber=number..createDate=date); // 새로운 값 추가
    }

    void generateOne() {
      var curDay = getCurDate();
      bool roop = true;
      while(roop){
        List<int> numbers = getNumbers(cp.numberMap);
        bool isDuplicated = lottoNumbers.any((number) => DeepCollectionEquality().equals(number, numbers));
        // print(isDuplicated);
        if(!isDuplicated){
          roop = false;
          writeHistory(numbers, curDay["date"]);
          setState(() {
            lottoNumbers.add(numbers);
            generateTime.add(curDay);
          });
        }
      }
    }

    // 생성하기 버튼 클릭 이벤트
    void clkAction(int generateNumber) async {
      setState(() {
        lottoNumbers = [];
        generateTime = [];
        isActive = true;
      });

      for (int i = 0; i < generateNumber; i++) {
        if (isActive) {
          generateOne();
          await Future.delayed(const Duration(milliseconds: 500));
        } else {
          break;
        }
      }
      setState(() {
        isActive = false;
      });
    }



    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              LottoContainer(
                  lottoNumbers: lottoNumbers!,
                  generateDate: generateTime!,
                  generateOne: generateOne),
              const Settings(),
              BottomBtn(isActive: isActive, clkAction: clkAction)
            ],
          ),
        ),
      ),
    );
  }
}

/// 셋팅 위젯들
class Settings extends StatelessWidget {
  const Settings({super.key});

  void openModal(context) {
    showCustomModal(
      barrierDismissible: false,
      context: context,
      child: const AddRemoveModalWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.bold);
    const Color backColor = AppColors.backColor;
    return Column(
      children: [
        const CardContainer(
          padding: 16,
          backgroundColor: backColor,
          borderColor: backColor,
          child: SetGenCnt(),
        ),
        Row(
          children: [
            Expanded(
              child: CardContainer(
                onTap: () {
                  openModal(context);
                },
                padding: 24,
                backgroundColor: backColor,
                borderColor: backColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("고정수 / 제외수", style: textStyle),
                  ],
                ),
              ),
            ),
            Expanded(
              child: CardContainer(
                onTap: ()=> Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecentCreated()),
                ),
                padding: 24,
                backgroundColor: backColor,
                borderColor: backColor,
                child: Text("최근 생성 번호", style: textStyle),
              ),
            ),
          ],
        ),
      ],
    );
  }
}


/// 생성 횟수 변경하는
class SetGenCnt extends StatefulWidget {
  const SetGenCnt({
    super.key,
  });

  @override
  State<SetGenCnt> createState() => _SetGenCntState();
}

class _SetGenCntState extends State<SetGenCnt> {
  List<int> dropDownList = List.generate(10, (index) => index + 1);
  int selectVal = 5;

  @override
  Widget build(BuildContext context) {
    var cp = Provider.of<CountProvider>(context);
    final textStyle = Theme.of(context)
        .textTheme
        .titleMedium!
        .copyWith(fontWeight: FontWeight.bold);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text("생성 횟수", style: textStyle),
        ),
        DropdownButton(
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          style: Theme.of(context).textTheme.titleMedium,
          onChanged: (v) {
            setState(() {
              cp.setCount(v!);
            });
          },
          value: cp.count,
          items: dropDownList
              .map((num) => DropdownMenuItem(
                    value: num,
                    child: Text("$num 회"),
                  ))
              .toList(),
        )
      ],
    );
  }
}

/// 생성하기 버튼
class BottomBtn extends StatelessWidget {
  const BottomBtn({super.key, required this.isActive, required this.clkAction});
  final bool isActive;
  final Function clkAction;

  void clkBtn(count) => clkAction(count);

  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
        ElevatedButton.styleFrom(backgroundColor: const Color(0x80F80A03));
    var count = Provider.of<CountProvider>(context).count;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: (isActive)
            ? ElevatedButton(
                style: style,
                onPressed: () => clkBtn(0),
                child: const Text("중지하기"),
              )
            : ElevatedButton(
                onPressed: () => clkBtn(count),
                child: const Text("자동 번호 생성"),
              ),
      ),
    );
  }
}
