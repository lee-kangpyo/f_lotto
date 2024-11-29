import 'dart:math';

import 'package:flutter/material.dart';

Color getColorByNumber(int number) {
  if (number >= 1 && number <= 10) {
    return const Color(0xffE4A716); //노랑
  } else if (number >= 11 && number <= 20) {
    return const Color(0xff1E95DB); // 파랑
  } else if (number >= 21 && number <= 30) {
    return const Color(0xffE96353); // 빨강
  } else if(number >= 31 && number <= 40) {
    return const Color(0xff8F8F8F); // 회색
  } else{
    return const Color(0xff5AB545);       // 녹색
  }
}

// 배열을 섞는 함수 (Fisher-Yates Shuffle 알고리즘)
void shuffleList(List<int> list) {
  final random = Random();
  for (int i = list.length - 1; i > 0; i--) {
    final int j = random.nextInt(i + 1); // 0에서 i 사이의 임의의 정수를 선택
    final int temp = list[i];
    list[i] = list[j];
    list[j] = temp;
  }
}
List<int> getNumbers (Map<int, int> filters) {
  // 1부터 45까지의 숫자가 담긴 리스트 생성
  List<int> result = [];
  List<int> numbers = List.generate(45, (index) => index + 1);
  var box = numbers.where((number) => filters[number] == 0).toList();
  var gojungBox = numbers.where((number) => filters[number] == 1).toList();
  //var exceptNumbers = numbers.where((number) => filters[number] == 2);
  shuffleList(gojungBox);
  shuffleList(box);
  // print(gojungBox);
  // print(box);



  bool roop = true;
  while(roop){
    if(gojungBox.isNotEmpty){
      int num = gojungBox.removeAt(0);
      result.add(num);
    }else{
      int num = box.removeAt(0);
      result.add(num);
    }

    if(result.length == 6) roop = false;
  }
  result.sort();
  return result;
}