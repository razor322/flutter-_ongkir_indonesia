import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

abstract class ApiService {
  Future<dynamic> get(String url,
      {Map<String, String>? queryParameters}) async {
    try {
      final uri = Uri.parse(url).replace(queryParameters: queryParameters);
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw HttpException(
            'Failed to load data with status code: ${response.statusCode}');
      }
    } on http.ClientException catch (e) {
      // Menangani kesalahan terkait permintaan HTTP (misalnya koneksi jaringan gagal)
      print('ClientException: $e');
      throw Exception("Connection Failed !");
    } on FormatException catch (e) {
      // Menangani kesalahan parsing JSON
      print('FormatException: $e');
      throw Exception("Invalid response format!");
    } catch (e) {
      // Menangani error umum lainnya
      print('General Exception: $e');
      throw Exception("An unexpected error occurred");
    }
  }
}
