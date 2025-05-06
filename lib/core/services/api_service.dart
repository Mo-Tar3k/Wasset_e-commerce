import 'package:dio/dio.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart';
import 'package:flutter/material.dart';
import 'data_service.dart';

class ApiService implements DatabaseService {
  static const String baseUrl = kBaseUrl;
  final Dio _dio;

  ApiService() : _dio = Dio(BaseOptions(baseUrl: baseUrl));

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    try {
      final response = await _dio.post(path, data: data);
      if (response.statusCode != 200) {
        throw Exception('Failed to add data: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error adding data: $e');
    }
  }

  @override
  Future<dynamic> getData({
    required String path,
    String? docuementId,
    required String role,
    Map<String, dynamic>? query,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: query,
        options: Options(headers: {'Role': role}),
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to get data: ${response.data}');
      }

      final data = response.data;

      // 🛠️ لو الداتا فيها products → رجّع اللي جوهها بس
      if (data is Map<String, dynamic> && data.containsKey('products')) {
        return List<Map<String, dynamic>>.from(data['products']);
      }

      return data; // رجّع عادي لو مش منتجات
    } catch (e) {
      throw Exception('Error getting data: $e');
    }
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  }) async {
    try {
      final response = await _dio.get('$path/$documentId');
      if (response.statusCode == 404) {
        return false;
      } else if (response.statusCode != 200) {
        throw Exception('Failed to check data existence: ${response.data}');
      }
      return true;
    } catch (e) {
      throw Exception('Error checking data existence: $e');
    }
  }

  Future<Map<String, dynamic>> registerUser(
    Map<String, dynamic> userData,
  ) async {
    try {
      final response = await _dio.post('auth/register', data: userData);
      if (response.statusCode != 200) {
        throw Exception('Failed to register user: ${response.data}');
      }
      return response.data;
    } catch (e) {
      throw Exception('Error registering user: $e');
    }
  }

  Future<List<dynamic>> getProductReviews(int productId) async {
    try {
      final response = await _dio.get('Review/GetReviews/$productId');

      if (response.statusCode == 200) {
        return response.data;
      } else if (response.statusCode == 404) {
        return [];
      } else {
        throw Exception('Failed to load reviews: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error loading reviews: $e');
    }
  }

  Future<void> addProductReview({
    required String comment,
    required int rating,
    required int productId,
    required DateTime date,
  }) async {
    try {
      final token = Prefs.getString('token');
      debugPrint('\x1B[32m🔐 Token being used: $token\x1B[0m');

      final response = await _dio.post(
        'Review/add',
        data: {
          "comment": comment,
          "rating": rating,
          "productId": productId,
          "date": date.toIso8601String(),
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
          validateStatus: (_) => true,
        ),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add review: ${response.data}');
      }
    } catch (e) {
      throw Exception('Error adding review: $e');
    }
  }
}
