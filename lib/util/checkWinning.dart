
String checkWinning(List<int> myNumbers, List<int> winningNumbers, int bonusNumber) {
  // 내 번호와 당첨 번호에서 일치하는 번호 개수 세기
  int matchCount = myNumbers.where((num) => winningNumbers.contains(num)).length;

  // 보너스 번호와 일치하는지 확인
  bool bonusMatch = myNumbers.contains(bonusNumber);

  // 일치한 번호 개수와 보너스 번호 여부에 따라 등수 결정
  if (matchCount == 6) {
    return "1등"; // 1등
  } else if (matchCount == 5 && bonusMatch) {
    return "2등"; // 2등
  } else if (matchCount == 5) {
    return "3등"; // 3등
  } else if (matchCount == 4) {
    return "4등"; // 4등
  } else if (matchCount == 3) {
    return "5등"; // 5등
  } else {
    return "낙첨"; // 꽝
  }
}