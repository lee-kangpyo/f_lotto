
import 'package:flutter/material.dart';

class AnalizedNumbers extends StatelessWidget {
  const AnalizedNumbers({super.key, required this.lottoNumbers});
  final List<int> lottoNumbers;

  @override
  Widget build(BuildContext context) {

    int calculateAC(List<int> numbers) {
      // 1단계: 쌍 조합 생성
      List<int> differences = [];
      for (int i = 0; i < numbers.length; i++) {
        for (int j = i + 1; j < numbers.length; j++) {
          // 2단계: 차이 계산
          differences.add((numbers[j] - numbers[i]).abs());
        }
      }

      // 3단계: 중복 제거 후 고유 차이 값 정리
      Set<int> uniqueDifferences = differences.toSet();
      List<int> sortedDifferences = uniqueDifferences.toList()..sort();

      // 4단계: AC 값 계산
      int numOfUniqueDifferences = sortedDifferences.length;
      int numOfBalls = numbers.length;
      int acValue = numOfUniqueDifferences - (numOfBalls - 1);

      return acValue;
    }


    Map<dynamic, dynamic> data = lottoNumbers.fold({"sum":0, "odd":0, "even":0, "high":0, "row":0, "ac":0}, (result, number) {
      result["sum"] += number;

      if(number % 2 == 0){
        result["even"] += 1;
      }else{
        result["odd"] += 1;
      }

      if(number < 23){
        result["row"] += 1;
      }else{
        result["high"] += 1;
      }
      return result;
    });

    data["ac"] = calculateAC(lottoNumbers);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("총합: ${data['sum']}, "),
        Text("홀짝: ${data['odd']}:${data['even']}, "),
        Text("고저: ${data['high']}:${data['row']}, "),
        Text("AC: ${calculateAC(lottoNumbers)}"),
      ],
    );
  }
}
