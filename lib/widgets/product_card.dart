// lib/widgets/product_card.dart
// Kartu produk untuk GridView.builder - gaya flat minimal monokrom ungu

import 'package:flutter/material.dart';
import '../models/product_item.dart';
import 'app_colors.dart';
import 'trend_indicator.dart';

class ProductCard extends StatelessWidget {
  final ProductItem product;

  const ProductCard({super.key, required this.product});

  String _formatCurrency(double amount) {
    final formatted = amount.toStringAsFixed(0);
    final buffer = StringBuffer();
    final chars = formatted.split('').reversed.toList();
    for (int i = 0; i < chars.length; i++) {
      if (i > 0 && i % 3 == 0) buffer.write('.');
      buffer.write(chars[i]);
    }
    return buffer.toString().split('').reversed.join('');
  }

  bool get _isLowStock => product.stock <= 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Placeholder kotak solid (gaya wireframe, tanpa gambar asli)
          Container(
            width: double.infinity,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Icon(
                Icons.inventory_2_rounded,
                color: Colors.white.withOpacity(0.85),
                size: 22,
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Kategori + tren
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Text(
                  product.category,
                  style: const TextStyle(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
              TrendIndicator(trend: product.trend, compact: true),
            ],
          ),
          const SizedBox(height: 8),
          // Nama produk
          Expanded(
            child: Text(
              product.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColors.textDark,
                height: 1.3,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 4),
          // Harga
          Text(
            'Rp ${_formatCurrency(product.price)}',
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 6),
          // Stok & terjual
          Row(
            children: [
              Icon(
                Icons.inventory_outlined,
                size: 11,
                color: _isLowStock ? AppColors.stockLow : AppColors.textLight,
              ),
              const SizedBox(width: 3),
              Text(
                'Stok ${product.stock}',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: _isLowStock ? FontWeight.w700 : FontWeight.w500,
                  color: _isLowStock ? AppColors.stockLow : AppColors.textMid,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.sell_outlined, size: 11, color: AppColors.textLight),
              const SizedBox(width: 3),
              Text(
                '${product.sold}',
                style: const TextStyle(fontSize: 10, color: AppColors.textMid),
              ),
            ],
          ),
        ],
      ),
    );
  }
}