abstract class ProductEvent {}

class LoadProduct extends ProductEvent{
  final int page;
  final int limit;

  LoadProduct({
    required this.page,
    this.limit = 10
  });
}

class RefreshProductEvent extends ProductEvent{}