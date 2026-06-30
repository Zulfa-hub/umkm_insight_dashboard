import 'package:flutter/material.dart';
import '../models/product_item.dart';
import 'app_colors.dart';
import 'trend_indicator.dart';

class SalesListItem extends StatelessWidget {
  final ProductItem product;
  final int rank;

  const SalesListItem({
    super.key,
    required this.product,
    required this.rank,
  });

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
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          // Kotak ranking solid (gaya wireframe)
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: rank <= 3 ? AppColors.primary : AppColors.accentSoft,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$rank',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12,
                color: rank <= 3 ? Colors.white : AppColors.primary,
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Info produk
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.textDark,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Rp ${_formatCurrency(product.price)}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: AppColors.textMid,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(width: 1, height: 10, color: AppColors.border),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.inventory_outlined,
                      size: 11,
                      color: _isLowStock ? AppColors.stockLow : AppColors.textLight,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      'Stok ${product.stock}',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: _isLowStock ? FontWeight.w700 : FontWeight.w400,
                        color: _isLowStock ? AppColors.stockLow : AppColors.textMid,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Jumlah terjual + tren
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${product.sold} terjual',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              TrendIndicator(trend: product.trend),
            ],
          ),
        ],
      ),
    );
  }
}