import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_item.dart';

class ApiService {
  // URL endpoint REST API dari MockAPI.io
  static const String baseUrl = 'https://6a3fc0589b6d371e838138a1.mockapi.io/products';

  // Mengambil seluruh data produk dari REST API menggunakan http.get()
  Future<List<ProductItem>> fetchProducts() async {
    try {
      final response = await http
          .get(Uri.parse(baseUrl))
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = jsonDecode(response.body);
        return jsonData
            .map((item) => ProductItem.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiException(
          'Server merespons dengan status ${response.statusCode}',
        );
      }
    } on http.ClientException {
      throw ApiException(
        'Tidak dapat terhubung ke server. Periksa koneksi internet Anda.',
      );
    } on FormatException {
      throw ApiException('Format data dari server tidak valid.');
    } catch (e) {
      if (e is ApiException) rethrow;
      throw ApiException('Terjadi kesalahan: ${e.toString()}');
    }
  }
}

// Exception khusus untuk error API agar mudah ditangani di UI
class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}