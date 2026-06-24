class ProductEntity{
  final int id;
  final String title;
  final String desc;
  final String image;
  final String category;
  final double price;

  const ProductEntity({
    required this.category,
    required this.desc,
    required this.id,
    required this.image,
    required this.price,
    required this.title
  });
}


