import 'package:shopella_store_app/constants.dart';

class ProductModel
{
  final dynamic id;
  final String title;
  final dynamic price;
  final String description;
  final String category;
  final String image;
  final RatingModel? rating;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData)
  {
    return ProductModel(
        id: jsonData[kProductId],
        title: jsonData[kProductTitle],
        price: jsonData[kProductPrice],
        description : jsonData[kProductDescription],
        category: jsonData[kProductCategory],
        image: jsonData[kProductImage],
        rating: jsonData[kProductRating] == null
            ? null
            : RatingModel.fromJson(jsonData[kProductRating]),
    );
  }
}

  class RatingModel {
  final dynamic rate;
  final int count;

  RatingModel({required this.rate, required this.count});

  factory RatingModel.fromJson(jsonData) {
  return RatingModel(
      rate: jsonData[kProductRatingRate],
      count: jsonData[kProductRatingCount]);
  }
  }
