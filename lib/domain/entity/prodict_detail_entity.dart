class ProductDetailEntity{
  final String title;
  final int id;
  final double price;
  final String desc;
  final String category;
  final String image;

  ProductDetailEntity({
    required this.category,
    required this.desc,
    required this.id,
    required this.image,
    required this.price,
    required this.title
  });
}