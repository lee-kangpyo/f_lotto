
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lotto/util/LottoService.dart';
import 'package:lotto/widgets/GenerateLotto/LottoNumbers.dart';

class GetWinningLottoNumbers extends StatefulWidget {
  const GetWinningLottoNumbers({super.key, required this.round, required this.setWinningNumber});
  final String round;
  final Function setWinningNumber;

  @override
  State<GetWinningLottoNumbers> createState() => _GetWinningLottoNumbersState();
}

class _GetWinningLottoNumbersState extends State<GetWinningLottoNumbers> {
  LottoService lottoService = LottoService();
  String? status;
  List<int>? winningNumber;
  int? bonus;

  getWinningNumber () async {
    status = "pending";
    final res = await lottoService.getWinningNumber(widget.round);
    final data = jsonDecode(res.data);
    status = data["returnValue"];
    if(status == "success"){
      winningNumber = [data["drwtNo1"], data["drwtNo2"], data["drwtNo3"], data["drwtNo4"], data["drwtNo5"], data["drwtNo6"],];
      bonus = data["bnusNo"];
    }else{
      winningNumber = null;
      bonus = null;
    }
    widget.setWinningNumber(winningNumber, bonus);
  }
  @override
  Widget build(BuildContext context) {
    TextStyle st = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          (status == "pending")?Text("${widget.round} 회 당첨 번호를 가져오는 중입니다.", style: st,):const SizedBox.shrink(),
          (status == "success")?Text("${widget.round} 회 당첨 번호", style: st,):const SizedBox.shrink(),
          (status == "fail")?Text("${widget.round} 회 는 아직 개표전입니다.", style: st,):const SizedBox.shrink(),
          (winningNumber != null && status == "success")?LottoNumbers(lottoNumbers: winningNumber!, bonus:bonus):const SizedBox.shrink(),
        ],
      ),
    );
  }

  @override
  void initState() {
    getWinningNumber ();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant GetWinningLottoNumbers oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.round != oldWidget.round) {
      getWinningNumber ();
    }
  }
}

