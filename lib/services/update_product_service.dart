import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../constants.dart';
import '../helper/api.dart';

class UpdateProductService {
  Future<void> updateProduct({
    required int id,
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
  }) async {
    try {
      final dio = Dio();
      final api = Api(dio);
      final response = await api.put(
        url: '${baseUrl}products/$id',
        body: {
          kProductTitle: title,
          kProductPrice: price,
          kProductDescription: description,
          kProductImage: image,
          kProductCategory: category,
        },
      );

      // Check for successful response
      if (response != null) {
        if (kDebugMode) {
          print('Product updated successfully.');
        }
      } else {
        throw Exception('Failed to update the product.');
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioError: ${e.response?.statusCode} - ${e.response?.data}');
      }
      rethrow;
    } catch (e) {
      if (kDebugMode) {
        print('Error in update: $e');
      }
      rethrow;
    }
  }
}