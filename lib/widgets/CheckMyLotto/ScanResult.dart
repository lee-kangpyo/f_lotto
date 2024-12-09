import 'package:flutter/material.dart';
import 'package:lotto/util/checkWinning.dart';
import 'package:lotto/widgets/GenerateLotto/LottoNumbers.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({super.key, required this.data, this.winndingNumber});
  final data;
  final Map? winndingNumber;

  @override
  Widget build(BuildContext context) {
    final numbers = data["numbers"];
    TextStyle st = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("제 ${data["round"]} 회", style: st,),
              Text("tr:${data["tr"]}", style: st,),
            ],
          ),
          const SizedBox(height: 16,),
          ...numbers.map((numberObj) {
            String isWinning = (winndingNumber == null)?"-":checkWinning(numberObj["number"], winndingNumber!["numbers"], winndingNumber!["bonus"]);
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(numberObj["type"]),
                const SizedBox(width: 16,),
                LottoNumbers(lottoNumbers: numberObj["number"] as List<int>, winningNumbers:winndingNumber),
                const SizedBox(width: 16,),
                Text(isWinning),
              ],
            );
            //_BtnWidget(isDuplicate: isDuplicate(lottoNumber), onTap: () => onTap(obj)),
          }).toList()
        ],
      ),
    );
  }
}
