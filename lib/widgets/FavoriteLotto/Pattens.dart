import 'package:flutter/material.dart';


class Pattens extends StatefulWidget {
  const Pattens({super.key, required this.numbers});
  final List<int> numbers;

  @override
  State<Pattens> createState() => _PattensState();
}

class _PattensState extends State<Pattens> {

  List<List<int?>> numbers = [
    [1, 2, 3, 4, 5, 6, 7],
    [8, 9, 10, 11, 12, 13, 14],
    [15, 16, 17, 18, 19, 20, 21],
    [22, 23, 24, 25, 26, 27, 28],
    [29, 30, 31, 32, 33, 34, 35],
    [36, 37, 38, 39, 40, 41, 42],
    [43, 44, 45, null, null, null, null],
  ];

  Map<int, GlobalKey> keys = {};
  //Map<int, Offset> numberPositions = {};
  List<Offset> numberPostisions = [];

  @override
  void initState() {
    super.initState();
    for (var row in numbers) {
      for (var num in row) {
        if(num == null) return;
        keys[num] = GlobalKey(); // 각 숫자마다 GlobalKey 생성
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      saveOffsets();
    });
  }

  void saveOffsets(){
    for (var number in widget.numbers){
      final GlobalKey? key = keys[number];
      if (key == null){continue;}

      final RenderBox? box = key.currentContext?.findRenderObject() as RenderBox?;
      final RenderBox? parentBox = context.findRenderObject() as RenderBox?;
      if(box == null || parentBox == null){continue;}

      final Offset globalPosition = box.localToGlobal(Offset.zero); // 전역 좌표
      final Offset localPosition = parentBox.globalToLocal(globalPosition); // 부모 기준 좌표
      final Size widgetSize = box.size;

      double x = localPosition.dx+widgetSize.width / 2;
      double y = localPosition.dy+widgetSize.height / 2;

      numberPostisions.add(Offset(x, y));
    }

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(),
              child: CustomPaint(
                size: const Size(double.infinity, double.infinity),
                painter: LinePainter(numberPostisions),
              ),)
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LottoPage(widget.numbers, numbers, keys),
            ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: const Text("닫기")),
          ],
        ),
      ],
    );
  }
}

// 로또 용지 패턴 위젯
Widget LottoPage(lottoNumbers, List<List<int?>> numbers, Map<int, GlobalKey> keys){

  Widget NumberContainer (int? number, bool isActive, key){
    return Column(
      children: [
        const RotatedBox(
            quarterTurns: 1,
            child: Text("[", style: TextStyle(fontSize: 20),)
        ),
        Container(
            key: key,
            alignment: Alignment.center,
            width: 30,
            height: 30,
            decoration: BoxDecoration(color: isActive?Colors.red:Colors.white.withOpacity(0), borderRadius: BorderRadius.circular(15),),
            child: Text(number?.toString() ?? "", style: TextStyle(color: isActive?Colors.white:Colors.black, fontWeight: isActive?FontWeight.bold:FontWeight.normal),)
        ),
        const RotatedBox(
            quarterTurns: 1,
            child: Text("]", style: TextStyle(fontSize: 20),)
        ),
      ],
    );
  }

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Container(
      child: Stack(
        children: [
          // Positioned.fill(
          //     child: Container(decoration: const BoxDecoration(color: Colors.white),
          //       child: CustomPaint(
          //         size: const Size(double.infinity, double.infinity),
          //         painter: LinePainter(lottoNumbers, numbers),
          //       ),)
          // ),
          Column(
            children: numbers.map((number) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                number.map((value){
                  return NumberContainer(value, lottoNumbers.contains(value), keys[value]);
                }).toList(),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

class LinePainter extends CustomPainter {
  final List<Offset> numberPositions;

  LinePainter(this.numberPositions);

  @override
  void paint(Canvas canvas, Size size){
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4;

    for (int i = 0; i < numberPositions.length - 1; i++) {
      canvas.drawLine(numberPositions[i], numberPositions[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) {
    return oldDelegate.numberPositions != numberPositions;
  }

}