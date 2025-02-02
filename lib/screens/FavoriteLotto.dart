import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:lotto/models/lotto.dart';
import 'package:lotto/util/color.dart';
import 'package:lotto/util/modal_util.dart';
import 'package:lotto/widgets/AnalizedNumbers.dart';
import 'package:lotto/widgets/FavoriteLotto/Pattens.dart';
import 'package:lotto/widgets/GenerateLotto/LottoNumbers.dart';
import 'package:lotto/widgets/common/MiniButton.dart';

class FavoratieLotto extends StatefulWidget {
  const FavoratieLotto({super.key});

  @override
  State<FavoratieLotto> createState() => _FavoratieLottoState();
}

class _FavoratieLottoState extends State<FavoratieLotto> {

  @override
  Widget build(BuildContext context) {

    void openPattenModal(context, numbers) {
      showCustomModal(
        barrierDismissible: false,
        context: context,
        child: Pattens(numbers: numbers,),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("내가 저장한 번호"),),
      body: ValueListenableBuilder<Box>(
          valueListenable: Hive.box<Lotto>("lottos").listenable(),
          builder: (context, box, widget) {
            return (box.isEmpty)?const Center(child: Text("저장한 로또 번호가 없습니다."),):Container(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: box.keys.map((key) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: const BoxDecoration(color: AppColors.backColor, borderRadius: BorderRadius.all(Radius.circular(15)),),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            LottoNumbers(lottoNumbers: box.get(key).lottoNumber),
                            Row(
                              children: [
                                MiniButton(btnText: "삭제", onTap: ()=>box.delete(key),),
                                const SizedBox(width: 4,),
                                MiniButton(btnText: "패턴", onTap: ()=>openPattenModal(context, box.get(key).lottoNumber),)
                              ],
                            ),
                          ],
                        ),
                        AnalizedNumbers(lottoNumbers: box.get(key).lottoNumber)
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
          child: Text("즐겨찾기")),
    );
  }
}
