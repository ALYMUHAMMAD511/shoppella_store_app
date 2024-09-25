import 'package:dio/dio.dart';

import '../constants.dart';
import '../helper/api.dart';
import '../models/product_model.dart';

class AddProductService {
  Future<ProductModel> addProduct({
    required String title,
    required String price,
    required String description,
    required String image,
    required String category,
  }) async {
    Map<String, dynamic> data = await Api(Dio()).post(
      url: '${baseUrl}products',
      body: {
        kProductTitle: title,
        kProductPrice: price,
        kProductDescription: description,
        kProductImage: image,
        kProductCategory: category,
      },
    );

    // Ensure that data['product'] exists if it's wrapped in a 'data' object
    if (data.containsKey('product')) {
      return ProductModel.fromJson(data['product']);
    }

    return ProductModel.fromJson(data);
  }
}