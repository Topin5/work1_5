import 'package:flutter/material.dart';
import 'package:lesson1_5/domain/entity/product_entity.dart';

class WidgetProduct extends StatelessWidget {
  final ProductEntity product;
  const WidgetProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              
            },
          ),
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
                  '\$${product.price.toStringAsFixed(2)}',
                  style: TextStyle(fontWeight: FontWeight.bold,
                  color: Colors.green
                  ),
                  
                )
            ],
          ),)
        ],
      ),

    );
  }
}