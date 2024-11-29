import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class Pattens extends StatelessWidget {
  const Pattens({super.key, required this.numbers});
  final List<int> numbers;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        LottoPage(numbers),
        ElevatedButton(onPressed: ()=>Navigator.of(context).pop(), child: Text("닫기")),
      ],
    );
  }
}

// 로또 용지 패턴 위젯
Widget LottoPage(lottoNumbers){
  List<List<int?>> numbers = [
    [1, 2, 3, 4, 5, 6, 7],
    [8, 9, 10, 11, 12, 13, 14],
    [15, 16, 17, 18, 19, 20, 21],
    [22, 23, 24, 25, 26, 27, 28],
    [29, 30, 31, 32, 33, 34, 35],
    [36, 37, 38, 39, 40, 41, 42],
    [43, 44, 45, null, null, null, null],
  ];

  Widget NumberContainer (int? number, bool isActive){
    return Column(
      children: [
        const RotatedBox(
            quarterTurns: 1,
            child: Text("[", style: TextStyle(fontSize: 20),)
        ),
        Container(
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
          Positioned.fill(
              child: Container(decoration: BoxDecoration(color: Colors.white),
                child: CustomPaint(
                  size: Size(double.infinity, double.infinity),
                  painter: LinePainter(lottoNumbers, numbers),
                ),)
          ),
          Column(
            children: numbers.map((number) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:
                number.map((value){
                  return NumberContainer(value, lottoNumbers.contains(value));
                }).toList(),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

// 로또 용지에 렌더링 될 숫자 위젯
Widget NumberContainer(int? Number) {
  return Column(
    children: [
      const RotatedBox(
          quarterTurns: 1,
          child: Text("[", style: TextStyle(fontSize: 20))),
      Container(
          alignment: Alignment.center,
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(Number?.toString() ?? "")),
      const RotatedBox(
          quarterTurns: 1,
          child: Text("]", style: TextStyle(fontSize: 20))),
    ],
  );
}

// CustomPainter 클래스를 생성하여 선을 그릴 부분을 정의
class LinePainter extends CustomPainter {
  final List<int> connectNumbers;
  final List<List<int?>> numbers;

  LinePainter(this.connectNumbers, this.numbers);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4;

    const double horizontalPadding = 15.0;
    const double verticalPadding = 23.0;
    final int columnCount = numbers[0].length;

    // 번호와 위치를 매핑
    Map<int, Offset> numberPositions = {};
    for (int row = 0; row < numbers.length; row++) {
      for (int col = 0; col < numbers[row].length; col++) {
        final number = numbers[row][col];
        if (number == null) {continue;};
        double x = col * (size.width / columnCount) + horizontalPadding;
        double y = row * (size.height / numbers.length) + verticalPadding;
        numberPositions[number] = Offset(x, y);
      }
    }

    // 연결된 번호의 위치를 기반으로 선 그리기
    List<Offset> points = [];
    for (var num in connectNumbers) {
      if (numberPositions.containsKey(num)) {
        points.add(numberPositions[num]!);
      } else {
        debugPrint('Warning: Number $num not found in numbers grid');
      }
    }

    // points에 저장된 위치들을 연결하는 선 그리기
    for (int i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  } 

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) {
    return oldDelegate.connectNumbers != connectNumbers;
  }
}