import 'package:adm_botecaria/modules/home/models/products_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../asp/actions.dart';
import 'product_card_image.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.height,
    required this.width,
    required this.product,
  });

  final double height;
  final double width;
  final Product product;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.15,
      width: double.maxFinite,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            top: 0,
            bottom: 0,
            child: CircleAvatar(
              backgroundColor: Theme.of(context).colorScheme.surfaceDim,
              radius: 50,
              child: Hero(
                tag: product.documentId!,
                child: ProductCardImage(product: product),
              ),
            ),
          ),
          Positioned(
            height: height * 0.15,
            right: 0,
            left: width * 0.2,
            child: Card(
              elevation: 5,
              child: InkWell(
                onTap: () {
                  setSelectedProductAction(product);
                  context.go('/detailProduct');
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          product.cProd,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
