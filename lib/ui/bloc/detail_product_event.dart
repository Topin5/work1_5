abstract class DetailProductEvent {}

class LoadDetailProduct extends DetailProductEvent{
  final int productId;
  LoadDetailProduct(this.productId);
}

class RefreshDetailProduct extends DetailProductEvent{
  final int productId;
  RefreshDetailProduct(this.productId);
}