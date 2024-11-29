import 'package:flutter/material.dart';

class CountProvider with ChangeNotifier {
  // 생성할 로또 회수
  int _count = 5;   
  // 고정수 제외수가 체크된 로또번호 오브젝트
  Map<int, int> _numberMap = {
    for (var item in List.generate(45, (index) => index + 1)) item: 0
  };

  // 고정수:1, 제외수:2, 해제: 0
  int _mode = 1;
  int get mode => _mode;
  void setMode (int mode){
    _mode = mode;
    notifyListeners();
  }

  int get count => _count;
  void setCount (int count){
    _count = count;
    notifyListeners();
  }

  Map<int, int> get numberMap => _numberMap;
  void updateNumberMap (Map<int, int> obj){
    _numberMap = obj;
  }
  void setNumberMap(int key, int value){
    _numberMap[key] = value;
    notifyListeners();
  }

  //클릭한 공의 번호를 전달받아 mode를 기반으로 _numberMap을 변경
  void clickNumber (int number){
    _numberMap[number] = mode;
    // if(mode == 1){ // 고정수
    //   _numberMap[number] = 1;
    // }else if(mode == 2){ // 제외수:1
    //   _numberMap[number] = 2;
    // }
    notifyListeners();
  }
  // 초기화
  void initnumberMap (){
    _numberMap.updateAll((key, value) => 0);
    notifyListeners();
  }

}