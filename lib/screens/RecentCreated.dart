import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lotto/models/currentGenerated.dart';
import 'package:lotto/models/lotto.dart';
import 'package:lotto/util/color.dart';
import 'package:lotto/widgets/AnalizedNumbers.dart';
import 'package:lotto/widgets/GenerateLotto/LottoNumbers.dart';
import 'package:lotto/widgets/common/MiniButton.dart';

class RecentCreated extends StatefulWidget {
  const RecentCreated({super.key});

  @override
  State<RecentCreated> createState() => _RecentCreatedState();
}

class _RecentCreatedState extends State<RecentCreated> {
  //await Hive.openBox<CurrentGenerated>("currentGenerated")
  bool isDuplicate (lottoNumber){
    var lottoBox = Hive.box<Lotto>('lottos');
    final matchingData = lottoBox.values.where(
          (data) => listEquals(data.lottoNumber, lottoNumber),
    ).toList();
    return matchingData.isEmpty;
  }

  onTap (obj) async {
    final date = DateTime.now();
    final lottoNumber = obj.lottoNumber;

    if(isDuplicate(lottoNumber)){
      var lottoBox = Hive.box<Lotto>('lottos');
      setState((){
        lottoBox.add(Lotto()..lottoNumber=lottoNumber..createDate=date);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("최근생성번호"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: ValueListenableBuilder<Box>(
              valueListenable: Hive.box<CurrentGenerated>("currentGenerated").listenable(),
              builder: (context, box, widget) {
                final sortedKeys = box.keys.toList()..sort((a, b) {return b - a;});
                print(box.isEmpty);
                return (box.isEmpty)?const Center(child: Text("최근 생성한 로또 번호가 없습니다.")):ListView(
                  children: sortedKeys.map((key) {
                    final number = box.get(key).lottoNumber;
                    final dateStr = DateFormat('yyyy년 MM월 dd일 HH:mm').format(box.get(key).createDate);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: const BoxDecoration(color: AppColors.backColor, borderRadius: BorderRadius.all(Radius.circular(15)),),
                      child: Column(
                        children: [
                          Text(dateStr),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              LottoNumbers(lottoNumbers: number),
                              (isDuplicate(number))? MiniButton(btnText: "저장", onTap: ()=>onTap(box.get(key)), width: 45, height: 35,):MiniButton(btnText: "저장됨", onTap: (){}, width: 50, height: 35,)
                            ],
                          ),
                          AnalizedNumbers(lottoNumbers: box.get(key).lottoNumber)
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
              child: const Text("")),
        ),
      ),
    );
  }
}

