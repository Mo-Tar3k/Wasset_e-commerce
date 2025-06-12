import 'dart:io';
import 'package:dio/dio.dart';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/services/shared_preferences_singleton.dart';

class ApiServiceDashboard {
  final Dio _dio;

  ApiServiceDashboard({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: kBaseUrl,
              connectTimeout: const Duration(seconds: 15),
              receiveTimeout: const Duration(seconds: 15),
            ),
          );

  Future<bool> validateImage(File image) async {
    try {
      if (!image.existsSync()) {
        throw CustomException('Image file does not exist: ${image.path}');
      }

      // بناء الـ FormData بشكل صحيح مع إرسال الصورة عبر MultipartFile
      final formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(
          image.path,
          filename: image.uri.pathSegments.last, // استخدم اسم الصورة هنا
        ),
      });

      final response = await _dio.post(
        'https://89e2-102-189-85-35.ngrok-free.app/predict',
        data: formData,
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      // طباعة الرد فقط من الـ API
      print('Validation response: ${response.data}');

      if (response.data != null &&
          response.data['overall_status'] == 'accepted') {
        return true;
      } else {
        return false;
      }
    } on DioError catch (e) {
      print('DioError response: ${e.response?.data}');
      throw CustomException(
        // 'Failed to validate image. Status code: ${e.response?.statusCode}, Message: ${e.response?.data}',
        'Failed to validate image.',
      );
    } catch (e) {
      print('Unexpected error: $e');
      throw CustomException(
        'Unexpected error occurred during image validation.',
      );
    }
  }

  Future<Map<String, dynamic>> addProduct({
    required File image,
    required String name,
    required String description,
    required double price,
    required int category,
  }) async {
    try {
      final token = Prefs.getString('token');
      final isValidImage = await validateImage(image);
      if (!isValidImage) {
        throw CustomException('The image is not suitable for upload.');
      }

      final formData = FormData.fromMap({
        'Name': name,
        'Description': description,
        'Price': price.toString(),
        'category': category.toString(),
        'image': await MultipartFile.fromFile(image.path),
      });

      final response = await _dio.post(
        'Product/AddProduct',
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return response.data;
    } on DioError catch (e) {
      throw _handleDioError(e, 'Failed to add product');
    }
  }

  Future<Map<String, dynamic>> post({
    required String path,
    required Map<String, dynamic> data,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioError catch (e) {
      throw _handleDioError(e, 'Failed to post data');
    }
  }

  Future<String> uploadFile(File file, String path) async {
    try {
      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(file.path),
      });

      final response = await _dio.post(
        '${_dio.options.baseUrl}$path',
        data: formData,
      );

      if (response.data != null && response.data['url'] != null) {
        return response.data['url'];
      } else {
        throw CustomException('Invalid response format: ${response.data}');
      }
    } on DioError catch (e) {
      throw _handleDioError(e, 'Failed to upload file');
    }
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    try {
      final response = await _dio.get('Category/Categories');
      return List<Map<String, dynamic>>.from(response.data);
    } on DioError catch (e) {
      throw _handleDioError(e, 'Failed to fetch categories');
    }
  }

  CustomException _handleDioError(DioError e, String message) {
    if (e.response != null) {
      return CustomException(
        '$message. Status code: ${e.response?.statusCode}, Message: ${e.response?.data}',
      );
    } else {
      return CustomException('$message. Error: ${e.message}');
    }
  }
}

class CustomException implements Exception {
  final String message;
  CustomException(this.message);

  @override
  String toString() => message;
}
