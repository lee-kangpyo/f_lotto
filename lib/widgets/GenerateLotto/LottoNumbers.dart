import 'package:flutter/material.dart';
import 'package:lotto/widgets/common/SingleLottoBall.dart';

class LottoNumbers extends StatelessWidget {
  const LottoNumbers({super.key, required this.lottoNumbers, this.bonus});
  final List<int> lottoNumbers;
  final int? bonus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: lottoNumbers.map<Widget>((el) {
            return SingleLottoBall(number: el, size: 35);
          }).toList(),
        ),
        (bonus != null)?
              Row(
                children: [
                  const Text("+"),
                  SingleLottoBall(number: bonus!, size: 35),
                ],
              )
            :
              const SizedBox.shrink(),
      ],
    );
  }
}
