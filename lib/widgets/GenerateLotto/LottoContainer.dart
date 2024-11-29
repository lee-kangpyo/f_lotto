
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:lotto/models/lotto.dart';
import 'package:lotto/util/color.dart';
import 'package:lotto/widgets/AnalizedNumbers.dart';
import 'package:lotto/widgets/GenerateLotto/LottoNumbers.dart';
import 'package:lotto/widgets/common/MiniButton.dart';
import 'package:quiver/iterables.dart';


class LottoContainer extends StatefulWidget {
  const LottoContainer(
      {super.key, required this.lottoNumbers, required this.generateDate, required this.generateOne});
  final List<List<int>?> lottoNumbers;
  final List<Map<String, dynamic>?> generateDate;
  final Function generateOne;

  @override
  State<LottoContainer> createState() => _LottoContainerState();
}

class _LottoContainerState extends State<LottoContainer> {
  @override
  Widget build(BuildContext context) {
    var combined = zip([widget.generateDate, widget.lottoNumbers]);

    bool isDuplicate (lottoNumber){
      var box = Hive.box<Lotto>('lottos');

      final matchingData = box.values.where(
            (data) => listEquals(data.lottoNumber, lottoNumber),
      ).toList();

      return matchingData.isEmpty;
    }

    onTap (obj) async {
      Map<String, dynamic> dateMap = obj[0];
      DateTime date =  dateMap["date"];
      List<int> lottoNumber = obj[1];

      if(isDuplicate(lottoNumber)){
        setState(() {
          var box = Hive.box<Lotto>('lottos');
          box.add(Lotto()..lottoNumber=lottoNumber..createDate=date);
        });
      }
    }
// build
    if ((widget.lottoNumbers.isEmpty)) {
      return const Expanded(child: Center(child: Text("로또 번호를 생성할수있습니다.")));
    } else {
      return Expanded(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ListView(
              children: combined.toList()
                  .map((obj) {
                      Map<String, dynamic> result = obj[0] as Map<String, dynamic>;
                      List<int> lottoNumber = obj[1] as List<int>;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: const BoxDecoration(color: AppColors.backColor, borderRadius: BorderRadius.all(Radius.circular(15)),),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                //_DateWidget(ymd: result['ymd']!, time: result['time']!),
                                LottoNumbers(lottoNumbers: obj[1]! as List<int>),
                                _BtnWidget(isDuplicate: isDuplicate(lottoNumber), onTap: () => onTap(obj)),
                              ],
                            ),
                            AnalizedNumbers(lottoNumbers: obj[1]! as List<int>),
                          ],
                        ),
                      );
                    }
                  )
                  .toList(),
            ),
          ),
      );
    }
  }
}


class _DateWidget extends StatelessWidget {
  const _DateWidget({super.key, required this.ymd, required this.time});
  final String ymd;
  final String time;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(fontSize: 10, fontWeight: FontWeight.normal);
    return Column(
      children: [
        Text(ymd, style: textStyle,),
        Text(time, style: textStyle,),
      ],
    );
  }
}

class _BtnWidget extends StatelessWidget {
  const _BtnWidget({super.key, required this.isDuplicate, required this.onTap});
  final bool isDuplicate;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (isDuplicate)? MiniButton(btnText: "저장", onTap:onTap, width: 45, height: 35,) : const MiniButton(btnText: "저장됨", width: 50, height: 35,),
    );
  }
}