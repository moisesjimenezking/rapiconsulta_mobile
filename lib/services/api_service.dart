import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://rapiconsulta-proxy.jimenezsmoises27.workers.dev';

  static Future<Map<String, dynamic>> consultDni(
      String tipo, String numero) async {
    try {
      final uri = Uri.parse('$baseUrl/consult_dni?tipo=$tipo&numero=$numero');
      final response = await http.get(uri).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw Exception('Tiempo de espera agotado. Verifica tu conexión.');
        },
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['data'] != null) {
        return data;
      }
      throw Exception(
          data['data']?['error']?['message'] ?? 'Error en la consulta');
    } on SocketException {
      throw Exception(
          'Sin conexión a internet. Verifica tu red e intenta de nuevo.');
    } on FormatException {
      throw Exception('Respuesta inválida del servidor.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error inesperado: $e');
    }
  }

  static Future<Map<String, dynamic>> consultRif(
      String tipo, String numero) async {
    try {
      final uri =
          Uri.parse('$baseUrl/consulta-rif?tipo=$tipo&numero=$numero');
      final response = await http.get(uri).timeout(
        const Duration(seconds: 15),
        onTimeout: () {
          throw Exception('Tiempo de espera agotado. Verifica tu conexión.');
        },
      );
      final data = json.decode(response.body);
      if (response.statusCode == 200 && data['data'] != null) {
        return data;
      }
      throw Exception(
          data['data']?['error']?['message'] ?? 'Error en la consulta');
    } on SocketException {
      throw Exception(
          'Sin conexión a internet. Verifica tu red e intenta de nuevo.');
    } on FormatException {
      throw Exception('Respuesta inválida del servidor.');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error inesperado: $e');
    }
  }
}
