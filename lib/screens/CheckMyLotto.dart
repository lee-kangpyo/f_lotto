import 'package:flutter/material.dart';
import 'package:lotto/util/splitUrl.dart';
import 'package:lotto/widgets/CheckMyLotto/GetWinningLottoNumbers.dart';
import 'package:lotto/widgets/CheckMyLotto/ScanResult.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class CheckMyLotto extends StatefulWidget {
  const CheckMyLotto({super.key});

  @override
  State<CheckMyLotto> createState() => _CheckMyLottoState();
}

class _CheckMyLottoState extends State<CheckMyLotto> {
  Barcode? _barcode;
  Widget labelText (text) => Text(text, overflow: TextOverflow.fade, style: const TextStyle(color: Colors.black),);
  String title = "로또 용지의 QR코드를 스캔해 주세요";
  Map? data;

  Widget _buildBarcode (Barcode? value){
    String validUrl = "http://m.dhlottery.co.kr";
    Widget returnWidget = const SizedBox.shrink();
    // null, qr코드 아닌것 쳐내기
    if(value == null) {return returnWidget;}
    if(value.format.name != "qrCode") {return returnWidget;}

    String? url = value.displayValue;
    // displayValue 가 null 인것 쳐내기
    if(url == null) {return returnWidget;}
    Uri uri = Uri.parse(url);
    String domain = uri.origin;
    String params = uri.query.isNotEmpty ? uri.query : '';
    if(validUrl == domain){
      data = splitUrl(params);
      return returnWidget;
    }else{
      data = null;
      return labelText("동행 복권 qr코드가 아닙니다.");
    }
  }


  void _handleBarcode (BarcodeCapture barcodes){
    if(mounted){
      setState(() {
        _barcode = barcodes.barcodes.firstOrNull;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    double halfWidth = MediaQuery.of(context).size.width / 2;
    double maxSize = 400;
    return Scaffold(
      appBar: AppBar(title: const Text("당첨 확인"),),
      body:Column(
        children: [
          SizedBox(height: 50 ,
            child: Center(child: Text(title, style: const TextStyle(fontSize: 18),)),
          ),
          Center(
            child: SizedBox(
              width: halfWidth > maxSize ? maxSize : halfWidth,
              height: halfWidth > maxSize ? maxSize : halfWidth,
              child: MobileScanner(
                onDetect: _handleBarcode,
              ),
            ),
          ),
          (data == null)? const SizedBox.shrink() : BottomWidget(data: data,),
          Container(child: _buildBarcode(_barcode))
        ],
      )
    );
  }
}

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key, required this.data, this.winningNumber});
  final data;
  final winningNumber;

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  List<int>? numbers;
  int? bonus;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GetWinningLottoNumbers(round:widget.data!["round"], setWinningNumber:(_numbers, _bonus){
          setState(() {
            numbers = _numbers;
            bonus=_bonus;
          });
        }),
        ScanResult(data: widget.data, winndingNumber:(numbers==null)?null:{"numbers":numbers, "bonus":bonus}),
      ],
    );
  }
}

