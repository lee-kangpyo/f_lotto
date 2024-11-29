import 'package:flutter/material.dart';
import 'package:lotto/util/lotto.dart';

class SingleLottoBall extends StatelessWidget {
  const SingleLottoBall({super.key, required this.number, this.size=30, this.margin = 4});
  final int number;
  final double size;
  final double margin;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        margin: EdgeInsets.all(margin),
        decoration: BoxDecoration(
            color: getColorByNumber(number),
            borderRadius: BorderRadius.circular(20)),
        child: Text(
          number.toString(),
          style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        )
    );;
  }
}
