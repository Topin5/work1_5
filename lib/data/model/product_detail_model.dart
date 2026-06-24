import 'package:lesson1_5/domain/entity/prodict_detail_entity.dart';

class ProductDetailModel extends ProductDetailEntity{

   ProductDetailModel({
    required super.category,
    required super.desc,
    required super.id,
    required super.image,
    required super.price,
    required super.title
  });

  factory ProductDetailModel.fromJson(Map<String, dynamic>json){
    return ProductDetailModel(
      category: json['category'], 
      desc: json['desc'], 
      id: json['id'], 
      image: json['image'], 
      price: json['price'], 
      title: json['title']
      );
  }
}