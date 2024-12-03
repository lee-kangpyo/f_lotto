import 'package:flutter/material.dart';
import 'package:lotto/widgets/GenerateLotto/LottoNumbers.dart';

class ScanResult extends StatelessWidget {
  const ScanResult({super.key, required this.data});
  final data;

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
            return Row(
              children: [
                Text(numberObj["type"]),
                const SizedBox(width: 16,),
                LottoNumbers(lottoNumbers: numberObj["number"] as List<int>),
              ],
            );
            //_BtnWidget(isDuplicate: isDuplicate(lottoNumber), onTap: () => onTap(obj)),
          }).toList()
        ],
      ),
    );
  }
}
