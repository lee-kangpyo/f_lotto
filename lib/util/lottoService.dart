import 'package:dio/dio.dart';

class LottoService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=",  // 타사 API의 기본 URL
    connectTimeout: const Duration(milliseconds: 5000),  // 연결 타임아웃 시간 (5초)
    receiveTimeout: const Duration(milliseconds: 3000),  // 응답 타임아웃 시간 (3초)
  ));

  // GET 요청을 처리하는 함수
  Future<Response> getWinningNumber(String roundNo) async {
    try {
      final response = await _dio.get(roundNo);
      return response;
    } catch (e) {
      // 에러 처리
      rethrow;
    }
  }
}
