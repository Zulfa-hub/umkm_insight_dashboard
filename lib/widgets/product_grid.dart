import 'package:flutter/material.dart';
import '../models/product_item.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<ProductItem> products;
  final int crossAxisCount;

  const ProductGrid({
    super.key,
    required this.products,
    required this.crossAxisCount,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: crossAxisCount >= 3 ? 1.45 : 0.78,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}