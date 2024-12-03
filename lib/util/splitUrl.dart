
Map<String, dynamic> splitUrl(String queryString){
  // 1. 회차 번호 추출 (v=숫자) 만 추출 v1234d12345 -> 1234까지 추출
  RegExp roundPattern = RegExp(r'v=(\d+)');
  Match? roundMatch = roundPattern.firstMatch(queryString);
  String? roundNumber = roundMatch?.group(1); // 회차 번호

  // 2. 번호 리스트 추출 (q로 시작 뒤 12자리 숫자만 추출)
  RegExp qGroupPattern = RegExp(r'(q|m)(\d{12})');
  Iterable<Match> qGroupMatches = qGroupPattern.allMatches(queryString);

  // 번호 리스트 생성 (자동/수동 여부와 두 자리씩 나눈 번호 포함)
  List<Map<String, dynamic>> qGroups = qGroupMatches.map((match) {
    // 첫 번째 그룹: 자동("q") 또는 수동("m")
    String type = match.group(1) ?? "";
    // 두 번째 그룹: 12자리 숫자
    String number = match.group(2) ?? "";

    // 3번: 두 자리씩 자르는 작업
    List<int> group = [];
    for (int i = 0; i < number.length; i += 2) {
      String pair = number.substring(i, i + 2);
      group.add(int.parse(pair));
    }

    // 2번: 자동/수동과 3번 결과를 포함한 Map 생성
    return {
      'type': (type == "q") ? "자동" : (type == "m") ? "수동" : "-",
      'number': group  // 3번의 결과인 두 자리 숫자 리스트를 넣음
    };
  }).toList();

  // 4. 맨뒤 10자리 숫자 추출
  RegExp last10Pattern = RegExp(r'\d{10}$');
  Match? last10Match = last10Pattern.firstMatch(queryString);
  String? last10Digits = last10Match?.group(0);

  // print("회차 번호: $roundNumber");
  // print("번호 리스트: $qGroups2");
  // print("마지막 10자리 숫자: $last10Digits");
  return {"round":roundNumber, "numbers":qGroups, "tr":last10Digits};
}