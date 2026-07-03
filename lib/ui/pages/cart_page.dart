import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/core/ext/ext.dart';
import 'package:lesson1_5/ui/bloc/cart_bloc.dart';
import 'package:lesson1_5/ui/bloc/cart_event.dart';
import 'package:lesson1_5/ui/bloc/cart_state.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Корзина'),
        actions: [
          IconButton(
            onPressed: () => context.read<CartBloc>().add(ClearCartEvent()),
            icon: Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartInitial ||
              (state is CartUpdated && state.items.isEmpty)) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 75),
                  SizedBox(height: 16),
                  Text(
                    'Корзина пуста',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            );
          }
          if (state is CartUpdated) {
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: state.items.length,
                    itemBuilder: (context, index) {
                      final item = state.items[index];
                      return ListTile(
                        leading: Image.network(
                          item.product.image,
                          width: 50,
                          height: 50,
                          fit: BoxFit.contain,
                        ),
                        title: Text(
                          item.product.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          '\$${item.product.price.toStringAsFixed(2)}',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () => context.read<CartBloc>().add(
                                RemoveCartEvent(item.product.id),
                              ),
                              icon: Icon(Icons.remove),
                            ),
                            Text(
                              '${item.quantity}',
                              style: TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              onPressed: () => context.read<CartBloc>().add(
                                AddCartEvent(item.product),
                              ),
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: Offset(0, -3)
                    )
                    ]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('итого: ${state.totalCount} количество товаров',
                      style: TextStyle(fontSize: 16)),
                      Text(state.totalPrice.asCurrency, style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold,
                        color: Colors.green))
                    ],
                  ),
                )
              ],
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
