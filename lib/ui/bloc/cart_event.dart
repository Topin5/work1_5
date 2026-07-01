
import 'package:lesson1_5/domain/entity/product_entity.dart';

abstract class CartEvent {}

class AddCartEvent extends CartEvent{
  final ProductEntity product;
  AddCartEvent(this.product);

}

class RemoveCartEvent extends CartEvent{
  final int productId;
  RemoveCartEvent(this.productId);
}

class ClearCartEvent extends CartEvent{}
