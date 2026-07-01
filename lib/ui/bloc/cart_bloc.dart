import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/domain/entity/cart_item_entity.dart';
import 'package:lesson1_5/ui/bloc/cart_event.dart';
import 'package:lesson1_5/ui/bloc/cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState>{
  final List<CartItemEntity> _items = [];

  CartBloc(): super(CartInitial()){
    on<AddCartEvent>(_onAdd);
    on<RemoveCartEvent>(_onRemove);
    on<ClearCartEvent>(_onClear);
  }
}