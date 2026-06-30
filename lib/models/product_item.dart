enum TrendDirection { up, down, flat }

class ProductItem {
  final String id;
  final String name;
  final String category;
  final double price;
  final int stock;
  final int sold;
  final TrendDirection trend;

  const ProductItem({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.sold,
    required this.trend,
  });

  // Factory constructor untuk parsing JSON dari REST API
  factory ProductItem.fromJson(Map<String, dynamic> json) {
    return ProductItem(
      id: json['id']?.toString() ?? '',
      name: json['name'] as String? ?? 'Produk Tanpa Nama',
      category: json['category'] as String? ?? 'Lainnya',
      price: _parseDouble(json['price']),
      stock: _parseInt(json['stock']),
      sold: _parseInt(json['sold']),
      trend: _parseTrend(json['trend']),
    );
  }

  // Helper parsing aman, karena API kadang mengirim angka sebagai String
  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }

  static int _parseInt(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString()) ?? 0;
  }

  static TrendDirection _parseTrend(dynamic value) {
    final str = value?.toString().toLowerCase().trim() ?? '';
    if (str == 'up' || str == 'naik') return TrendDirection.up;
    if (str == 'down' || str == 'turun') return TrendDirection.down;
    return TrendDirection.flat;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'stock': stock,
      'sold': sold,
      'trend': trend == TrendDirection.up
          ? 'up'
          : trend == TrendDirection.down
          ? 'down'
          : 'flat',
    };
  }

  @override
  String toString() {
    return 'ProductItem(id: $id, name: $name, price: $price, sold: $sold)';
  }
}