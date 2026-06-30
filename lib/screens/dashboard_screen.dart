import 'package:flutter/material.dart';
import '../models/product_item.dart';
import '../services/api_service.dart';
import '../widgets/app_colors.dart';
import '../widgets/metric_card.dart';
import '../widgets/product_grid.dart';
import '../widgets/sales_list_item.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final ApiService _apiService = ApiService();

  late Future<List<ProductItem>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _productsFuture = _apiService.fetchProducts();
  }

  void _refreshData() {
    setState(() {
      _productsFuture = _apiService.fetchProducts();
    });
  }

  // ===== Analisis data berdasarkan data API =====

  double _calculateAveragePrice(List<ProductItem> products) {
    if (products.isEmpty) return 0;
    final total = products.fold(0.0, (sum, p) => sum + p.price);
    return total / products.length;
  }

  int _calculateTotalSold(List<ProductItem> products) {
    return products.fold(0, (sum, p) => sum + p.sold);
  }

  int _countTrendUp(List<ProductItem> products) {
    return products.where((p) => p.trend == TrendDirection.up).length;
  }

  int _countTrendDown(List<ProductItem> products) {
    return products.where((p) => p.trend == TrendDirection.down).length;
  }

  List<ProductItem> _sortBySold(List<ProductItem> products) {
    final sorted = List<ProductItem>.from(products);
    sorted.sort((a, b) => b.sold.compareTo(a.sold));
    return sorted;
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: SafeArea(
        top: false,
        child: FutureBuilder<List<ProductItem>>(
          future: _productsFuture,
          builder: (context, snapshot) => _buildBody(snapshot),
        ),
      ),
    );
  }

  // AppBar standar Material, menggantikan header card sebelumnya
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.textDark,
      elevation: 0,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      titleSpacing: 20,
      title: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.storefront_rounded, color: Colors.white, size: 16),
          ),
          const SizedBox(width: 10),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'UMKM Insight',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              Text(
                'Monitoring Penjualan',
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textLight,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh_rounded, size: 21),
          color: AppColors.textMid,
          onPressed: _refreshData,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody(AsyncSnapshot<List<ProductItem>> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return _buildLoadingState();
    }
    if (snapshot.hasError) {
      return _buildErrorState(snapshot.error.toString());
    }
    final products = snapshot.data ?? [];
    if (products.isEmpty) {
      return _buildEmptyState();
    }
    return _buildSuccessState(products);
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 36,
            height: 36,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
              strokeWidth: 2.5,
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Memuat data produk...',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textMid,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.danger.withOpacity(0.08),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(Icons.wifi_off_rounded, size: 28, color: AppColors.danger),
            ),
            const SizedBox(height: 18),
            const Text(
              'Gagal Memuat Data',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              errorMessage.replaceAll('ApiException: ', ''),
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textMid, fontSize: 12, height: 1.5),
            ),
            const SizedBox(height: 22),
            ElevatedButton.icon(
              onPressed: _refreshData,
              icon: const Icon(Icons.refresh_rounded, size: 17),
              label: const Text('Muat Ulang'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 13),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 48, color: AppColors.textLight),
          const SizedBox(height: 14),
          const Text(
            'Belum Ada Data Produk',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textMid,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState(List<ProductItem> products) {
    final averagePrice = _calculateAveragePrice(products);
    final totalSold = _calculateTotalSold(products);
    final trendUpCount = _countTrendUp(products);
    final trendDownCount = _countTrendDown(products);
    final bestSellers = _sortBySold(products);

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth >= 600;
        final gridColumns = isTablet ? 3 : 2;

        return RefreshIndicator(
          onRefresh: () async => _refreshData(),
          color: AppColors.primary,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('Ringkasan Analisis'),
                const SizedBox(height: 10),
                isTablet
                    ? _buildMetricsRow(products, averagePrice, totalSold, trendUpCount, trendDownCount)
                    : _buildMetricsWrap(products, averagePrice, totalSold, trendUpCount, trendDownCount),
                const SizedBox(height: 26),

                _buildSectionTitle('Galeri Produk', trailing: '${products.length} produk'),
                const SizedBox(height: 12),
                ProductGrid(products: products, crossAxisCount: gridColumns),
                const SizedBox(height: 26),

                _buildSectionTitle('Produk Terlaris'),
                const SizedBox(height: 12),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: bestSellers.length,
                  itemBuilder: (context, index) {
                    return SalesListItem(
                      product: bestSellers[index],
                      rank: index + 1,
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title, {String? trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        if (trailing != null)
          Text(
            trailing,
            style: const TextStyle(fontSize: 12, color: AppColors.textLight),
          ),
      ],
    );
  }

  Widget _buildMetricsWrap(
      List<ProductItem> products,
      double averagePrice,
      int totalSold,
      int trendUp,
      int trendDown,
      ) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.35,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: _buildMetricCards(products, averagePrice, totalSold, trendUp, trendDown),
    );
  }

  Widget _buildMetricsRow(
      List<ProductItem> products,
      double averagePrice,
      int totalSold,
      int trendUp,
      int trendDown,
      ) {
    final cards = _buildMetricCards(products, averagePrice, totalSold, trendUp, trendDown);
    return Row(
      children: cards
          .map((card) => Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: SizedBox(height: 126, child: card),
        ),
      ))
          .toList(),
    );
  }

  List<Widget> _buildMetricCards(
      List<ProductItem> products,
      double averagePrice,
      int totalSold,
      int trendUp,
      int trendDown,
      ) {
    return [
      MetricCard(
        label: 'Total Produk',
        value: '${products.length}',
        icon: Icons.inventory_2_rounded,
      ),
      MetricCard(
        label: 'Rata-Rata Harga',
        value: 'Rp ${_formatCurrency(averagePrice)}',
        icon: Icons.payments_rounded,
      ),
      MetricCard(
        label: 'Total Terjual',
        value: '$totalSold pcs',
        icon: Icons.shopping_bag_rounded,
      ),
      MetricCard(
        label: 'Tren Naik / Turun',
        value: '$trendUp / $trendDown',
        icon: Icons.show_chart_rounded,
      ),
    ];
  }
}