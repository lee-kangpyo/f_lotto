import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';

class Http {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: dotenv.env['url']!,
    connectTimeout: const Duration(milliseconds: 5000),
    receiveTimeout: const Duration(milliseconds: 3000),
  ));

  // GET 요청을 처리하는 함수
  Future<Response> get(String url, Map<String, dynamic>? params) async {
    try {
      final response = await _dio.get(url, queryParameters: params,);
      return response;
    } catch (e) {
      if (e is DioException && e.response != null) {
        // DioException이 발생하고 응답이 있을 경우 해당 응답 리턴
        return Response(
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
          data: e.response?.data,
        );
      } else {
        // 응답이 없거나 다른 에러 발생 시 기본 404 리턴
        return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 404,
          data: {'message': '알수없는 오류 발생'},
        );
      }
    }
  }
  // POST 요청을 처리하는 함수
  Future<Response> post(String url, Map<String, dynamic>? params) async {
    try {
      final response = await _dio.post(url, data: params);
      return response;
    } catch (e) {
      if (e is DioException && e.response != null) {
        // DioException이 발생하고 응답이 있을 경우 해당 응답 리턴
        return Response(
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
          data: e.response?.data,
        );
      } else {
        // 응답이 없거나 다른 에러 발생 시 기본 404 리턴
        return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 404,
          data: {'message': '알수없는 오류 발생'},
        );
      }
    }
  }
  // POST 요청 (이미지 포함)
  Future<Response> postImages(String url, List<XFile> images, Map<String, String>? params) async {
    try {
      // 이미지 파일들을 FormData에 추가
      List<MultipartFile> imageFiles = [];

      // 이미지 압축 기능 추가
      for (var image in images) {
        // 압축할 파일 경로
        String filePath = image.path;

        // 이미지 압축
        List<int>? compressedData = await FlutterImageCompress.compressWithFile(
          filePath,
          // minWidth: 800,
          // minHeight: 600,
          quality: 70,
          format: CompressFormat.jpeg,
        );

        if (compressedData != null) {
          // 고유 파일 이름 생성
          String uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}_${image.name}';

          // 압축된 데이터를 MultipartFile로 변환
          var compressedFile = MultipartFile.fromBytes(
            compressedData,
            filename: uniqueFileName,
            contentType: DioMediaType('image', 'jpeg'), // JPEG 형식 설정
          );

          imageFiles.add(compressedFile);
        }
      }

      // 이미지 변화
      // for (var image in images) {
      //   String uniqueFileName = '${DateTime.now().millisecondsSinceEpoch}_${Random().nextInt(10000)}_${image.name}';
      //   var file = await MultipartFile.fromFile(image.path, filename: uniqueFileName);
      //   imageFiles.add(file);
      // }

      // FormData 생성
      FormData formData = FormData.fromMap({
        ...?params,
        'images': imageFiles,
      });

      final response = await _dio.post(url, data: formData);
      return response;
    } catch (e) {
      print(e);
      if (e is DioException && e.response != null) {
        // DioException이 발생하고 응답이 있을 경우 해당 응답 리턴
        return Response(
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
          data: e.response?.data,
        );
      } else {
        // 응답이 없거나 다른 에러 발생 시 기본 404 리턴
        return Response(
          requestOptions: RequestOptions(path: url),
          statusCode: 404,
          data: {'message': '알수없는 오류 발생'},
        );
      }
    }
  }
}
