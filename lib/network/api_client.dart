import 'package:dio/dio.dart';

import 'api_exception.dart';

class ApiClient{
  final Dio _dio = Dio();

  Future<Map<String , dynamic>> get(String url) async{
    try{
      final response =  await _dio.get(url);

      if(response.statusCode == 200){
        return response.data;
      }else{
        throw ApiException(
          message : "Something went wrong",
          statusCode : response.statusCode ?? 0
        );
      }
    }on DioException catch (e){
      throw ApiException(
        message : e.message ?? "Network error",
        statusCode : e.response?.statusCode ?? 0
      );
    }
  }

}