// ignore_for_file: avoid_print

import 'dart:io';
import 'package:e_commerce/constants.dart';
import 'package:e_commerce/core/services/data_service.dart';
import 'package:e_commerce/core/services/storage_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStoargeService implements StoarageService, DatabaseService {
  static late SupabaseClient _client;
  final supabasedata = Supabase.instance.client;

  static Future<void> initSupabase() async {
    final supabase = await Supabase.initialize(
      url: kSupabaseUrl,
      anonKey: kSupabaseKey,
    );
    _client = supabase.client;
  }

  static Future<void> createBucket(String bucketName) async {
    final buckets = await _client.storage.listBuckets();
    bool isBucketExists = buckets.any((bucket) => bucket.name == bucketName);

    if (!isBucketExists) {
      await _client.storage.createBucket(bucketName);
    }
  }

  @override
  Future<String> uploadFile(File file, String path) async {
    final fileName = file.uri.pathSegments.last;

    try {
      // رفع الملف إلى Supabase Storage
      final response = await _client.storage
          .from(kSupabaseBucket)
          .upload('$path/$fileName', file);

      // التحقق من نجاح العملية
      if (response.isEmpty) {
        throw Exception('Failed to upload file: Response is empty.');
      }

      // الحصول على الرابط العام للملف
      final publicUrl = _client.storage
          .from(kSupabaseBucket)
          .getPublicUrl('$path/$fileName');
      print('File uploaded successfully. Public URL: $publicUrl');
      return publicUrl;
    } catch (e) {
      // التعامل مع الأخطاء
      print('Error uploading file: $e');
      throw Exception('Failed to upload file: $e');
    }
  }

  @override
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  }) async {
    print('Inserting data into path: $path');
    print('Data: $data');

    try {
      // إدخال البيانات إلى Supabase
      final response = await _client.from(path).insert(data);

      // التأكد من أن الاستجابة ليست null أو فارغة
      if (response == null) {
        print('Response is null. Data added, but no response.');
        return; // تجاهل هذا الخطأ لأن البيانات أضيفت بنجاح
      }

      // التأكد من عدم وجود خطأ في الاستجابة
      if (response.error != null) {
        print('Error adding data: ${response.error?.message}');
        throw Exception('Failed to add data: ${response.error?.message}');
      } else {
        // البيانات أُضيفت بنجاح، نقوم باسترجاع السجل المضاف
        print('Data added successfully');

        // استعلام للحصول على البيانات التي تم إضافتها باستخدام id
        final selectResponse =
            await _client
                .from(path)
                .select()
                .eq('id', response.data[0]['id'])
                .single();

        // طباعة البيانات المسترجعة بعد الإدخال
        print('Fetched data after insert: $selectResponse');
      }
    } catch (e) {
      print('Error adding data to Supabase: $e');
      throw Exception('Failed to add data: $e');
    }
  }

  @override
  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  }) async {
    print('Checking if data exists in path: $path with ID: $documentId');

    final response =
        await _client.from(path).select().eq('id', documentId).maybeSingle();

    // التحقق من وجود البيانات
    if (response == null) {
      print('No data found for the given ID.');
      return false;
    }

    print('Data exists: $response');
    return true;
  }

  @override
  Future<dynamic> getData({
    String? docuementId,
    required String path,
    Map<String, dynamic>? query,
    required String role,
  }) async {
    print(
      'Fetching data from path: $path with ID: $docuementId, query: $query, and role: $role',
    );

    var queryBuilder = _client.from(path).select();

    // إذا كان هناك documentId، قم بتصفية البيانات بناءً عليه
    if (docuementId != null) {
      queryBuilder = queryBuilder.eq('id', docuementId);
    }

    // إذا كان هناك استعلام (query)، قم بتطبيق التصفية
    if (query != null) {
      if (query['orderBy'] != null) {
        var orderByField = query['orderBy'];
        var descending = query['descending'] ?? false;
        queryBuilder.order(orderByField, ascending: !descending);
      }
      if (query['limit'] != null) {
        var limit = query['limit'];
        queryBuilder.limit(limit);
      }
    }

    // تنفيذ الاستعلام
    final response = await queryBuilder;

    // التحقق من وجود البيانات
    if (response.isEmpty) {
      print('No data found for the given criteria.');
      throw Exception('No data found for the given criteria.');
    }

    print('\x1B[32m✅ Data fetched successfully: $response\x1B[0m');

    return response;
  }
}
