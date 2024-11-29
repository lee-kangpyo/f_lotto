import 'package:flutter/material.dart';
import 'package:lotto/util/lotto.dart';
import 'package:lotto/widgets/common/SingleLottoBall.dart';

class LottoNumbers extends StatelessWidget {
  const LottoNumbers({super.key, required this.lottoNumbers});
  final List<int> lottoNumbers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: lottoNumbers.map<Widget>((el) {
        return SingleLottoBall(number: el, size: 35);
      }).toList(),
    );
  }
}
