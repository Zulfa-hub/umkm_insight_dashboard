// lib/widgets/metric_card.dart
// Custom Widget: Kartu metrik untuk ringkasan analisis - gaya flat minimal

import 'package:flutter/material.dart';
import 'app_colors.dart';

class MetricCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const MetricCard({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Icon(icon, color: Colors.white, size: 17),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 15,
              color: AppColors.textDark,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.textMid,
              fontWeight: FontWeight.w500,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}