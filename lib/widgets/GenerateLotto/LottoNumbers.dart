import 'package:flutter/material.dart';
import 'package:lotto/widgets/common/SingleLottoBall.dart';

class LottoNumbers extends StatelessWidget {
  const LottoNumbers({super.key, required this.lottoNumbers, this.bonus, this.winningNumbers});
  final List<int> lottoNumbers;
  final int? bonus;
  final Map? winningNumbers;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: lottoNumbers.map<Widget>((el) {
            if(winningNumbers == null){
              return SingleLottoBall(number: el, size: 35);
            }else{
              List<int> numbers = winningNumbers!["numbers"];
              //int bonus = winningNumbers!["bonus"];
              bool isvalid = numbers.contains(el);
              return SingleLottoBall(number: el, size: 35, backGroundColor: (isvalid)?null:Colors.grey[300], textColor: (isvalid)?null:Colors.black45,);
            }

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
