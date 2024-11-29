import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lotto/models/FilterNumbers.dart';
import 'package:lotto/provider/count_provider.dart';
import 'package:lotto/util/modal_util.dart';
import 'package:lotto/widgets/common/Sep.dart';
import 'package:lotto/widgets/common/SingleLottoBall.dart';
import 'package:provider/provider.dart';

class AddRemoveModalWidget extends StatelessWidget {
  const AddRemoveModalWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> numbers = List.generate(45, (index) => index + 1);
    //Map<int, int> numberMap = cp.numberMap;
    var cp = Provider.of<CountProvider>(context);
    final filterBox = Hive.box<FilterNumbers>('filterNumbers');
    // final filter = filterBox.get('filterNumbers');
    // if(filter != null){
    //   cp.updateNumberMap(filter.filterNumber);
    // }

    onTap(number) {
      int mode = cp.mode;
      if(mode == 0) {
        cp.clickNumber(number);
      }else {
        int count = cp.numberMap.values.where((value) => value == mode).length;
        if(count >= 30){
          var modeNa = (mode==1)?"고정수":"제외수";
          showCustomAlert(context: context, title: "알림", content: "$modeNa 는 30개이상 설정할수 없습니다.", buttonText: "확인", onButtonPressed: (){Navigator.of(context).pop();});
        }else{
          cp.clickNumber(number);
        }
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const TapWidget(),
        const Sep(
          height: 16,
        ),
        GridNumbers(
          numbers: numbers,
          onTap: onTap,
        ),
        Container(
            padding: const EdgeInsets.all(8),
            alignment: Alignment.centerRight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () => cp.initnumberMap(),
                  child: const Text("전체해제"),
                ),
                const Sep(width:16,),
                InkWell(
                    onTap: () {
                      int count = cp.numberMap.values.where((value) => value == 1).length;
                      if(count == 6 || count == 7){
                        showCustomAlert(context: context, title: "알림", content: "고정수를 6 또는 7개만 설정할수 없습니다.", buttonText: "확인", onButtonPressed: (){Navigator.of(context).pop();});
                      }else{
                        filterBox.put("filterNumbers", FilterNumbers()..filterNumber = cp.numberMap);
                        Navigator.of(context).pop();
                      }

                    },
                    child: const Text("확인"),
                ),
              ],
            )),
      ],
    );
  }
}

// 넘버 그리드 뷰
class GridNumbers extends StatelessWidget {
  const GridNumbers({super.key, required this.numbers, required this.onTap});
  final List<int> numbers;
  final Function onTap;



  @override
  Widget build(BuildContext context) {
    var cp = Provider.of<CountProvider>(context);
    return SizedBox(
      height: 300,
      child: GridView(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7),
        children: numbers.map<Widget>((number) {
          int stat = cp.numberMap[number] as int;

          return InkWell(
            enableFeedback: false,
            onTap: () {
              onTap(number);
            },
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                SingleLottoBall(
                  number: number,
                  margin: 2,
                ),
                StackText(number: number, stat: stat),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

// 고정수 제외수 보여주는 text위젯
class StackText extends StatelessWidget {
  const StackText({super.key, required this.number, this.stat = 0});
  final int number;
  final int stat;

  @override
  Widget build(BuildContext context) {
    if(stat == 1) {
      return Center(child: Icon(Icons.circle_outlined, color: Colors.black, size: 40.0,));
    }else if(stat == 2){
      return Icon(Icons.close_rounded, color: Colors.black, size: 40.0,);
    }else {
      return const SizedBox();
    }
  }
}


// 탭 위젯
class TapWidget extends StatelessWidget {
  const TapWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var mode = Provider.of<CountProvider>(context).mode;
    var setMode = Provider.of<CountProvider>(context).setMode;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Tap(
            text: "고정수",
            onTap: () {
              setMode(1);
            },
            selected: (mode == 1) ? true : false),
        const Sep(
          width: 4,
        ),
        Tap(
            text: "제외수",
            onTap: () {
              setMode(2);
            },
            selected: (mode == 2) ? true : false),
        const Sep(
          width: 4,
        ),
        Tap(
            text: "해제",
            onTap: () {
              setMode(0);
            },
            selected: (mode == 0) ? true : false),
      ],
    );
  }
}

// 하나의 탭을 공통화
class Tap extends StatelessWidget {
  const Tap(
      {super.key,
      required this.text,
      required this.onTap,
      required this.selected});
  final String text;
  final void Function() onTap;
  final bool selected;

  //static const selectedtextStyle = TextStyle(color: Color(0xfff1f1f1), fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    var selectedtextStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: const Color(0xfff1f1f1), fontWeight: FontWeight.bold);

    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: const Color(0xffaaaaaa),
            ),
            borderRadius: BorderRadius.circular(5.0),
            color: (selected) ? const Color(0xffaaaaaa) : null,
          ),
          child: Center(
            child: Text(
              text,
              style: (selected) ? selectedtextStyle : null,
            ),
          ),
        ),
      ),
    );
  }
}
