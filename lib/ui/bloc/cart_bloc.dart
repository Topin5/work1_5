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

  void _onAdd(AddCartEvent event, Emitter<CartState> emit){
    final index = _items.indexWhere((i)=> i.product.id == event.product.id);
    if(index >= 0){
      _items[index] = _items[index].copyWith(quantity: _items[index].quantity+1);
    }else{
      _items.add(CartItemEntity(product: event.product, quantity: 1));
    }
    emit(CartUpdated(List.from(_items)));
  }

  void _onRemove(RemoveCartEvent event, Emitter<CartState>emit){
    final index = _items.indexWhere((i)=> i.product.id == event.productId);
    if(index >= 0){
      if(_items[index].quantity > 1){
        _items[index] = _items[index].copyWith(quantity: _items[index].quantity - 1);
      }else {
        _items.removeAt(index);
      }
    }
    emit(CartUpdated(List.from(_items)));
  }

  void _onClear(ClearCartEvent event, Emitter<CartState>emit){
    _items.clear();
    emit(CartUpdated([]));
  }
}