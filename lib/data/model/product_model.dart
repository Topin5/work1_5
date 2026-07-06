import 'package:lesson1_5/domain/entity/product_entity.dart';

class ProductModel extends ProductEntity {
  const ProductModel({
    required super.id,
    required super.category,
    required super.desc,
    required super.image,
    required super.price,
    required super.title
  });

  factory ProductModel.fromJson(Map<String, dynamic>json){
    return ProductModel(
      id: json['id'] as int , 
      category: json['category'], 
      desc: json['description'], 
      image: json['image'] ?? "", 
      price: (json['price'] as num).toDouble(), 
      title: json['title']
      );
  }
}