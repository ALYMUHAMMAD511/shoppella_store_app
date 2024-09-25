import 'package:dio/dio.dart';
import 'package:shopella_store_app/helper/api.dart';
import '../constants.dart';

class GetAllCategoriesService
{
  Future<List<dynamic>> getAllCategories() async
  {
    // ignore: missing_required_param
    List<dynamic> data = await Api(Dio()).get(url: '${baseUrl}products/categories');

    return data;
  }
}