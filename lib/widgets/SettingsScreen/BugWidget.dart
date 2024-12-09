import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class BugWidget extends StatefulWidget {
  @override
  _BugWidgetState createState() => _BugWidgetState();
}

class _BugWidgetState extends State<BugWidget> {
  // 텍스트 입력을 위한 컨트롤러 생성
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stepsController = TextEditingController();

  bool isEmptyDescription = false;
  bool isEmptyStep = false;

  // 이미지 선택을 위한 변수
  List<XFile> _images = [];
  final int _maxImages = 5;

  // 이미지 선택 함수
  Future<void> _pickImages() async {
    final ImagePicker _picker = ImagePicker();
    final List<XFile>? selectedImages = await _picker.pickMultiImage(); // 여러 이미지 선택
    _images = [];
    if (selectedImages != null) {
      if (_images.length + selectedImages.length > _maxImages) {
        // 선택한 이미지 개수가 최대 개수를 초과할 경우
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("최대 $_maxImages 개의 이미지만 선택할 수 있습니다."),
          ),
        );
      } else {
        setState(() {
          _images.addAll(selectedImages); // 선택한 이미지를 리스트에 추가
        });
      }
    }
  }

  onSubmit (){
    String contents = descriptionController.value.text;
    String step = stepsController.value.text;

    isEmptyDescription = (contents.isEmpty)?true:false;
    isEmptyStep  = (step.isEmpty)?true:false;

    if(isEmptyDescription || isEmptyStep){
      setState(() {});
    }else{
      print("저장");
      print(contents);
      print(step);
      print(_images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 버그 설명 텍스트 입력 필드
        const Text(
          "버그 설명:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        (isEmptyDescription)?const Text("필수 입력 필드 입니다.", style: TextStyle(color: Colors.red),):const SizedBox(height: 8),
        TextField(
          controller: descriptionController,
          decoration: const InputDecoration(
            hintText: "어떤 문제가 발생했나요? 버그를 설명해 주세요.",
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
          maxLength: 100,
          inputFormatters: [LengthLimitingTextInputFormatter(100)],
        ),

        const SizedBox(height: 16),

        // 버그 재현 단계
        const Text(
          "버그 재현 단계:",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        (isEmptyStep)?const Text("필수 입력 필드 입니다.", style: TextStyle(color: Colors.red),):const SizedBox(height: 8),
        TextField(
          controller: stepsController,
          decoration: const InputDecoration(
            hintText: "어떻게 하면 버그가 발생하나요?",
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
          maxLength: 100,
          inputFormatters: [LengthLimitingTextInputFormatter(100)],
        ),

        const SizedBox(height: 16),

        // 이미지 업로드 버튼
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(vertical: 16.0), // 패딩
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // 모서리 둥글기
                  ),
                ),

                onPressed: _pickImages, // 여러 이미지를 선택하는 함수
                icon: const Icon(Icons.image),
                label: Text("스크린샷 (선택) ${_images.length} / 5"),
              ),
            ),
          ],
        ),

        // 선택된 이미지가 있을 경우 표시
        if (_images.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: SingleChildScrollView( // 가로 스크롤 가능하게 설정
              scrollDirection: Axis.horizontal, // 가로 방향으로 스크롤
              child: Row(
                children: _images.map((image) {
                  return Container(
                    width: 100, // 이미지의 너비
                    height: 100, // 이미지의 높이
                    margin: const EdgeInsets.only(right: 8.0), // 이미지 간격
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey), // 테두리 추가
                    ),
                    child: Image.file(
                      File(image.path), // XFile를 File로 변환
                      fit: BoxFit.cover, // 이미지 크기 조절
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        (isEmptyStep || isEmptyDescription)?
        const Padding(
          padding: EdgeInsets.only(top: 16.0),
          child: Text("입력을 안한 필드가 있습니다.", style: TextStyle(color: Colors.red),),
        ):const SizedBox(height: 16,),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: (){
                onSubmit();
                //Navigator.pop(context);
              }, child: const Text("전송"),),
            const SizedBox(width:8,),
            ElevatedButton(onPressed: (){Navigator.pop(context);}, child: const Text("닫기"),)
          ],
        ),
      ],
    );
  }
}
