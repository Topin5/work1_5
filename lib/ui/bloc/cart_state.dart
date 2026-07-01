import 'package:lesson1_5/domain/entity/cart_item_entity.dart';

abstract class CartState {}

class CartInitial extends CartState{}

class CartUpdated extends CartState{
  final List<CartItemEntity> items;
  final double totalPrice;
  final int totalCount;

  CartUpdated(this.items)
      :totalPrice = items.fold(
        0, (sum, item) => sum + item.product.price * item.quantity),
      totalCount = items.fold(0, (sum, item) => sum + item.quantity);  
}

