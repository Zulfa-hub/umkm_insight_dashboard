// lib/widgets/trend_indicator.dart
// Custom Widget: Indikator tren naik/turun/stabil - gaya flat minimal

import 'package:flutter/material.dart';
import '../models/product_item.dart';
import 'app_colors.dart';

class TrendIndicator extends StatelessWidget {
  final TrendDirection trend;
  final bool compact;

  const TrendIndicator({
    super.key,
    required this.trend,
    this.compact = false,
  });

  IconData get _icon {
    switch (trend) {
      case TrendDirection.up:
        return Icons.arrow_upward_rounded;
      case TrendDirection.down:
        return Icons.arrow_downward_rounded;
      case TrendDirection.flat:
        return Icons.remove_rounded;
    }
  }

  Color get _color {
    switch (trend) {
      case TrendDirection.up:
        return AppColors.primary;
      case TrendDirection.down:
        return AppColors.danger;
      case TrendDirection.flat:
        return AppColors.neutral;
    }
  }

  String get _label {
    switch (trend) {
      case TrendDirection.up:
        return 'Naik';
      case TrendDirection.down:
        return 'Turun';
      case TrendDirection.flat:
        return 'Stabil';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 6 : 9,
        vertical: compact ? 3 : 5,
      ),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, color: _color, size: compact ? 11 : 13),
          if (!compact) const SizedBox(width: 4),
          if (!compact)
            Text(
              _label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _color,
              ),
            ),
        ],
      ),
    );
  }
}