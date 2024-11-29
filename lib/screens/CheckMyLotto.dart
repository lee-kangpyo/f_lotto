import 'package:flutter/material.dart';
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

  Widget _buildBarcode (Barcode? value){
    if(value == null) {return labelText('');}

    if(value.format.name == "qrCode"){
      String? url = value.displayValue;

      print(value.displayValue);
      print(value.size);
      print(value.type);
      print(value.format.name);
      print(value.url);
      return labelText(value.displayValue ?? '',);
    }
    return const Text('');
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
      appBar: AppBar(title: Text("당첨 확인"),),
      body:Column(
        children: [
          SizedBox(height: (halfWidth > maxSize) ? maxSize / 2 : halfWidth / 2,
            child: Center(child: Text(title, style: TextStyle(fontSize: 18),)),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              alignment: Alignment.bottomCenter,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(child: Center(child: _buildBarcode(_barcode),))
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
