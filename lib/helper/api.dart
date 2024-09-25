import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Api
{
  final Dio dio;

  Api(this.dio);

  Future<dynamic> get({
    required String url,
    @required String? token,
  }) async
  {
    Map<String, String> headers = {};
    if(token != null)
    {
      headers.addAll(
        {'Authorization': 'Bearer $token'},
      );
    }
    try
    {
      Response response = await dio.get(
          url,
          options: Options(headers: headers));
      if (kDebugMode)
      {
        print('url = $url  token = $token ');
      }
      return response.data;

    }
    on DioException catch(e)
    {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>> post({required String url, required Map<String, dynamic> body}) async {
    try {
      Response response = await dio.post(url, data: body);
      if (response.statusCode == 200) {
        // Ensure the response data is a Map<String, dynamic>
        if (response.data is Map<String, dynamic>) {

          return response.data;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      throw Exception('Error in POST request: $e');
    }
  }

  Future<dynamic> put({
    required String url,
    required body,
    String? token, // Allow token to be null
  }) async {
    try {
      Map<String, String> headers = {
        'Content-Type': 'application/json', // Changed to application/json
      };
      if (token != null) {
        headers.addAll({'Authorization': 'Bearer $token'});
      }
      Response response = await dio.put( // Use dio.put instead of dio.post
        url,
        data: jsonEncode(body), // Encode the body as JSON
        options: Options(headers: headers),
      );
      if (kDebugMode) {
        print('PUT Request: url = $url, body = $body, headers = $headers, response = ${response.data}');
      }
      return response.data;
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError: ${e.response?.statusCode} - ${e.response?.data}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Error in PUT request: $e');
      }
      rethrow;
    }
  }
}