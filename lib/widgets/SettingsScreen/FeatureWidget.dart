import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FeatureWidget extends StatefulWidget {
  @override
  _FeatureWidgetState createState() => _FeatureWidgetState();
}

class _FeatureWidgetState extends State<FeatureWidget> {
  // 텍스트 입력을 위한 컨트롤러 생성
  TextEditingController suggestionController = TextEditingController();
  TextEditingController additionalController = TextEditingController(); // 추가 의견 컨트롤러

  bool isEmptySuggestion = false;

  onSubmit (){
    String suggestion = suggestionController.value.text;
    String additional = additionalController.value.text;

    isEmptySuggestion = (suggestion.isEmpty)?true:false;

    if(isEmptySuggestion){
      setState(() {});
    }else{
      print("저장");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 기능 제안 텍스트 입력 필드
        const Text(
          "제안할 기능을 기술해 주세요:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        (isEmptySuggestion)?const Text("필수 입력 필드 입니다.", style: TextStyle(color: Colors.red),):const SizedBox(height: 8),
        TextField(
          controller: suggestionController,
          decoration: const InputDecoration(
            hintText: "아이디어를 입력해주세요.",
            border: OutlineInputBorder(),
          ),
          maxLines: 4, // 다중 라인 지원
          maxLength: 100,
          inputFormatters: [LengthLimitingTextInputFormatter(100)],
        ),
        const SizedBox(height: 16),
        // 추가 의견 필드 (선택사항)
        const Text(
          "추가 의견 (선택사항):",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: additionalController, // 변경된 부분
          decoration: const InputDecoration(
            hintText: "추가적인 의견이 있으신가요?",
            border: OutlineInputBorder(),
          ),
          maxLines: 2,
          maxLength: 50,
          inputFormatters: [LengthLimitingTextInputFormatter(50)],
        ),
        const SizedBox(height: 16,),
        (isEmptySuggestion)?
          const Text("입력을 안한 필드가 있습니다.", style: TextStyle(color: Colors.red),):const SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                // 여기에 전송 로직 추가
                onSubmit();
                //Navigator.pop(context);
              },
              child: const Text("전송"),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("닫기"),
            ),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    // 컨트롤러 메모리 해제
    suggestionController.dispose();
    additionalController.dispose();
    super.dispose();
  }
}
