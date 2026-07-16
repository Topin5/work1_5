import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson1_5/core/ext/ext.dart';
import 'package:lesson1_5/domain/entity/product_entity.dart';
import 'package:lesson1_5/ui/bloc/cart_bloc.dart';
import 'package:lesson1_5/ui/bloc/cart_event.dart';
import 'package:lesson1_5/ui/pages/detail_page_products.dart';

class WidgetProduct extends StatelessWidget {
  final ProductEntity product;
  const WidgetProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    
    return  GestureDetector(
      onTap: () {
        Navigator.push(context,
        MaterialPageRoute(builder: (_)=> DetailPageProducts(productId: product.id))
         );
      },
        child:  Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image.network(
                product.image,
                width: double.infinity,
                fit: BoxFit.contain,
              )
              ),
              Padding(padding: EdgeInsets.all(9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(height: 4,),
                    Text(
                      product.price.asCurrency,
                      style: TextStyle(fontWeight: FontWeight.bold,
                      color: Colors.green
                      ),                      
                    ),
                    SizedBox(height: 9),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(onPressed:(){
                        context.read<CartBloc>().add(AddCartEvent(product));
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${product.title} добавлен в корзину'),
                          duration: Duration(seconds: 1)),
                        );
                      }, child: Icon(Icons.shopping_cart)),
                    )
                ],
              ),)
            ],
          ),
        )           
    );
  }
}