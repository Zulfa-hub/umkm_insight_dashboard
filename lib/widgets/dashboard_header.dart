import 'package:flutter/material.dart';
import 'app_colors.dart';

class DashboardHeader extends StatelessWidget {
  final VoidCallback onRefresh;
  final bool isLoading;

  const DashboardHeader({
    super.key,
    required this.onRefresh,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 18, 16, 20),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 34,
                      height: 34,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.storefront_rounded,
                        color: AppColors.textDark,
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'UMKM Insight',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text(
                  'Dashboard Monitoring',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Monitoring Penjualan UMKM',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.75),
                  ),
                ),
              ],
            ),
          ),
          // Tombol refresh data
          Material(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: isLoading ? null : onRefresh,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: isLoading
                    ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
                    : const Icon(
                  Icons.refresh_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}