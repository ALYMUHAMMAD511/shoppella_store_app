import 'package:dio/dio.dart';
import 'package:shopella_store_app/helper/api.dart';
import 'package:shopella_store_app/models/product_model.dart';
import '../constants.dart';

class GetProductByCategoryService
{
  Future<List<ProductModel>> getProductsByCategory({required String categoryName}) async
  {

    // ignore: missing_required_param
    List<dynamic> data = await Api(Dio()).get(url: '${baseUrl}products/category/$categoryName');

    List<ProductModel> products = [];

    for(int i = 0; i < data.length; i++)
    {
      products.add(
        ProductModel.fromJson(data[i]),
      );
    }
    return products;
  }
}